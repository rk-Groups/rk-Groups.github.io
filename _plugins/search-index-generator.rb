---
# Jekyll plugin to generate search index for Lunr.js
---

require 'json'

module Jekyll
  class SearchIndexGenerator < Generator
    safe true
    priority :low

    def generate(site)
      # Create search index
      search_index = []

      site.pages.each do |page|
        next if page.data['exclude_from_search'] == true
        next unless page.data['title'] && page.content

        # Extract text content (remove HTML tags and front matter)
        content = page.content
                   .gsub(/<script.*?<\/script>/m, '') # Remove scripts
                   .gsub(/<style.*?<\/style>/m, '')   # Remove styles
                   .gsub(/<[^>]+>/, ' ')             # Remove HTML tags
                   .gsub(/\s+/, ' ')                 # Normalize whitespace
                   .strip

        # Skip if content is too short
        next if content.length < 50

        search_index << {
          'id' => page.url,
          'title' => page.data['title'],
          'url' => page.url,
          'content' => content[0..1000], # Limit content length
          'description' => page.data['description'] || page.data['excerpt'],
          'category' => get_category(page.url)
        }
      end

      # Write search index to JSON file
      search_data = {
        'pages' => search_index,
        'total' => search_index.length,
        'generated' => Time.now.strftime('%Y-%m-%d %H:%M:%S')
      }

      File.write(File.join(site.dest, 'search-index.json'), JSON.pretty_generate(search_data))
    end

    private

    def get_category(url)
      case url
      when /^\/companies\//
        'Companies'
      when /^\/Calc\//
        'Calculators'
      when /^\/search/
        'Search'
      when /^\/contact/
        'Contact'
      when /^\/sitemap/
        'Navigation'
      else
        'General'
      end
    end
  end
end
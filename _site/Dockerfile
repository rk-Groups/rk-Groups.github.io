# Jekyll Development Environment
FROM ruby:3.1-alpine

# Install dependencies
RUN apk add --no-cache \
    build-base \
    git \
    nodejs \
    npm

# Set working directory
WORKDIR /srv/jekyll

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Copy Gemfile for dependency installation
COPY Gemfile* ./

# Install Ruby dependencies
RUN bundle install

# Copy site files
COPY . .

# Expose Jekyll development server port
EXPOSE 4000

# Default command to serve the site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--drafts"]
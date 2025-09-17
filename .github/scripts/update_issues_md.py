#!/usr/bin/env python3
"""
Script to fetch open issues from GitHub API and update dev/issues.md
"""

import os
import sys
import requests
from datetime import datetime

def main():
    """Main function to update issues markdown file"""
    try:
        # Configuration
        REPO = os.environ.get('REPO', 'rk-Groups/rk-Groups.github.io')
        GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')

        if not GITHUB_TOKEN:
            print("Warning: GITHUB_TOKEN not found. API rate limits may apply.")

        API_URL = f'https://api.github.com/repos/{REPO}/issues'
        HEADERS = {
            'Authorization': f'token {GITHUB_TOKEN}',
            'Accept': 'application/vnd.github.v3+json',
            'User-Agent': 'GitHub-Actions-Issue-Updater'
        } if GITHUB_TOKEN else {
            'Accept': 'application/vnd.github.v3+json',
            'User-Agent': 'GitHub-Actions-Issue-Updater'
        }

        # Fetch issues
        params = {
            'state': 'open',
            'per_page': 100,
            'sort': 'created',
            'direction': 'desc'
        }

        print(f"Fetching open issues from {REPO}...")
        response = requests.get(API_URL, headers=HEADERS, params=params, timeout=30)
        response.raise_for_status()

        issues = response.json()

        # Ensure dev directory exists
        os.makedirs('dev', exist_ok=True)

        # Write issues to markdown file
        with open('dev/issues.md', 'w', encoding='utf-8') as f:
            f.write(f"# Open Issues for {REPO}\n\n")
            f.write(f"*Last updated: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')} UTC*\n\n")

            if not issues:
                f.write('No open issues found.\n')
                print("No open issues found.")
            else:
                # Filter out pull requests and write issues
                actual_issues = [issue for issue in issues if 'pull_request' not in issue]

                f.write(f"Total open issues: {len(actual_issues)}\n\n")

                if actual_issues:
                    f.write("## Issues List\n\n")
                    for issue in actual_issues:
                        title = issue.get('title', 'No title').strip()
                        number = issue.get('number', '')
                        url = issue.get('html_url', '')
                        user = issue.get('user', {}).get('login', 'unknown')
                        created = issue.get('created_at', '')[:10]
                        labels = [label.get('name', '') for label in issue.get('labels', [])]

                        # Escape markdown special characters in title
                        title = title.replace('[', '\\[').replace(']', '\\]')

                        f.write(f"### [{title}]({url})\n")
                        f.write(f"- **Issue #**: {number}\n")
                        f.write(f"- **Created by**: @{user}\n")
                        f.write(f"- **Date**: {created}\n")

                        if labels:
                            f.write(f"- **Labels**: {', '.join(labels)}\n")

                        body = (issue.get('body', '') or '').strip()
                        if body:
                            # Clean up body text
                            body = body.replace('\r\n', '\n').replace('\r', '\n')
                            lines = body.split('\n')
                            preview = lines[0] if lines else ''
                            if len(preview) > 200:
                                preview = preview[:197] + '...'
                            f.write(f"- **Description**: {preview}\n")

                        f.write("\n")
                else:
                    f.write("All items are pull requests, no actual issues found.\n")

                print(f"Successfully updated dev/issues.md with {len(actual_issues)} issues.")

    except requests.exceptions.RequestException as e:
        print(f"Error fetching issues: {e}", file=sys.stderr)
        # Create a minimal file indicating the error
        os.makedirs('dev', exist_ok=True)
        with open('dev/issues.md', 'w', encoding='utf-8') as f:
            f.write(f"# Open Issues for {REPO}\n\n")
            f.write(f"*Last update failed: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')} UTC*\n\n")
            f.write(f"Error fetching issues: {str(e)}\n")
        sys.exit(1)

    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()

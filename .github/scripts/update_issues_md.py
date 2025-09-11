import os
import requests

REPO = os.environ.get('REPO', 'rk-Groups/rk-Groups.github.io')
GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')
API_URL = f'https://api.github.com/repos/{REPO}/issues?state=open&per_page=100'
HEADERS = {'Authorization': f'token {GITHUB_TOKEN}'} if GITHUB_TOKEN else {}

response = requests.get(API_URL, headers=HEADERS)
issues = response.json()

with open('dev/issues.md', 'w', encoding='utf-8') as f:
    f.write(f"# Open Issues for {REPO}\n\n")
    if not issues or (isinstance(issues, dict) and issues.get('message')):
        f.write('No open issues found or API rate limit exceeded.\n')
    else:
        for issue in issues:
            if 'pull_request' in issue:
                continue  # skip PRs
            title = issue.get('title', 'No title')
            number = issue.get('number', '')
            url = issue.get('html_url', '')
            user = issue.get('user', {}).get('login', 'unknown')
            created = issue.get('created_at', '')[:10]
            body = (issue.get('body', '') or '').strip().replace('\r', '').replace('\n', ' ')
            if len(body) > 120:
                body = body[:117] + '...'
            f.write(f"- [#{number}]({url}) **{title}** (by @{user} on {created})\n")
            if body:
                f.write(f"    - {body}\n")

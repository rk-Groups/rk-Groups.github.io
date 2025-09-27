const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

const port = 3000;
const rootDir = __dirname;

// MIME types
const mimeTypes = {
  '.html': 'text/html',
  '.js': 'text/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpg',
  '.gif': 'image/gif',
  '.ico': 'image/x-icon',
  '.svg': 'image/svg+xml',
  '.md': 'text/markdown'
};

function renderMarkdown(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    
    // Extract frontmatter
    const frontmatterMatch = content.match(/^---\n(.*?)\n---\n(.*)/s);
    if (!frontmatterMatch) return content;
    
    const frontmatter = frontmatterMatch[1];
    const body = frontmatterMatch[2];
    
    // Extract title from frontmatter
    const titleMatch = frontmatter.match(/title:\s*(.+)/);
    const title = titleMatch ? titleMatch[1].replace(/['"]/g, '') : 'RK Groups';
    
    // Simple markdown to HTML conversion
    let html = body
      .replace(/^# (.+)$/gm, '<h1>$1</h1>')
      .replace(/^## (.+)$/gm, '<h2>$1</h2>')
      .replace(/^### (.+)$/gm, '<h3>$1</h3>')
      .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
      .replace(/\*(.+?)\*/g, '<em>$1</em>')
      .replace(/\n\n/g, '</p><p>')
      .replace(/\n/g, '<br>');
    
    if (!html.startsWith('<')) {
      html = '<p>' + html + '</p>';
    }
    
    // Include CSS and basic layout
    return `<!DOCTYPE html>
<html lang="en" class="dark-mode">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/assets/css/mui.css">
    <style>
        body { background: var(--bg-primary); color: var(--text-primary); font-family: 'Segoe UI', sans-serif; margin: 0; padding: 2rem; }
        .mui-hero { text-align: center; padding: 3rem 1rem; }
        .mui-hero-title { font-size: 2.5rem; margin-bottom: 1rem; }
        .mui-hero-subtitle { font-size: 1.25rem; color: var(--text-secondary); }
        .mui-card { background: var(--bg-elevated); padding: 2rem; border-radius: 12px; max-width: 1200px; margin: 0 auto; }
    </style>
</head>
<body class="dark-mode">
    ${html}
</body>
</html>`;
  } catch (err) {
    return `<html><body><h1>Error loading page</h1><p>${err.message}</p></body></html>`;
  }
}

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  let pathname = parsedUrl.pathname;
  
  // Handle root
  if (pathname === '/') {
    pathname = '/index.md';
  }
  
  // Handle directory requests (add index.md)
  if (pathname.endsWith('/')) {
    pathname += 'index.md';
  }
  
  const filePath = path.join(rootDir, pathname);
  
  // Check if file exists
  if (!fs.existsSync(filePath)) {
    // Try with .md extension
    const mdPath = filePath + '.md';
    if (fs.existsSync(mdPath)) {
      const html = renderMarkdown(mdPath);
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(html);
      return;
    }
    
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not Found');
    return;
  }
  
  const stat = fs.statSync(filePath);
  if (stat.isDirectory()) {
    const indexPath = path.join(filePath, 'index.md');
    if (fs.existsSync(indexPath)) {
      const html = renderMarkdown(indexPath);
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(html);
      return;
    }
  }
  
  const ext = path.extname(filePath);
  const contentType = mimeTypes[ext] || 'application/octet-stream';
  
  if (ext === '.md') {
    const html = renderMarkdown(filePath);
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(html);
  } else {
    const content = fs.readFileSync(filePath);
    res.writeHead(200, { 'Content-Type': contentType });
    res.end(content);
  }
});

server.listen(port, () => {
  console.log(`🚀 Server running at http://localhost:${port}`);
  console.log(`📍 Sitemap available at: http://localhost:${port}/sitemap/`);
});
// check-hrefs.js
// Pre-commit script to check for broken hrefs in all HTML files
// Usage: node check-hrefs.js

const fs = require('fs');
const path = require('path');

const ROOT = process.cwd();
const IGNORED_HREFS = [
  '#', '', 'javascript:void(0)', 'mailto:', 'tel:',
  /^https?:\/\//
];

function isIgnored(href) {
  return IGNORED_HREFS.some(ignore =>
    typeof ignore === 'string' ? href === ignore : ignore.test(href)
  );
}

function getAllFiles(dir, ext) {
  let results = [];
  fs.readdirSync(dir, { withFileTypes: true }).forEach(entry => {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      results = results.concat(getAllFiles(fullPath, ext));
    } else if (entry.isFile() && fullPath.endsWith(ext)) {
      results.push(fullPath);
    }
  });
  return results;
}

function extractHrefs(html) {
  const regex = /href=["']([^"']+)["']/g;
  let match, hrefs = [];
  while ((match = regex.exec(html))) {
    hrefs.push(match[1]);
  }
  return hrefs;
}

function checkHrefExists(href, fileDir) {
  // Ignore anchors, mailto, tel, and external links
  if (isIgnored(href) || href.startsWith('mailto:') || href.startsWith('tel:')) return true;
  // Absolute path (from repo root)
  let target = href;
  if (!href.startsWith('/')) {
    target = path.join(fileDir, href).replace(/[#?].*$/, '');
  } else {
    target = path.join(ROOT, href.replace(/^\//, '')).replace(/[#?].*$/, '');
  }
  // Remove any query/hash
  if (fs.existsSync(target)) return true;
  // Try .html if not present
  if (!target.endsWith('.html') && fs.existsSync(target + '.html')) return true;
  return false;
}

let broken = [];
getAllFiles(ROOT, '.html').forEach(file => {
  const html = fs.readFileSync(file, 'utf8');
  const hrefs = extractHrefs(html);
  hrefs.forEach(href => {
    if (!checkHrefExists(href, path.dirname(file))) {
      broken.push({ file, href });
    }
  });
});

if (broken.length) {
  console.error('Broken href(s) found:');
  broken.forEach(b => {
    console.error(`  In ${b.file}: ${b.href}`);
  });
  process.exit(1);
} else {
  console.log('All hrefs are valid.');
}

# RK Groups - Multi-Company Jekyll Site

A modern, performance-optimized static website for RK Groups featuring multiple companies with advanced SEO, accessibility, security, and user experience enhancements.

## 🚀 Key Features

### Core Functionality
- **Multi-Company Architecture**: Data-driven company management with shared layouts and includes
- **Interactive Calculators**: GST Calculator and Liquid Gas Calculator with hybrid Markdown/HTML
- **Data-Driven Navigation**: Centralized navigation management via `_data/navigation.yml`
- **Legal Compliance**: Terms and refund policies accessible across all company branches
- **PWA Features**: Service worker, manifest, and offline capabilities

### Performance & Monitoring
- **Core Web Vitals Tracking**: Real-time performance monitoring with web-vitals library
- **Image Optimization**: Responsive images with lazy loading and modern format support
- **Asset Minification**: Automated CSS and JavaScript minification pipeline
- **Bundle Analysis**: Webpack bundle analyzer integration for optimization insights

### Security & Privacy
- **Security Headers**: Comprehensive CSP, X-Frame-Options, and caching policies via `_headers`
- **Error Monitoring**: Client-side error tracking with user feedback system
- **Privacy-Focused Analytics**: Performance data collection with user consent

### Accessibility & SEO
- **WCAG Compliance**: ARIA labels, skip links, focus management, and keyboard navigation
- **Structured Data**: JSON-LD schemas for LocalBusiness, WebSite, and FAQ content
- **Rich Snippets**: Enhanced search result displays with company information
- **Site Search**: Client-side search with Lunr.js and auto-generated indexes

### Development Workflow
- **Automated Testing**: Comprehensive pre-push validation with link checking and accessibility audits
- **Docker Development**: Containerized Jekyll environment with live reload
- **Enhanced Build Scripts**: npm-based build pipeline with multiple optimization steps
- **CI/CD Integration**: GitHub Actions with caching and automated deployments

## 🛠️ Quick Start

### Prerequisites
- Ruby 2.7+ (for Jekyll)
- Node.js 16+ (for asset processing)
- Docker (optional, for containerized development)

### Installation & Development

```bash
# Clone the repository
git clone https://github.com/rk-Groups/rk-Groups.github.io.git
cd rk-groups.github.io

# Install dependencies
npm install

# Start development server
./dev-workflow.ps1 -Serve
# or
npm run serve
```

### Build & Deploy

```bash
# Build optimized assets
./dev-workflow.ps1 -Build
# or
npm run build

# Run tests
./dev-workflow.ps1 -Test
# or
npm test

# Deploy to production
./dev-workflow.ps1 -Deploy
# or
npm run deploy
```

## 📊 Performance Monitoring

The site includes comprehensive performance monitoring:

- **Core Web Vitals**: LCP, FID, CLS tracking
- **Error Monitoring**: JavaScript error collection with user feedback
- **Analytics Integration**: Privacy-focused performance data collection
- **Bundle Analysis**: Automated bundle size monitoring

View performance data in your browser's developer console or check the error monitoring dashboard.

## 🔍 Site Search

Client-side search powered by Lunr.js with:
- Auto-generated search indexes
- Real-time search suggestions
- Keyboard navigation support
- Accessible search interface

## 🛡️ Security Features

- **Content Security Policy**: Strict CSP headers preventing XSS attacks
- **Security Headers**: X-Frame-Options, X-Content-Type-Options, and more
- **HTTPS Enforcement**: Secure connection requirements
- **Cache Optimization**: Efficient caching strategies for static assets

## ♿ Accessibility

- **WCAG 2.1 AA Compliance**: Full accessibility audit compliance
- **Keyboard Navigation**: Complete keyboard accessibility
- **Screen Reader Support**: ARIA labels and semantic HTML
- **Focus Management**: Visible focus indicators and logical tab order
- **Skip Links**: Quick navigation for screen reader users

## 📱 Progressive Web App

- **Service Worker**: Offline functionality and caching
- **Web App Manifest**: Installable PWA experience
- **Responsive Design**: Mobile-first approach with Material UI
- **Touch-Friendly**: Optimized for mobile interactions

## 🏗️ Architecture

### Data-Driven Design
```
_data/
├── companies.yml      # Company information and branches
└── navigation.yml     # Centralized navigation structure
```

### Layout System
```
_layouts/
├── default.html       # Main layout with all includes
├── company.html       # Company landing pages
├── company-branch.html # Individual branch pages
└── company-policy.html # Legal/policy pages
```

### Asset Pipeline
```
assets/
├── css/
│   └── mui.css        # Material UI with custom properties
└── js/
    ├── performance-monitoring.js
    ├── search.js
    ├── error-monitoring.js
    └── bundle.min.js
```

## 🧪 Testing & Validation

Run comprehensive tests before deployment:

```bash
# Full test suite
./scripts/test-before-push.ps1

# Individual tests
./dev-workflow.ps1 -Test

# Performance analysis
./dev-workflow.ps1 -Analyze
```

Tests include:
- Jekyll build validation
- Link checking
- Accessibility audits (axe-core)
- Lighthouse performance scoring
- HTML validation

## 🚀 Deployment

### GitHub Pages (Automated)
The site deploys automatically via GitHub Actions on push to main branch.

### Manual Deployment
```bash
./test-and-push.ps1 "Your commit message"
```

### Docker Deployment
```bash
docker build -t rk-groups-site .
docker run -p 4000:4000 rk-groups-site
```

## 📈 Analytics & Monitoring

- **Performance Metrics**: Core Web Vitals tracking
- **Error Reporting**: Client-side error collection
- **User Feedback**: Integrated feedback system
- **SEO Monitoring**: Structured data validation

## 🤝 Contributing

1. Follow the [Company Setup Guide](dev/COMPANY_SETUP_GUIDE.md)
2. Use the development workflow scripts
3. Run tests before committing
4. Follow the [Static Rules](dev/STATIC_RULES.md)

## 📄 License

MIT License - see LICENSE file for details.

## 📞 Support

- [Report Issues](https://github.com/rk-Groups/rk-Groups.github.io/issues)
- [Development Docs](dev/)
- [Static Rules](dev/STATIC_RULES.md)

---

## Legal & Policy Pages

- [Terms of Service](https://rk-groups.github.io/companies/rk-oxygen/gorakhpur/terms/)
- [Refund & Cancellation Policy](https://rk-groups.github.io/companies/rk-oxygen/gorakhpur/refund-policy/)

All company pages display relevant business information directly from Jekyll data files for easy maintenance.

## 🧮 Calculator Submodules

This project uses git submodules for calculator components:

- **GST Calculator**: Calc/GST/ - Tax calculations
- **Liquid Calculator**: Calc/LIQ/ - Gas conversion calculations
- **EMI Calculator**: Calc/EMI/ - Loan calculations
- **CI Calculator**: Calc/CI/ - Compound interest calculations

### Working with Submodules

`ash
# Initialize submodules (first time)
npm run submodules:init

# Update submodules to latest
npm run submodules:update

# Check submodule status
npm run submodules:status

# Update specific calculator
cd Calc/GST && git pull origin main
`

### Managing Calculators

Use the calculator management script:

`ash
# Add new calculator submodule
.\manage-calculators.ps1 -AddGST

# Update all calculators
.\manage-calculators.ps1 -Update
`

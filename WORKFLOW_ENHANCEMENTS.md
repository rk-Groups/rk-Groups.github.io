# 🚀 Enhanced CI/CD Workflows for RK Groups Jekyll Site

## 📋 Current Tech Stack Analysis

Your site uses:
- **Jekyll 4** with GitHub Pages deployment
- **Docker** for local development (`jekyll/jekyll:4`)
- **GitHub Actions** with comprehensive CI/CD pipeline
- **Ruby 3.1** + **Node.js 18** setup
- **Security scanning** (Trivy), **accessibility testing** (axe-core), **performance audits** (Lighthouse)

## 🎯 Recommended Workflow Enhancements

### 1. 🔒 SLSA3 Provenance for Release Workflows

Add supply chain security with SLSA Level 3 provenance to your deployment pipeline.

```yaml
# .github/workflows/slsa-provenance.yml
name: Generate SLSA Provenance

on:
  release:
    types: [published]
  workflow_dispatch:

permissions:
  contents: read
  id-token: write

jobs:
  provenance:
    runs-on: ubuntu-latest
    outputs:
      digest: ${{ steps.build.outputs.digest }}
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - name: Build site
        run: |
          npm run build
          bundle exec jekyll build --baseurl "/"

      - name: Generate artifact digest
        id: build
        run: |
          find _site -type f -exec sha256sum {} \; | sort > site.sha256
          echo "digest=sha256:$(sha256sum site.sha256 | cut -d' ' -f1)" >> $GITHUB_OUTPUT

      - name: Generate SLSA provenance
        uses: slsa-framework/slsa-github-generator@v1.9.0
        with:
          base64-subjects: "${{ steps.build.outputs.digest }}"
          upload-assets: true
```

### 2. 🐳 Enhanced Docker Packaging with Jekyll Builder

Replace your development Docker setup with production-ready packaging using `jekyll/builder`.

```yaml
# .github/workflows/docker-build.yml
name: Build and Push Jekyll Docker Image

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Log in to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=sha,prefix={{branch}}-
            type=raw,value=latest,enable={{is_default_branch}}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
          build-args: |
            JEKYLL_ENV=production
```

### 3. 🏗️ Multi-Stage Docker Build for Production

Create an optimized production Docker image using multi-stage builds.

```dockerfile
# Dockerfile.production
# Multi-stage build for optimized production image

# Build stage
FROM jekyll/builder:latest as builder

WORKDIR /tmp
COPY . /tmp

# Install dependencies and build
RUN bundle install && \
    npm install && \
    npm run build && \
    jekyll build --baseurl "" --destination /tmp/_site

# Production stage
FROM nginx:alpine

# Copy built site
COPY --from=builder /tmp/_site /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Add security headers
ADD _headers /usr/share/nginx/html/_headers

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

### 4. 🔄 Advanced CI/CD Pipeline with Submodule Support

Update your CI/CD pipeline to handle git submodules properly.

```yaml
# .github/workflows/advanced-ci-cd.yml
name: Advanced CI/CD with Submodules

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout with submodules
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - name: Install dependencies
        run: |
          bundle install
          npm ci

      - name: Build with submodules
        run: |
          npm run build
          bundle exec jekyll build --drafts --future
        env:
          JEKYLL_ENV: test

      - name: Test submodules
        run: |
          git submodule status
          npm run submodules:status

  security:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout with submodules
        uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Run Trivy on submodules
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: '.'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload security results
        uses: github/codeql-action/upload-sarif@v3
        if: always()
        with:
          sarif_file: 'trivy-results.sarif'

  deploy:
    needs: [test, security]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/master'
    steps:
      - name: Checkout with submodules
        uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - name: Build for production
        run: |
          npm run build
          bundle exec jekyll build --baseurl "${{ steps.pages.outputs.base_path }}"
        env:
          JEKYLL_ENV: production

      - name: Upload to Pages
        uses: actions/upload-pages-artifact@v3
```

### 5. 🔐 Supply Chain Security Enhancements

Add comprehensive security scanning and SBOM generation.

```yaml
# .github/workflows/security-supply-chain.yml
name: Security & Supply Chain

on:
  push:
    branches: [ master ]
  schedule:
    - cron: '0 0 * * 1'  # Weekly on Mondays

jobs:
  sbom:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Generate SBOM
        uses: anchore/sbom-action@v0
        with:
          path: '.'
          format: 'spdx-json'
          output-file: './sbom.spdx.json'

      - name: Upload SBOM
        uses: actions/upload-artifact@v4
        with:
          name: sbom
          path: ./sbom.spdx.json

  dependency-review:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Dependency Review
        uses: actions/dependency-review-action@v4

  scorecard:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run Scorecard
        uses: ossf/scorecard-action@v2
        with:
          results_file: results.sarif
          results_format: sarif
          publish_results: true
```

### 6. 📊 Performance & Monitoring Dashboard

Add automated performance tracking and reporting.

```yaml
# .github/workflows/performance-monitoring.yml
name: Performance Monitoring

on:
  push:
    branches: [ master ]
  schedule:
    - cron: '0 */6 * * *'  # Every 6 hours

jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true

      - name: Build site
        run: bundle exec jekyll build

      - name: Run Lighthouse
        uses: treosh/lighthouse-ci-action@v10
        with:
          urls: https://rk-groups.github.io
          configPath: .lighthouserc.json
          uploadArtifacts: true
          temporaryPublicStorage: true

  uptime:
    runs-on: ubuntu-latest
    steps:
      - name: Check site uptime
        uses: rrenks/uptime-action@v1
        with:
          url: https://rk-groups.github.io
          timeout: 30
```

## 🚀 Quick Implementation Plan

### Phase 1: Core Improvements (High Priority)
1. ✅ **SLSA Provenance** - Add to release workflow
2. ✅ **Enhanced Docker Build** - Use jekyll/builder for consistency
3. ✅ **Submodule Support** - Update CI/CD for calculator submodules

### Phase 2: Security & Compliance (Medium Priority)
1. ⏳ **SBOM Generation** - Add software bill of materials
2. ⏳ **Dependency Review** - Automated vulnerability scanning
3. ⏳ **Scorecard** - OpenSSF security scoring

### Phase 3: Monitoring & Analytics (Low Priority)
1. ⏳ **Performance Dashboard** - Automated Lighthouse monitoring
2. ⏳ **Uptime Monitoring** - Site availability tracking
3. ⏳ **Error Tracking** - Production error monitoring

## 🛠️ Implementation Commands

```bash
# Create new workflow files
# 1. SLSA provenance
# 2. Docker build pipeline
# 3. Enhanced CI/CD with submodules
# 4. Security supply chain
# 5. Performance monitoring

# Update existing workflows to include submodule checkout
# Add 'submodules: recursive' to all checkout steps

# Test the new workflows
# Push to trigger CI/CD pipeline
```

## 📈 Benefits

- **🔒 Enhanced Security**: SLSA3 provenance and comprehensive scanning
- **🐳 Better Docker**: Production-optimized images with multi-stage builds
- **🔄 Improved CI/CD**: Submodule support and automated testing
- **📊 Monitoring**: Performance tracking and uptime monitoring
- **📦 Supply Chain**: SBOM generation and dependency reviews

Would you like me to implement any of these workflow enhancements?
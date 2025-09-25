# Local Development Setup

This guide helps you run the RK Groups Jekyll site locally for development and testing.

## 🐳 Docker Method (Recommended)

The easiest way to get started is using Docker, which provides a consistent environment across all systems.

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

### Quick Start

1. **Start the development server:**
   ```bash
   ./dev-server.ps1
   ```

2. **Open your browser:**
   - Main site: http://localhost:4000
   - LiveReload: http://localhost:35729 (automatic page refresh)

3. **Stop the server:**
   ```bash
   # Press Ctrl+C in the terminal, or:
   ./dev-server.ps1 -Stop
   ```

### Available Commands

```bash
# Basic usage
./dev-server.ps1                    # Start development server
./dev-server.ps1 -Official          # Use official Jekyll Docker image
./dev-server.ps1 -Build             # Force rebuild Docker image
./dev-server.ps1 -Stop              # Stop running containers
./dev-server.ps1 -Logs              # View container logs
./dev-server.ps1 -Clean             # Clean up containers and volumes

# Alternative using docker-compose directly
docker-compose up jekyll             # Start with custom image
docker-compose up jekyll-official    # Start with official image (add --profile official)
```

### Features

- ✅ **Live Reload**: Automatically refreshes browser when files change
- ✅ **Volume Mounting**: File changes reflect immediately
- ✅ **Draft Posts**: View draft content during development
- ✅ **Incremental Builds**: Faster rebuild times
- ✅ **Bundle Caching**: Gem dependencies cached between runs

## 🏠 Native Jekyll Method

If you prefer running Jekyll natively on your system:

### Prerequisites
- Ruby 3.0+ installed
- Bundler gem installed

### Setup & Run

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Start development server:**
   ```bash
   bundle exec jekyll serve --livereload --drafts
   ```

3. **Open your browser:**
   - http://localhost:4000

## 🧪 Testing Your Changes

### Local Testing (Before Push)

Run the comprehensive test suite:

```bash
# Full test suite (requires Jekyll build)
./test-and-push.ps1 "your commit message"

# Light testing (no Jekyll build required)
.\scripts\test-before-push.ps1 -SkipLighthouse -SkipAxe
```

### Docker Testing

The Docker environment includes all the same testing tools:

```bash
# Run tests inside Docker container
docker-compose exec jekyll bash
bundle exec jekyll build
# Run other tests...
```

## 🔧 Troubleshooting

### Common Issues

**Docker not starting:**
- Ensure Docker Desktop is running
- Check if ports 4000 or 35729 are already in use
- Try: `./dev-server.ps1 -Clean` then restart

**Changes not reflecting:**
- Check if volume mounting is working
- Try force rebuild: `./dev-server.ps1 -Build`
- Ensure you're editing files in the correct directory

**Build errors:**
- Check logs: `./dev-server.ps1 -Logs`
- Try official image: `./dev-server.ps1 -Official`
- Clean and rebuild: `./dev-server.ps1 -Clean` then `./dev-server.ps1 -Build`

### Port Conflicts

If port 4000 is in use, modify `docker-compose.yml`:

```yaml
ports:
  - "4001:4000"  # Use port 4001 instead
  - "35730:35729"
```

## 📁 File Structure

```
rk-Groups.github.io/
├── Dockerfile                 # Custom Jekyll environment
├── docker-compose.yml         # Multi-service setup
├── dev-server.ps1            # Development server script
├── _config.yml               # Jekyll configuration
├── _data/                    # Site data (navigation, companies)
├── _includes/                # Reusable components
├── _layouts/                 # Page layouts
├── assets/                   # CSS, JS, images
├── companies/               # Company pages
├── Calc/                    # Calculator tools
└── scripts/                 # Testing and build scripts
```

## 🚀 Next Steps

After local testing, push your changes:

```bash
# Using the integrated test-and-push script
./test-and-push.ps1 "Describe your changes"

# Or manually
git add .
git commit -m "Your commit message"
git push
```

The GitHub Pages will automatically build and deploy your changes!

---

## Legacy Testing Information

For reference, here's the previous local testing infrastructure that was set up:

### 🧪 **Main Testing Script** (`scripts/test-before-push.ps1`)
- **Jekyll Build Validation**: Ensures your site builds correctly
- **Link Checking**: Validates internal Markdown links  
- **Lighthouse Testing**: Performance and SEO checks on key pages
- **Accessibility Testing**: axe-core validation for a11y compliance
- **Pre-commit Quality**: Whitespace and formatting checks
- **Git Workflow**: Automatic pull before testing

### 🚀 **Convenience Wrapper** (`test-and-push.ps1`)
- **One-Command Workflow**: Test → Commit → Push in a single command
- **Quick Mode**: Skip heavy tests for minor changes
- **Safety First**: Only pushes if all tests pass
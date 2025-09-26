#!/usr/bin/env pwsh

# RK Groups Development Workflow Enhancement Script
# This script provides common development tasks and workflow improvements

param(
    [switch]$Build,
    [switch]$Serve,
    [switch]$Test,
    [switch]$Deploy,
    [switch]$Clean,
    [switch]$Analyze,
    [switch]$Help
)

Write-Host "🚀 RK Groups Development Workflow" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

if ($Help) {
    Write-Host ""
    Write-Host "Available commands:" -ForegroundColor Yellow
    Write-Host "  -Build      : Build the site with optimizations"
    Write-Host "  -Serve      : Start development server"
    Write-Host "  -Test       : Run all tests and validations"
    Write-Host "  -Deploy     : Deploy to production"
    Write-Host "  -Clean      : Clean build artifacts"
    Write-Host "  -Analyze    : Analyze site performance and SEO"
    Write-Host "  -Help       : Show this help message"
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor Green
    Write-Host "  .\dev-workflow.ps1 -Build"
    Write-Host "  .\dev-workflow.ps1 -Serve"
    Write-Host "  .\dev-workflow.ps1 -Test"
    exit 0
}

function Write-Step {
    param([string]$Message)
    Write-Host "📋 $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

if ($Build) {
    Write-Step "Building site with optimizations..."

    # Install dependencies
    Write-Step "Installing dependencies..."
    npm install

    # Build assets
    Write-Step "Building and minifying assets..."
    npm run minify

    # Build Jekyll site
    Write-Step "Building Jekyll site..."
    if (Get-Command jekyll -ErrorAction SilentlyContinue) {
        jekyll build --config _config.yml
    } else {
        Write-Host "⚠️  Jekyll not found locally, using Docker..." -ForegroundColor Yellow
        docker run --rm -v ${PWD}:/srv/jekyll -it jekyll/jekyll:latest jekyll build --config _config.yml
    }

    Write-Success "Site built successfully!"
}

if ($Serve) {
    Write-Step "Starting development server..."

    # Check if Docker is available
    if (Get-Command docker -ErrorAction SilentlyContinue) {
        Write-Step "Using Docker for Jekyll development server..."
        .\dev-server.ps1
    } else {
        Write-Host "⚠️  Docker not available, checking for local Jekyll..." -ForegroundColor Yellow
        if (Get-Command jekyll -ErrorAction SilentlyContinue) {
            Write-Step "Starting Jekyll server locally..."
            jekyll serve --livereload --drafts --incremental
        } else {
            Write-Error "Neither Docker nor Jekyll found. Please install one of them."
            exit 1
        }
    }
}

if ($Test) {
    Write-Step "Running comprehensive tests..."

    # Run the existing test script
    .\scripts\test-before-push.ps1

    # Additional tests
    Write-Step "Running additional validations..."

    # Check for broken links (if available)
    if (Get-Command linkchecker -ErrorAction SilentlyContinue) {
        Write-Step "Checking for broken links..."
        linkchecker http://localhost:4000 --check-extern --no-warnings --file-output=html/broken-links.html
    }

    # Lighthouse audit (if available)
    if (Get-Command lighthouse -ErrorAction SilentlyContinue) {
        Write-Step "Running Lighthouse audit..."
        lighthouse http://localhost:4000 --output html --output-path ./reports/lighthouse.html
    }

    Write-Success "All tests completed!"
}

if ($Deploy) {
    Write-Step "Deploying to production..."

    # Build first
    & $PSCommandPath -Build

    # Run tests
    & $PSCommandPath -Test

    # Deploy (GitHub Pages example)
    Write-Step "Pushing to GitHub Pages..."
    git add .
    git commit -m "Deploy: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git push origin master

    Write-Success "Site deployed successfully!"
}

if ($Clean) {
    Write-Step "Cleaning build artifacts..."

    # Remove generated files
    Remove-Item -Path "_site" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path ".jekyll-cache" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path ".sass-cache" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "assets/css/*.min.css" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "assets/js/*.min.js" -Force -ErrorAction SilentlyContinue

    # Clean npm
    if (Test-Path "node_modules") {
        Write-Step "Cleaning npm cache..."
        npm cache clean --force
    }

    Write-Success "Cleanup completed!"
}

if ($Analyze) {
    Write-Step "Analyzing site performance and SEO..."

    # Bundle analyzer (if available)
    if (Get-Command npx -ErrorAction SilentlyContinue) {
        Write-Step "Analyzing bundle sizes..."
        npx webpack-bundle-analyzer _site/stats.json --port 8888
    }

    # SEO analysis
    Write-Step "Checking SEO elements..."
    $seoIssues = @()

    # Check for missing meta descriptions
    Get-ChildItem "_site/**/*.html" -Recurse | ForEach-Object {
        $content = Get-Content $_.FullName -Raw
        if ($content -notmatch '<meta name="description"') {
            $seoIssues += "Missing meta description: $($_.FullName)"
        }
    }

    if ($seoIssues.Count -gt 0) {
        Write-Host "SEO Issues Found:" -ForegroundColor Yellow
        $seoIssues | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
    } else {
        Write-Success "No SEO issues found!"
    }

    # Performance analysis
    Write-Step "Analyzing performance..."
    $totalSize = (Get-ChildItem "_site" -Recurse -File | Measure-Object -Property Length -Sum).Sum
    $sizeMB = [math]::Round($totalSize / 1MB, 2)
    Write-Host "Total site size: $sizeMB MB" -ForegroundColor Cyan

    # Large files check
    Get-ChildItem "_site" -Recurse -File | Where-Object { $_.Length -gt 1MB } | ForEach-Object {
        $sizeMB = [math]::Round($_.Length / 1MB, 2)
        Write-Host "Large file: $($_.FullName) - $sizeMB MB" -ForegroundColor Yellow
    }
}

# Default action if no parameters provided
if (-not ($Build -or $Serve -or $Test -or $Deploy -or $Clean -or $Analyze -or $Help)) {
    Write-Host ""
    Write-Host "No command specified. Use -Help to see available commands." -ForegroundColor Yellow
    Write-Host ""
    & $PSCommandPath -Help
}
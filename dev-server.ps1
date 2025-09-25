#!/usr/bin/env pwsh

# Jekyll Development Environment Setup
# This script helps you run the Jekyll site locally using Docker

param(
    [switch]$Official,  # Use official Jekyll Docker image instead of custom
    [switch]$Build,     # Force rebuild the Docker image
    [switch]$Clean,     # Clean up containers and volumes
    [switch]$Stop,      # Stop running containers
    [switch]$Logs       # Show container logs
)

Write-Host "🚀 RK Groups Jekyll Development Environment" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Check if Docker is running
try {
    docker version | Out-Null
    Write-Host "✅ Docker is running" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker is not running. Please start Docker Desktop and try again." -ForegroundColor Red
    exit 1
}

# Handle different options
if ($Clean) {
    Write-Host "🧹 Cleaning up Docker containers and volumes..." -ForegroundColor Yellow
    docker-compose down -v
    docker system prune -f
    Write-Host "✅ Cleanup complete!" -ForegroundColor Green
    exit 0
}

if ($Stop) {
    Write-Host "🛑 Stopping Jekyll development server..." -ForegroundColor Yellow
    docker-compose down
    Write-Host "✅ Stopped!" -ForegroundColor Green
    exit 0
}

if ($Logs) {
    Write-Host "📋 Showing container logs..." -ForegroundColor Yellow
    docker-compose logs -f jekyll
    exit 0
}

# Determine which service to use
$service = if ($Official) { "jekyll-official" } else { "jekyll" }
$dockerProfile = if ($Official) { "--profile official" } else { "" }

Write-Host "📦 Using Docker service: $service" -ForegroundColor Blue

# Build or rebuild if requested
if ($Build -or $Official) {
    Write-Host "🔨 Building Docker image..." -ForegroundColor Yellow
    if ($Official) {
        Invoke-Expression "docker-compose $dockerProfile pull jekyll-official"
    } else {
        docker-compose build jekyll
    }
}

Write-Host "🚀 Starting Jekyll development server..." -ForegroundColor Green
Write-Host ""
Write-Host "📍 Your site will be available at:" -ForegroundColor Cyan
Write-Host "   🌐 http://localhost:4000" -ForegroundColor White
Write-Host "   🔄 LiveReload: http://localhost:35729" -ForegroundColor White
Write-Host ""
Write-Host "💡 Useful commands while running:" -ForegroundColor Yellow
Write-Host "   • Ctrl+C to stop the server" -ForegroundColor White
Write-Host "   • ./dev-server.ps1 -Stop to stop containers" -ForegroundColor White
Write-Host "   • ./dev-server.ps1 -Logs to view logs" -ForegroundColor White
Write-Host "   • ./dev-server.ps1 -Clean to cleanup" -ForegroundColor White
Write-Host ""

try {
    if ($Official) {
        Invoke-Expression "docker-compose $dockerProfile up jekyll-official"
    } else {
        docker-compose up jekyll
    }
} catch {
    Write-Host "❌ Failed to start development server. Check Docker logs above." -ForegroundColor Red
    Write-Host "💡 Try: ./dev-server.ps1 -Official to use the official Jekyll image" -ForegroundColor Yellow
    exit 1
}
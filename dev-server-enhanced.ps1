#!/usr/bin/env pwsh
# Quick Docker Development Setup
# Replaces the need for local Ruby/Jekyll installation

param(
    [switch]$Build,    # Build site only
    [switch]$Serve,    # Serve site with live reload
    [switch]$Test,     # Run comprehensive tests
    [switch]$Clean,    # Clean up containers and volumes
    [switch]$Logs,     # Show logs
    [switch]$Stop      # Stop all services
)

$ErrorActionPreference = "Stop"

function Write-Status {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "🚀 $Message" -ForegroundColor $Color
}

function Test-DockerRunning {
    try {
        docker info >$null 2>&1
        return $LASTEXITCODE -eq 0
    }
    catch {
        return $false
    }
}

# Verify Docker is available
if (-not (Test-DockerRunning)) {
    Write-Host "❌ Docker is not running. Please start Docker Desktop and try again." -ForegroundColor Red
    exit 1
}

# Handle different commands
if ($Clean) {
    Write-Status "Cleaning up Docker containers and volumes..."
    docker-compose -f docker-compose.yml down --volumes --remove-orphans 2>$null
    docker-compose -f docker-compose.test.yml down --volumes --remove-orphans 2>$null
    docker system prune -f >$null
    Write-Host "✅ Cleanup complete" -ForegroundColor Green
    exit 0
}

if ($Stop) {
    Write-Status "Stopping all services..."
    docker-compose -f docker-compose.yml down 2>$null
    docker-compose -f docker-compose.test.yml down 2>$null
    Write-Host "✅ All services stopped" -ForegroundColor Green
    exit 0
}

if ($Logs) {
    Write-Status "Showing service logs..."
    docker-compose -f docker-compose.yml logs -f jekyll-dev
    exit 0
}

if ($Build) {
    Write-Status "Building Jekyll site with Docker..."
    docker-compose -f docker-compose.test.yml run --rm jekyll-build
    Write-Host "✅ Build complete! Check _site/ directory" -ForegroundColor Green
    exit 0
}

if ($Test) {
    Write-Status "Running comprehensive tests..."
    & "$PSScriptRoot\scripts\enhanced-test.ps1" -CleanupAfter
    exit $LASTEXITCODE
}

# Default: Start development server
Write-Status "Starting Jekyll Development Environment"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray

# Clean up any existing containers
docker-compose -f docker-compose.yml down --remove-orphans >$null 2>&1

# Start Jekyll development server
Write-Status "Starting Jekyll development server..."
docker-compose -f docker-compose.yml up -d jekyll-dev

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to start Jekyll server" -ForegroundColor Red
    exit 1
}

# Wait a moment for startup
Start-Sleep -Seconds 3

# Show status
Write-Host "`n📍 Your site is available at:" -ForegroundColor Green
Write-Host "   🌐 http://localhost:4000" -ForegroundColor Yellow
Write-Host "   🔄 LiveReload: http://localhost:35729" -ForegroundColor Yellow

Write-Host "`n💡 Useful commands:" -ForegroundColor Cyan
Write-Host "   • .\dev-server.ps1 -Stop       # Stop server" -ForegroundColor White
Write-Host "   • .\dev-server.ps1 -Logs       # View logs" -ForegroundColor White
Write-Host "   • .\dev-server.ps1 -Build      # Build only" -ForegroundColor White
Write-Host "   • .\dev-server.ps1 -Test       # Run tests" -ForegroundColor White
Write-Host "   • .\dev-server.ps1 -Clean      # Clean up" -ForegroundColor White

Write-Host "`n🔄 Server is running in background. Press Ctrl+C to return to terminal." -ForegroundColor Gray
Write-Host "    The server will continue running until you use -Stop" -ForegroundColor Gray

# Show real-time logs
Write-Status "Following server logs (Ctrl+C to detach)..."
try {
    docker-compose -f docker-compose.yml logs -f jekyll-dev
}
catch {
    # User pressed Ctrl+C, which is fine
    Write-Host "`n✅ Server is running in background" -ForegroundColor Green
}
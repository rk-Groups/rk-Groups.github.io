#!/usr/bin/env pwsh
# Unified Docker Development Management
# Single script to manage all Docker-based development workflows

[CmdletBinding()]
param(
    [Parameter(Position=0)]
    [ValidateSet('dev', 'build', 'test', 'serve', 'prod', 'clean', 'logs', 'status', 'help')]
    [string]$Command = 'dev',
    
    [switch]$Follow,      # Follow logs
    [switch]$ForceBuild,  # Force rebuild
    [switch]$ShowVerbose, # Show verbose output
    [switch]$Detached,    # Run in background
    [string]$Service,     # Specific service name
    [switch]$NoPull       # Don't pull latest images
)

$ErrorActionPreference = "Stop"
$ComposeFile = "docker-compose.unified.yml"

function Write-Docker {
    param([string]$Message, [string]$Color = "Blue")
    Write-Host "🐳 $Message" -ForegroundColor $Color
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

function Show-Help {
    Write-Host @"
🐳 RK Groups Docker Development Manager

USAGE:
  .\docker-dev.ps1 <command> [options]

COMMANDS:
  dev      Start development environment (Jekyll + LiveReload)
  build    Build production site 
  test     Run comprehensive testing suite
  serve    Serve built site with Nginx
  prod     Run full production environment
  clean    Clean up containers and volumes
  logs     Show service logs
  status   Show container status
  help     Show this help

OPTIONS:
  -Follow     Follow logs in real-time
  -ForceBuild Force rebuild containers
  -ShowVerbose Show verbose output
  -Detached   Run services in background
  -Service    Target specific service
  -NoPull     Skip pulling latest images

EXAMPLES:
  .\docker-dev.ps1 dev                   # Start development
  .\docker-dev.ps1 build -ForceBuild     # Force rebuild and build
  .\docker-dev.ps1 test -ShowVerbose     # Run tests with verbose output
  .\docker-dev.ps1 logs -Follow          # Follow all logs
  .\docker-dev.ps1 logs -Service jekyll-dev  # Show specific service logs
  .\docker-dev.ps1 clean                 # Clean everything

DEVELOPMENT WORKFLOW:
  1. .\docker-dev.ps1 dev                # Start development environment
  2. Edit files (automatic reload)
  3. .\docker-dev.ps1 test               # Run tests before commit
  4. .\docker-dev.ps1 build              # Build for production
  5. .\docker-dev.ps1 serve              # Test production build

"@ -ForegroundColor Cyan
}

# Check Docker availability
if (-not (Test-DockerRunning)) {
    Write-Host "❌ Docker is not running. Please start Docker Desktop and try again." -ForegroundColor Red
    exit 1
}

# Main command handling
switch ($Command) {
    'help' { 
        Show-Help
        exit 0 
    }
    
    'dev' {
        Write-Docker "Starting Development Environment"
        Write-Host "📍 Services: Jekyll (http://localhost:4000) + Node.js tools" -ForegroundColor Green
        
        $cmd = @('docker-compose', '-f', $ComposeFile, '--profile', 'dev', 'up')
        if ($Detached) { $cmd += '--detach' }
        if ($ForceBuild) { $cmd += '--build' }
        if (-not $NoPull) { 
            Write-Docker "Pulling latest images..."
            & docker-compose -f $ComposeFile pull --quiet
        }
        
        & $cmd
    }
    
    'build' {
        Write-Docker "Building Production Site"
        
        if (-not $NoPull) { 
            & docker-compose -f $ComposeFile pull --quiet jekyll-build
        }
        
        if ($ForceBuild) {
            & docker-compose -f $ComposeFile --profile build run --rm --build jekyll-build
        } else {
            & docker-compose -f $ComposeFile --profile build run --rm jekyll-build
        }
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Build complete! Check _site/ directory" -ForegroundColor Green
        } else {
            Write-Host "❌ Build failed" -ForegroundColor Red
            exit 1
        }
    }
    
    'test' {
        Write-Docker "Running Comprehensive Test Suite"
        
        if (-not $NoPull) { 
            & docker-compose -f $ComposeFile pull --quiet
        }
        
        # Start test environment
        Write-Host "Starting test services..." -ForegroundColor Gray
        & docker-compose -f $ComposeFile --profile test up -d
        
        # Wait for services
        Start-Sleep -Seconds 10
        
        # Run tests
        try {
            if ($ShowVerbose) {
                & .\scripts\enhanced-test.ps1 -Verbose -CleanupAfter
            } else {
                & .\scripts\enhanced-test.ps1 -CleanupAfter
            }
        }
        finally {
            Write-Host "Stopping test services..." -ForegroundColor Gray
            & docker-compose -f $ComposeFile --profile test down
        }
    }
    
    'serve' {
        Write-Docker "Serving Production Site"
        Write-Host "📍 Services: Nginx (http://localhost:80)" -ForegroundColor Green
        
        # Ensure site is built first
        if (-not (Test-Path "_site/index.html")) {
            Write-Host "Building site first..." -ForegroundColor Yellow
            & $MyInvocation.MyCommand.Path build
        }
        
        $cmd = @('docker-compose', '-f', $ComposeFile, '--profile', 'serve', 'up')
        if ($Detached) { $cmd += '--detached' }
        if ($ForceBuild) { $cmd += '--build' }
        
        & $cmd
    }
    
    'prod' {
        Write-Docker "Starting Full Production Environment"
        Write-Host "📍 All production services" -ForegroundColor Green
        
        if (-not $NoPull) { 
            & docker-compose -f $ComposeFile pull --quiet
        }
        
        $cmd = @('docker-compose', '-f', $ComposeFile, '--profile', 'prod', 'up')
        if ($Detached) { $cmd += '--detached' }
        if ($ForceBuild) { $cmd += '--build' }
        
        & $cmd
    }
    
    'logs' {
        if ($Service) {
            Write-Docker "Showing logs for: $Service"
            $cmd = @('docker-compose', '-f', $ComposeFile, 'logs')
            if ($Follow) { $cmd += '-f' }
            $cmd += $Service
        } else {
            Write-Docker "Showing all service logs"
            $cmd = @('docker-compose', '-f', $ComposeFile, 'logs')
            if ($Follow) { $cmd += '-f' }
        }
        
        & $cmd
    }
    
    'status' {
        Write-Docker "Container Status"
        & docker-compose -f $ComposeFile ps
        
        Write-Host "`n📊 System Resources:" -ForegroundColor Cyan
        & docker system df
        
        Write-Host "`n🌐 Network Info:" -ForegroundColor Cyan
        & docker network ls | Where-Object { $_ -match "rk.*dev" }
    }
    
    'clean' {
        Write-Docker "Cleaning Up Docker Environment"
        
        Write-Host "Stopping all services..." -ForegroundColor Yellow
        & docker-compose -f $ComposeFile down --remove-orphans
        
        Write-Host "Removing volumes..." -ForegroundColor Yellow
        & docker-compose -f $ComposeFile down --volumes
        
        Write-Host "Pruning unused Docker resources..." -ForegroundColor Yellow
        & docker system prune -f
        
        Write-Host "✅ Cleanup complete" -ForegroundColor Green
    }
    
    default {
        Write-Host "❌ Unknown command: $Command" -ForegroundColor Red
        Write-Host "Use '.\docker-dev.ps1 help' for usage information" -ForegroundColor Yellow
        exit 1
    }
}
#!/usr/bin/env pwsh
# Docker MCP GitHub Integration Script
# Handles build, test, and push operations using Docker and MCP

[CmdletBinding()]
param(
    [Parameter(Position=0)]
    [ValidateSet('build', 'test', 'push', 'deploy', 'clean', 'status', 'help')]
    [string]$Action = 'help',
    
    [string]$Message = "Automated Docker MCP deployment",
    [switch]$SkipTests,
    [switch]$Force,
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"
$ComposeFile = "docker-compose.mcp.yml"

function Write-MCP {
    param([string]$Message, [string]$Color = "Magenta")
    Write-Host "🤖 MCP: $Message" -ForegroundColor $Color
}

function Write-Docker {
    param([string]$Message, [string]$Color = "Blue") 
    Write-Host "🐳 Docker: $Message" -ForegroundColor $Color
}

function Write-GitHub {
    param([string]$Message, [string]$Color = "Green")
    Write-Host "🐙 GitHub: $Message" -ForegroundColor $Color
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

function Test-GitClean {
    $status = git status --porcelain
    return [string]::IsNullOrEmpty($status)
}

function Show-Help {
    Write-Host @"
🤖 Docker MCP GitHub Integration

USAGE:
  .\docker-mcp-github.ps1 <action> [options]

ACTIONS:
  build    Build Jekyll site using Docker
  test     Run comprehensive testing suite
  push     Git add, commit, and push changes  
  deploy   Full build + test + push workflow
  clean    Clean up Docker containers and images
  status   Show current status
  help     Show this help message

OPTIONS:
  -Message "Custom commit message"
  -SkipTests    Skip testing phase
  -Force        Force operations (bypass checks)
  -Verbose      Show detailed output

EXAMPLES:
  .\docker-mcp-github.ps1 deploy -Message "Add new features"
  .\docker-mcp-github.ps1 build -Verbose
  .\docker-mcp-github.ps1 test
  .\docker-mcp-github.ps1 push -Message "Fix CI issues"
"@
}

function Invoke-DockerBuild {
    Write-Docker "Building Jekyll site..."
    
    if (-not (Test-DockerRunning)) {
        throw "❌ Docker is not running. Please start Docker Desktop and try again."
    }
    
    Write-MCP "Starting MCP-enabled Jekyll build..."
    docker-compose -f $ComposeFile --profile mcp run --rm jekyll-mcp-build
    
    if ($LASTEXITCODE -eq 0) {
        Write-Docker "✅ Build completed successfully"
    } else {
        throw "❌ Build failed with exit code $LASTEXITCODE"
    }
}

function Invoke-DockerTest {
    Write-Docker "Running comprehensive test suite..."
    
    if (-not (Test-Path "_site")) {
        Write-MCP "No _site directory found, building first..."
        Invoke-DockerBuild
    }
    
    Write-MCP "Starting MCP-enabled testing..."
    docker-compose -f $ComposeFile --profile mcp run --rm test-mcp
    
    if ($LASTEXITCODE -eq 0) {
        Write-Docker "✅ All tests passed"
    } else {
        Write-Warning "⚠️ Some tests failed, but continuing..."
    }
}

function Invoke-GitPush {
    param([string]$CommitMessage)
    
    Write-GitHub "Preparing to push changes..."
    
    # Check if there are changes
    if ((Test-GitClean) -and -not $Force) {
        Write-GitHub "✅ No changes to commit"
        return
    }
    
    # Pull latest changes
    Write-GitHub "Pulling latest changes..."
    git pull
    if ($LASTEXITCODE -ne 0) {
        throw "❌ Failed to pull latest changes"
    }
    
    # Stage changes
    Write-GitHub "Staging changes..."
    git add .
    
    # Commit changes
    Write-GitHub "Committing with message: $CommitMessage"
    git commit -m $CommitMessage
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "⚠️ Nothing to commit or commit failed"
    }
    
    # Push changes
    Write-GitHub "Pushing to remote repository..."
    git push
    if ($LASTEXITCODE -eq 0) {
        Write-GitHub "✅ Successfully pushed to GitHub"
    } else {
        throw "❌ Failed to push to GitHub"
    }
}

function Invoke-FullDeploy {
    param([string]$CommitMessage)
    
    Write-MCP "🚀 Starting full MCP deployment workflow..."
    
    try {
        # Step 1: Build
        Write-MCP "Phase 1/3: Building..."
        Invoke-DockerBuild
        
        # Step 2: Test (if not skipped)
        if (-not $SkipTests) {
            Write-MCP "Phase 2/3: Testing..."
            Invoke-DockerTest
        } else {
            Write-MCP "Phase 2/3: Skipping tests..."
        }
        
        # Step 3: Push
        Write-MCP "Phase 3/3: Deploying to GitHub..."
        Invoke-GitPush -CommitMessage $CommitMessage
        
        Write-MCP "🎉 Full deployment completed successfully!"
        
    } catch {
        Write-Error "❌ Deployment failed: $_"
        exit 1
    }
}

function Show-Status {
    Write-MCP "Current Status Report"
    Write-Host "==================="
    
    # Docker status
    if (Test-DockerRunning) {
        Write-Docker "✅ Docker is running"
    } else {
        Write-Docker "❌ Docker is not running"
    }
    
    # Git status
    $gitStatus = git status --porcelain
    if ([string]::IsNullOrEmpty($gitStatus)) {
        Write-GitHub "✅ Working directory is clean"
    } else {
        Write-GitHub "📝 Uncommitted changes found:"
        Write-Host $gitStatus
    }
    
    # Build artifacts
    if (Test-Path "_site") {
        Write-Docker "✅ Built site exists"
        $siteSize = (Get-ChildItem "_site" -Recurse | Measure-Object -Property Length -Sum).Sum
        Write-Host "   Site size: $([math]::Round($siteSize / 1MB, 2)) MB"
    } else {
        Write-Docker "❌ No built site found"
    }
}

function Invoke-Cleanup {
    Write-Docker "Cleaning up Docker resources..."
    
    # Stop and remove containers
    docker-compose -f $ComposeFile --profile mcp down -v
    
    # Remove unused images
    if ($Force) {
        docker system prune -f
        Write-Docker "✅ Full cleanup completed"
    } else {
        Write-Docker "✅ Containers cleaned up (use -Force for full cleanup)"
    }
}

# Main execution
try {
    switch ($Action.ToLower()) {
        'build' { 
            Invoke-DockerBuild 
        }
        'test' { 
            Invoke-DockerTest 
        }
        'push' { 
            Invoke-GitPush -CommitMessage $Message 
        }
        'deploy' { 
            Invoke-FullDeploy -CommitMessage $Message 
        }
        'clean' { 
            Invoke-Cleanup 
        }
        'status' { 
            Show-Status 
        }
        'help' { 
            Show-Help 
        }
        default { 
            Write-Error "Unknown action: $Action"
            Show-Help
            exit 1
        }
    }
} catch {
    Write-Error "❌ Operation failed: $_"
    exit 1
}
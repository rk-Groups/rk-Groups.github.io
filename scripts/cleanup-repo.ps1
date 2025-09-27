#!/usr/bin/env pwsh
# Repository Cleanup Script
# Identifies and removes unused/duplicate files, configurations, and dependencies

param(
    [switch]$DryRun,      # Show what would be removed without actually removing
    [switch]$Aggressive,  # More aggressive cleanup including legacy files
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

function Write-Cleanup {
    param([string]$Message, [string]$Color = "Yellow")
    Write-Host "🧹 $Message" -ForegroundColor $Color
}

function Remove-SafelyIfExists {
    param(
        [string]$Path,
        [string]$Reason,
        [switch]$IsDirectory
    )
    
    if (Test-Path $Path) {
        $sizeInfo = ""
        if (-not $IsDirectory) {
            $size = [math]::Round((Get-Item $Path).Length / 1KB, 1)
            $sizeInfo = " (${size}KB)"
        }
        
        if ($DryRun) {
            Write-Host "  [DRY RUN] Would remove: $Path$sizeInfo - $Reason" -ForegroundColor Gray
        } else {
            if ($IsDirectory) {
                Remove-Item $Path -Recurse -Force
            } else {
                Remove-Item $Path -Force
            }
            Write-Host "  ✅ Removed: $Path$sizeInfo - $Reason" -ForegroundColor Green
        }
        return $true
    }
    return $false
}

Write-Cleanup "Starting Repository Cleanup"

$removedCount = 0

# 1. Remove duplicate Docker configurations
Write-Cleanup "Cleaning up duplicate Docker configurations"
$dockerFiles = @(
    @{ Path = "docker-compose.yml"; Reason = "Replaced by docker-compose.unified.yml" },
    @{ Path = "Dockerfile.builder"; Reason = "Unused builder dockerfile" },
    @{ Path = "Dockerfile.jekyll"; Reason = "Unused jekyll dockerfile" },
    @{ Path = "nginx-site.conf"; Reason = "Replaced by docker/nginx/default.conf" },
    @{ Path = "nginx.conf"; Reason = "Replaced by docker/nginx/nginx.conf" }
)

foreach ($file in $dockerFiles) {
    if (Remove-SafelyIfExists -Path $file.Path -Reason $file.Reason) {
        $removedCount++
    }
}

# 2. Remove duplicate development scripts
Write-Cleanup "Cleaning up duplicate development scripts"
$scriptFiles = @(
    @{ Path = "dev-server.ps1"; Reason = "Replaced by dev-server-enhanced.ps1 and docker-dev.ps1" },
    @{ Path = "optimize-performance.ps1"; Reason = "Moved to scripts/ directory" },
    @{ Path = "serve-local.js"; Reason = "Functionality moved to Docker containers" },
    @{ Path = "serve-local.min.js"; Reason = "Functionality moved to Docker containers" }
)

foreach ($file in $scriptFiles) {
    if (Remove-SafelyIfExists -Path $file.Path -Reason $file.Reason) {
        $removedCount++
    }
}

# 3. Remove legacy contact/privacy structure (now using individual .md files)
Write-Cleanup "Cleaning up legacy page structure"
$legacyDirs = @(
    @{ Path = "contact"; Reason = "Replaced by contact.md"; IsDir = $true },
    @{ Path = "privacy"; Reason = "Replaced by privacy.md"; IsDir = $true },
    @{ Path = "terms"; Reason = "Replaced by terms.md"; IsDir = $true },
    @{ Path = "sitemap"; Reason = "Replaced by sitemap.md"; IsDir = $true }
)

foreach ($dir in $legacyDirs) {
    if (Test-Path $dir.Path) {
        # Only remove if the corresponding .md file exists
        $mdFile = $dir.Path + ".md"
        if (Test-Path $mdFile) {
            if (Remove-SafelyIfExists -Path $dir.Path -Reason $dir.Reason -IsDirectory) {
                $removedCount++
            }
        }
    }
}

# 4. Remove development artifacts and cache files
Write-Cleanup "Cleaning up development artifacts"
$artifactFiles = @(
    @{ Path = ".jekyll-metadata"; Reason = "Jekyll cache file" },
    @{ Path = "performance-report.md"; Reason = "Generated report (will be recreated)" }
)

foreach ($file in $artifactFiles) {
    if (Remove-SafelyIfExists -Path $file.Path -Reason $file.Reason) {
        $removedCount++
    }
}

# 5. Clean up old configuration files (if aggressive mode)
if ($Aggressive) {
    Write-Cleanup "Aggressive cleanup - removing legacy configurations"
    $aggressiveFiles = @(
        @{ Path = ".pre-commit-config.yaml"; Reason = "Pre-commit hooks not in use" },
        @{ Path = ".markdownlint.json"; Reason = "Markdown linting not actively used" },
        @{ Path = "lighthouserc.json"; Reason = "Lighthouse config moved to Docker testing" }
    )
    
    foreach ($file in $aggressiveFiles) {
        if (Remove-SafelyIfExists -Path $file.Path -Reason $file.Reason) {
            $removedCount++
        }
    }
}

# 6. Clean up empty directories
Write-Cleanup "Removing empty directories"
$emptyDirs = Get-ChildItem -Recurse -Directory | Where-Object {
    $_.FullName -notmatch "_site|node_modules|vendor|\.git" -and
    (Get-ChildItem $_.FullName -Force | Measure-Object).Count -eq 0
}

foreach ($dir in $emptyDirs) {
    if ($DryRun) {
        Write-Host "  [DRY RUN] Would remove empty directory: $($dir.FullName)" -ForegroundColor Gray
    } else {
        Remove-Item $dir.FullName -Force
        Write-Host "  ✅ Removed empty directory: $($dir.FullName)" -ForegroundColor Green
        $removedCount++
    }
}

# 7. Check for unused npm dependencies
Write-Cleanup "Analyzing npm dependencies"
if (Test-Path "package.json") {
    try {
        $packageJson = Get-Content "package.json" | ConvertFrom-Json
        $devDeps = $packageJson.devDependencies.PSObject.Properties.Name
        
        Write-Host "  Current dev dependencies:" -ForegroundColor Cyan
        $devDeps | ForEach-Object {
            Write-Host "    - $_" -ForegroundColor Gray
        }
        
        # Check for potentially unused dependencies
        $potentiallyUnused = @()
        $jsFiles = Get-ChildItem -Recurse -Include "*.js", "*.json" | Where-Object {
            $_.FullName -notmatch "node_modules|_site|vendor"
        }
        
        foreach ($dep in $devDeps) {
            $found = $false
            foreach ($jsFile in $jsFiles) {
                $content = Get-Content $jsFile.FullName -Raw -ErrorAction SilentlyContinue
                if ($content -match $dep) {
                    $found = $true
                    break
                }
            }
            if (-not $found) {
                $potentiallyUnused += $dep
            }
        }
        
        if ($potentiallyUnused.Count -gt 0) {
            Write-Host "  💡 Potentially unused dependencies:" -ForegroundColor Yellow
            $potentiallyUnused | ForEach-Object {
                Write-Host "    - $_" -ForegroundColor Yellow
            }
            Write-Host "  Review and remove manually if confirmed unused" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  ⚠️  Could not analyze package.json" -ForegroundColor Yellow
    }
}

# Summary
Write-Cleanup "Cleanup Summary" "Green"
Write-Host "  Files/directories processed: $removedCount" -ForegroundColor Green

if ($DryRun) {
    Write-Host "  ⚠️  DRY RUN - No files were actually removed" -ForegroundColor Yellow
    Write-Host "  Run without -DryRun to perform actual cleanup" -ForegroundColor Yellow
} else {
    Write-Host "  ✅ Cleanup completed!" -ForegroundColor Green
}

# Recommendations
Write-Host "`n💡 Additional cleanup recommendations:" -ForegroundColor Cyan
Write-Host "  1. Review and update .gitignore for new Docker files" -ForegroundColor White
Write-Host "  2. Consider removing old Git branches: git branch -d <branch>" -ForegroundColor White
Write-Host "  3. Clean Docker system periodically: docker system prune -f" -ForegroundColor White
Write-Host "  4. Review npm dependencies and remove unused packages" -ForegroundColor White
#!/usr/bin/env pwsh
# CSS Optimization Script
# Splits CSS into critical and non-critical parts for better performance

param(
    [switch]$Analyze,     # Analyze current CSS structure
    [switch]$Split,       # Split CSS into critical/non-critical
    [switch]$Minify,      # Minify CSS files
    [switch]$PurgeUnused, # Remove unused CSS (requires analysis)
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

function Write-Status {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "🎨 $Message" -ForegroundColor $Color
}

function Get-CSSFiles {
    return Get-ChildItem -Recurse -Include *.css | Where-Object {
        $_.FullName -notmatch "node_modules|vendor|_site|\.git"
    }
}

function Test-PurgeCSS {
    try {
        npx --yes purgecss --version >$null 2>&1
        return $LASTEXITCODE -eq 0
    }
    catch {
        return $false
    }
}

function Get-CSSSelectors {
    param([string]$CSSContent)
    
    # Simple regex to extract CSS selectors
    $selectors = @()
    $matches = [regex]::Matches($CSSContent, '([.#]?[\w-]+(?:\s*[>+~]\s*[\w-]+)*)\s*\{')
    
    foreach ($match in $matches) {
        $selector = $match.Groups[1].Value.Trim()
        if ($selector -notmatch '^@' -and $selector -ne '') {
            $selectors += $selector
        }
    }
    
    return $selectors
}

function Get-HTMLClasses {
    $htmlFiles = Get-ChildItem -Recurse -Include *.html,*.md | Where-Object {
        $_.FullName -notmatch "node_modules|vendor|\.git"
    }
    
    $usedClasses = @()
    $usedIds = @()
    
    foreach ($file in $htmlFiles) {
        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if ($content) {
            # Extract class names
            $classMatches = [regex]::Matches($content, 'class=["'']([^"'']+)["'']')
            foreach ($match in $classMatches) {
                $classes = $match.Groups[1].Value -split '\s+'
                $usedClasses += $classes
            }
            
            # Extract id names
            $idMatches = [regex]::Matches($content, 'id=["'']([^"'']+)["'']')
            foreach ($match in $idMatches) {
                $usedIds += $match.Groups[1].Value
            }
        }
    }
    
    return @{
        Classes = $usedClasses | Sort-Object | Get-Unique
        Ids = $usedIds | Sort-Object | Get-Unique
    }
}

$cssFiles = Get-CSSFiles

if ($cssFiles.Count -eq 0) {
    Write-Status "No CSS files found to optimize"
    exit 0
}

Write-Status "Found $($cssFiles.Count) CSS files"

if ($Analyze) {
    Write-Status "Analyzing CSS Structure"
    
    $totalSize = 0
    $totalSelectors = 0
    $cssAnalysis = @()
    
    foreach ($css in $cssFiles) {
        $content = Get-Content $css.FullName -Raw
        $selectors = Get-CSSSelectors $content
        $sizeKB = [math]::Round($css.Length / 1KB, 1)
        $totalSize += $css.Length
        $totalSelectors += $selectors.Count
        
        $analysis = @{
            Name = $css.Name
            Path = $css.FullName
            SizeKB = $sizeKB
            Selectors = $selectors.Count
            Lines = ($content -split "`n").Count
        }
        
        $cssAnalysis += $analysis
        
        if ($Verbose) {
            Write-Host "  $($css.Name): ${sizeKB}KB, $($selectors.Count) selectors, $($analysis.Lines) lines" -ForegroundColor Gray
        }
    }
    
    # Get usage analysis
    Write-Host "Analyzing HTML/template usage..." -ForegroundColor Gray
    $htmlUsage = Get-HTMLClasses
    
    $totalSizeMB = [math]::Round($totalSize / 1MB, 2)
    
    Write-Host "`n📊 CSS Analysis Results:" -ForegroundColor Cyan
    Write-Host "  Total CSS files: $($cssFiles.Count)" -ForegroundColor White
    Write-Host "  Total size: ${totalSizeMB}MB" -ForegroundColor White
    Write-Host "  Total selectors: $totalSelectors" -ForegroundColor White
    Write-Host "  Used CSS classes in HTML: $($htmlUsage.Classes.Count)" -ForegroundColor White
    Write-Host "  Used CSS IDs in HTML: $($htmlUsage.Ids.Count)" -ForegroundColor White
    
    Write-Host "`nFile breakdown:" -ForegroundColor Cyan
    $cssAnalysis | Sort-Object SizeKB -Descending | ForEach-Object {
        Write-Host "  - $($_.Name): $($_.SizeKB)KB ($($_.Selectors) selectors)" -ForegroundColor White
    }
    
    # Identify potential optimizations
    $largeFiles = $cssAnalysis | Where-Object { $_.SizeKB -gt 50 }
    if ($largeFiles.Count -gt 0) {
        Write-Host "`n⚠️  Large CSS files (>50KB):" -ForegroundColor Yellow
        $largeFiles | ForEach-Object {
            Write-Host "  - $($_.Name): $($_.SizeKB)KB" -ForegroundColor Yellow
        }
    }
    
    # Check for common utility classes
    $commonUtilities = @('flex', 'grid', 'hidden', 'block', 'inline', 'relative', 'absolute', 'fixed')
    $foundUtilities = $htmlUsage.Classes | Where-Object { $_ -in $commonUtilities }
    
    if ($foundUtilities.Count -gt 0) {
        Write-Host "`n💡 Consider using utility-first CSS for:" -ForegroundColor Cyan
        $foundUtilities | ForEach-Object {
            Write-Host "  - $_" -ForegroundColor White
        }
    }
}

if ($Split) {
    Write-Status "Splitting CSS into Critical and Non-Critical"
    
    # Define critical CSS selectors (above-the-fold)
    $criticalSelectors = @(
        'html', 'body', '*',
        '.dark-mode', '.mui-nav', '.mui-hero', '.mui-container',
        '.mui-btn', '.mui-card', 'nav', 'header', 'main',
        # Add Material UI critical selectors
        '.material-icons', '.mui-glass'
    )
    
    foreach ($css in $cssFiles) {
        if ($css.Name -eq 'critical.css') {
            Write-Host "  Skipping critical.css (already exists)" -ForegroundColor Gray
            continue
        }
        
        Write-Host "  Processing: $($css.Name)" -ForegroundColor Green
        
        $content = Get-Content $css.FullName -Raw
        $criticalCSS = ""
        $nonCriticalCSS = ""
        
        # Split CSS rules
        $rules = $content -split '\}'
        
        foreach ($rule in $rules) {
            if ($rule.Trim() -eq '') { continue }
            
            $isCritical = $false
            foreach ($criticalSelector in $criticalSelectors) {
                if ($rule -match [regex]::Escape($criticalSelector)) {
                    $isCritical = $true
                    break
                }
            }
            
            if ($isCritical) {
                $criticalCSS += $rule + "}`n"
            } else {
                $nonCriticalCSS += $rule + "}`n"
            }
        }
        
        # Save split files
        $baseName = $css.BaseName
        $criticalPath = Join-Path $css.Directory "${baseName}-critical.css"
        $nonCriticalPath = Join-Path $css.Directory "${baseName}-deferred.css"
        
        Set-Content -Path $criticalPath -Value $criticalCSS.Trim()
        Set-Content -Path $nonCriticalPath -Value $nonCriticalCSS.Trim()
        
        $criticalSize = [math]::Round((Get-Item $criticalPath).Length / 1KB, 1)
        $nonCriticalSize = [math]::Round((Get-Item $nonCriticalPath).Length / 1KB, 1)
        
        Write-Host "    Critical: ${criticalSize}KB" -ForegroundColor Green
        Write-Host "    Deferred: ${nonCriticalSize}KB" -ForegroundColor Green
    }
}

if ($Minify) {
    Write-Status "Minifying CSS Files"
    
    foreach ($css in $cssFiles) {
        $minifiedPath = $css.FullName -replace '\.css$', '.min.css'
        
        Write-Host "  Minifying: $($css.Name)" -ForegroundColor Green
        
        try {
            npx --yes clean-css-cli $css.FullName -o $minifiedPath --format breakWith=lf
            
            if ($LASTEXITCODE -eq 0) {
                $originalSize = [math]::Round($css.Length / 1KB, 1)
                $minifiedSize = [math]::Round((Get-Item $minifiedPath).Length / 1KB, 1)
                $savings = [math]::Round((1 - $minifiedSize / $originalSize) * 100, 1)
                
                Write-Host "    ${originalSize}KB → ${minifiedSize}KB (${savings}% smaller)" -ForegroundColor Green
            } else {
                Write-Host "    Failed to minify $($css.Name)" -ForegroundColor Red
            }
        }
        catch {
            Write-Host "    Error minifying $($css.Name): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

if ($PurgeUnused) {
    $hasPurgeCSS = Test-PurgeCSS
    
    if (-not $hasPurgeCSS) {
        Write-Host "⚠️  PurgeCSS not available. Install with: npm install -g purgecss" -ForegroundColor Yellow
    } else {
        Write-Status "Removing Unused CSS"
        
        # Get all HTML/template files for purging
        $contentFiles = Get-ChildItem -Recurse -Include *.html,*.md | Where-Object {
            $_.FullName -notmatch "node_modules|vendor|_site|\.git"
        }
        
        if ($contentFiles.Count -eq 0) {
            Write-Host "  No content files found for PurgeCSS analysis" -ForegroundColor Yellow
        } else {
            foreach ($css in $cssFiles) {
                $purgedPath = $css.FullName -replace '\.css$', '.purged.css'
                
                Write-Host "  Purging unused CSS: $($css.Name)" -ForegroundColor Green
                
                $contentPaths = $contentFiles.FullName -join ','
                
                try {
                    npx --yes purgecss --css $css.FullName --content $contentPaths --output $purgedPath
                    
                    if (Test-Path $purgedPath) {
                        $originalSize = [math]::Round($css.Length / 1KB, 1)
                        $purgedSize = [math]::Round((Get-Item $purgedPath).Length / 1KB, 1)
                        $savings = [math]::Round((1 - $purgedSize / $originalSize) * 100, 1)
                        
                        Write-Host "    ${originalSize}KB → ${purgedSize}KB (${savings}% reduction)" -ForegroundColor Green
                    } else {
                        Write-Host "    PurgeCSS output not created" -ForegroundColor Red
                    }
                }
                catch {
                    Write-Host "    Error purging $($css.Name): $($_.Exception.Message)" -ForegroundColor Red
                }
            }
        }
    }
}

Write-Status "CSS optimization completed"
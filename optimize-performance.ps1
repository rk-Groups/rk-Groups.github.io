# Performance Optimization Script for RK Groups Website
# This script optimizes CSS, JavaScript, and images for faster loading

param(
    [switch]$SkipCSS,
    [switch]$SkipJS,
    [switch]$SkipImages,
    [switch]$Force
)

function Write-Step($message) {
    Write-Host "`n=== $message ===" -ForegroundColor Cyan
}

function Write-Success($message) {
    Write-Host "✅ $message" -ForegroundColor Green
}

function Write-Warning($message) {
    Write-Host "⚠️  $message" -ForegroundColor Yellow
}

function Test-Command($command) {
    try {
        if (Get-Command $command -ErrorAction SilentlyContinue) {
            return $true
        }
        return $false
    }
    catch {
        return $false
    }
}

try {
    Write-Step "RK Groups Performance Optimization"

    # Check we're in the right directory
    if (-not (Test-Path "_config.yml")) {
        throw "Not in Jekyll root directory. Please run from repository root."
    }

    # Check for Node.js tools
    $NodeAvailable = Test-Command "node"
    if (-not $NodeAvailable) {
        Write-Warning "Node.js not available. Some optimizations will be skipped."
    }

    # 1. CSS Optimization
    if (-not $SkipCSS) {
        Write-Step "Step 1: CSS Optimization"
        
        $cssFiles = Get-ChildItem -Path "assets/css" -Filter "*.css" | Where-Object { -not $_.Name.EndsWith('.min.css') }
        
        if ($cssFiles.Count -gt 0) {
            foreach ($cssFile in $cssFiles) {
                $inputPath = $cssFile.FullName
                $outputPath = $inputPath -replace '\.css$', '.min.css'
                
                if ($Force -or -not (Test-Path $outputPath) -or (Get-Item $inputPath).LastWriteTime -gt (Get-Item $outputPath -ErrorAction SilentlyContinue).LastWriteTime) {
                    if ($NodeAvailable) {
                        Write-Host "Minifying $($cssFile.Name)..."
                        npx --yes clean-css-cli -o $outputPath $inputPath
                        if ($LASTEXITCODE -eq 0) {
                            $originalSize = (Get-Item $inputPath).Length
                            $minifiedSize = (Get-Item $outputPath).Length
                            $savings = [Math]::Round((($originalSize - $minifiedSize) / $originalSize) * 100, 1)
                            Write-Success "Minified $($cssFile.Name): $originalSize → $minifiedSize bytes ($savings% savings)"
                        } else {
                            Write-Warning "Failed to minify $($cssFile.Name)"
                        }
                    } else {
                        # Basic CSS minification using PowerShell
                        Write-Host "Basic CSS optimization for $($cssFile.Name)..."
                        $content = Get-Content $inputPath -Raw
                        $minified = $content -replace '\/\*[^*]*\*+([^/][^*]*\*+)*\/', '' # Remove comments
                        $minified = $minified -replace '\s+', ' ' # Collapse whitespace
                        $minified = $minified -replace ';\s*}', '}' # Remove semicolon before closing brace
                        $minified = $minified -replace '\s*{\s*', '{' # Clean up around braces
                        $minified = $minified -replace '\s*}\s*', '}' # Clean up around braces
                        $minified = $minified -replace '\s*;\s*', ';' # Clean up around semicolons
                        $minified = $minified.Trim()
                        
                        Set-Content $outputPath -Value $minified -NoNewline
                        
                        $originalSize = (Get-Item $inputPath).Length
                        $minifiedSize = (Get-Item $outputPath).Length
                        $savings = [Math]::Round((($originalSize - $minifiedSize) / $originalSize) * 100, 1)
                        Write-Success "Basic minified $($cssFile.Name): $originalSize → $minifiedSize bytes ($savings% savings)"
                    }
                } else {
                    Write-Host "Skipping $($cssFile.Name) (already up to date)"
                }
            }
        } else {
            Write-Warning "No CSS files found to optimize"
        }
    }

    # 2. JavaScript Optimization
    if (-not $SkipJS) {
        Write-Step "Step 2: JavaScript Optimization"
        
        $jsFiles = Get-ChildItem -Path . -Recurse -Filter "*.js" | Where-Object { 
            -not $_.Name.EndsWith('.min.js') -and 
            $_.FullName -notmatch "node_modules|_site|vendor" 
        }
        
        if ($jsFiles.Count -gt 0) {
            foreach ($jsFile in $jsFiles) {
                $inputPath = $jsFile.FullName
                $outputPath = $inputPath -replace '\.js$', '.min.js'
                
                if ($Force -or -not (Test-Path $outputPath) -or (Get-Item $inputPath).LastWriteTime -gt (Get-Item $outputPath -ErrorAction SilentlyContinue).LastWriteTime) {
                    if ($NodeAvailable) {
                        Write-Host "Minifying $($jsFile.Name)..."
                        npx --yes terser $inputPath --compress --mangle --output $outputPath
                        if ($LASTEXITCODE -eq 0) {
                            $originalSize = (Get-Item $inputPath).Length
                            $minifiedSize = (Get-Item $outputPath).Length
                            $savings = [Math]::Round((($originalSize - $minifiedSize) / $originalSize) * 100, 1)
                            Write-Success "Minified $($jsFile.Name): $originalSize → $minifiedSize bytes ($savings% savings)"
                        } else {
                            Write-Warning "Failed to minify $($jsFile.Name)"
                        }
                    } else {
                        # Basic JS minification using PowerShell (very basic)
                        Write-Host "Basic JS optimization for $($jsFile.Name)..."
                        $content = Get-Content $inputPath -Raw
                        $minified = $content -replace '\/\/.*$', '', 'Multiline' # Remove single-line comments
                        $minified = $minified -replace '\/\*[^*]*\*+([^/][^*]*\*+)*\/', '' # Remove multi-line comments
                        $minified = $minified -replace '\s+', ' ' # Collapse whitespace
                        $minified = $minified.Trim()
                        
                        Set-Content $outputPath -Value $minified -NoNewline
                        
                        $originalSize = (Get-Item $inputPath).Length
                        $minifiedSize = (Get-Item $outputPath).Length
                        $savings = [Math]::Round((($originalSize - $minifiedSize) / $originalSize) * 100, 1)
                        Write-Success "Basic minified $($jsFile.Name): $originalSize → $minifiedSize bytes ($savings% savings)"
                    }
                } else {
                    Write-Host "Skipping $($jsFile.Name) (already up to date)"
                }
            }
        } else {
            Write-Warning "No JavaScript files found to optimize"
        }
    }

    # 3. Image Optimization (if requested and tools available)
    if (-not $SkipImages) {
        Write-Step "Step 3: Image Optimization"
        
        $imageExtensions = @("*.jpg", "*.jpeg", "*.png", "*.gif", "*.svg")
        $imageFiles = @()
        
        foreach ($extension in $imageExtensions) {
            $files = Get-ChildItem -Path "assets" -Recurse -Filter $extension -ErrorAction SilentlyContinue
            $imageFiles += $files
        }
        
        if ($imageFiles.Count -gt 0) {
            Write-Host "Found $($imageFiles.Count) image files"
            
            if ($NodeAvailable) {
                # Check for imagemin
                try {
                    npx --yes imagemin-cli --version > $null 2>&1
                    if ($LASTEXITCODE -eq 0) {
                        Write-Host "Optimizing images with imagemin..."
                        npx --yes imagemin "assets/images/*" --out-dir="assets/images/optimized" --plugin=imagemin-mozjpeg --plugin=imagemin-pngquant
                        if ($LASTEXITCODE -eq 0) {
                            Write-Success "Images optimized and saved to assets/images/optimized/"
                        } else {
                            Write-Warning "Image optimization failed, continuing..."
                        }
                    } else {
                        Write-Warning "imagemin-cli not available. Skipping image optimization."
                    }
                }
                catch {
                    Write-Warning "Image optimization not available: $($_.Exception.Message)"
                }
            } else {
                Write-Warning "Node.js not available. Skipping image optimization."
            }
        } else {
            Write-Warning "No images found to optimize"
        }
    }

    # 4. Generate Performance Report
    Write-Step "Step 4: Performance Report"
    
    $report = @()
    $totalOriginalSize = 0
    $totalMinifiedSize = 0
    
    # CSS Files
    $cssFiles = Get-ChildItem -Path "assets/css" -Filter "*.css" | Where-Object { -not $_.Name.EndsWith('.min.css') }
    foreach ($cssFile in $cssFiles) {
        $originalPath = $cssFile.FullName
        $minifiedPath = $originalPath -replace '\.css$', '.min.css'
        
        if (Test-Path $minifiedPath) {
            $originalSize = (Get-Item $originalPath).Length
            $minifiedSize = (Get-Item $minifiedPath).Length
            $savings = $originalSize - $minifiedSize
            $totalOriginalSize += $originalSize
            $totalMinifiedSize += $minifiedSize
            
            $report += [PSCustomObject]@{
                File = $cssFile.Name
                Type = "CSS"
                Original = $originalSize
                Minified = $minifiedSize
                Savings = $savings
                Percent = [Math]::Round(($savings / $originalSize) * 100, 1)
            }
        }
    }
    
    # JS Files
    $jsFiles = Get-ChildItem -Path . -Recurse -Filter "*.js" | Where-Object { 
        -not $_.Name.EndsWith('.min.js') -and 
        $_.FullName -notmatch "node_modules|_site|vendor" 
    }
    foreach ($jsFile in $jsFiles) {
        $originalPath = $jsFile.FullName
        $minifiedPath = $originalPath -replace '\.js$', '.min.js'
        
        if (Test-Path $minifiedPath) {
            $originalSize = (Get-Item $originalPath).Length
            $minifiedSize = (Get-Item $minifiedPath).Length
            $savings = $originalSize - $minifiedSize
            $totalOriginalSize += $originalSize
            $totalMinifiedSize += $minifiedSize
            
            $report += [PSCustomObject]@{
                File = $jsFile.Name
                Type = "JS"
                Original = $originalSize
                Minified = $minifiedSize
                Savings = $savings
                Percent = [Math]::Round(($savings / $originalSize) * 100, 1)
            }
        }
    }
    
    if ($report.Count -gt 0) {
        Write-Host "`nOptimization Summary:" -ForegroundColor Yellow
        $report | Format-Table -Property File, Type, Original, Minified, Savings, Percent
        
        $totalSavings = $totalOriginalSize - $totalMinifiedSize
        $totalPercent = if ($totalOriginalSize -gt 0) { [Math]::Round(($totalSavings / $totalOriginalSize) * 100, 1) } else { 0 }
        
        Write-Success "Total Optimization: $totalOriginalSize → $totalMinifiedSize bytes"
        Write-Success "Total Savings: $totalSavings bytes ($totalPercent%)"
    } else {
        Write-Warning "No files were optimized"
    }

    # 5. Performance Recommendations
    Write-Step "Step 5: Performance Recommendations"
    
    Write-Host "🚀 Performance Recommendations:" -ForegroundColor Yellow
    Write-Host "1. Use minified CSS/JS files in production by updating _includes to reference .min.css and .min.js"
    Write-Host "2. Enable GZIP compression on your web server"
    Write-Host "3. Set appropriate cache headers for static assets"
    Write-Host "4. Consider using a CDN for static assets"
    Write-Host "5. Optimize images before uploading (use WebP format when possible)"
    Write-Host "6. Enable Jekyll's built-in sass compression: sass: style: compressed"
    Write-Host "7. Use Jekyll's --incremental flag for faster development builds"
    
    Write-Success "Performance optimization completed!"

}
catch {
    Write-Error "Performance optimization failed: $($_.Exception.Message)"
    exit 1
}
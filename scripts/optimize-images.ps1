#!/usr/bin/env pwsh
# Image Optimization Script
# Optimizes images for web performance with multiple formats

param(
    [switch]$WebP,        # Convert to WebP format
    [switch]$AVIF,        # Convert to AVIF format (if supported)
    [switch]$Optimize,    # Optimize existing formats
    [switch]$Analyze,     # Analyze current images
    [string]$Quality = "85", # Quality setting for compression
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

function Write-Status {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "🖼️  $Message" -ForegroundColor $Color
}

function Get-ImageFiles {
    return Get-ChildItem -Recurse -Include *.jpg,*.jpeg,*.png,*.gif,*.svg | Where-Object {
        $_.FullName -notmatch "node_modules|vendor|_site|\.git"
    }
}

function Test-ImageMagick {
    try {
        magick -version >$null 2>&1
        return $LASTEXITCODE -eq 0
    }
    catch {
        return $false
    }
}

# Check if we have optimization tools available
$hasImageMagick = Test-ImageMagick
$hasSharp = $false

try {
    npx --yes sharp-cli --version >$null 2>&1
    $hasSharp = $LASTEXITCODE -eq 0
}
catch {
    $hasSharp = $false
}

Write-Status "Image Optimization Tool Check"
Write-Host "  ImageMagick: $(if ($hasImageMagick) { '✅ Available' } else { '❌ Not found' })" -ForegroundColor $(if ($hasImageMagick) { 'Green' } else { 'Red' })
Write-Host "  Sharp (npm): $(if ($hasSharp) { '✅ Available' } else { '❌ Not found' })" -ForegroundColor $(if ($hasSharp) { 'Green' } else { 'Red' })

if (-not $hasImageMagick -and -not $hasSharp) {
    Write-Host "`n💡 To optimize images, install one of:" -ForegroundColor Yellow
    Write-Host "   • ImageMagick: https://imagemagick.org/script/download.php" -ForegroundColor White
    Write-Host "   • Sharp via npm: npm install -g sharp-cli" -ForegroundColor White
    if (-not $Analyze) {
        exit 1
    }
}

$images = Get-ImageFiles

if ($images.Count -eq 0) {
    Write-Status "No images found to optimize"
    exit 0
}

Write-Status "Found $($images.Count) image files"

if ($Analyze) {
    Write-Status "Analyzing Images"
    
    $totalSize = 0
    $largeImages = @()
    $unoptimizedImages = @()
    
    foreach ($image in $images) {
        $sizeKB = [math]::Round($image.Length / 1KB, 1)
        $totalSize += $image.Length
        
        if ($Verbose) {
            Write-Host "  $($image.Name): ${sizeKB}KB" -ForegroundColor Gray
        }
        
        if ($image.Length -gt 100KB) {
            $largeImages += @{
                Name = $image.Name
                Path = $image.FullName
                SizeKB = $sizeKB
            }
        }
        
        # Check if there's a corresponding WebP version
        $webpPath = $image.FullName -replace '\.(jpg|jpeg|png)$', '.webp'
        if (-not (Test-Path $webpPath)) {
            $unoptimizedImages += $image
        }
    }
    
    $totalSizeMB = [math]::Round($totalSize / 1MB, 2)
    
    Write-Host "`n📊 Image Analysis Results:" -ForegroundColor Cyan
    Write-Host "  Total images: $($images.Count)" -ForegroundColor White
    Write-Host "  Total size: ${totalSizeMB}MB" -ForegroundColor White
    Write-Host "  Large images (>100KB): $($largeImages.Count)" -ForegroundColor $(if ($largeImages.Count -gt 0) { 'Yellow' } else { 'Green' })
    Write-Host "  Missing WebP versions: $($unoptimizedImages.Count)" -ForegroundColor $(if ($unoptimizedImages.Count -gt 0) { 'Yellow' } else { 'Green' })
    
    if ($largeImages.Count -gt 0) {
        Write-Host "`n⚠️  Large images that should be optimized:" -ForegroundColor Yellow
        $largeImages | Sort-Object SizeKB -Descending | ForEach-Object {
            Write-Host "  - $($_.Name): $($_.SizeKB)KB" -ForegroundColor Yellow
        }
    }
    
    if ($unoptimizedImages.Count -gt 0 -and ($hasImageMagick -or $hasSharp)) {
        Write-Host "`n💡 Run with -WebP to create optimized WebP versions" -ForegroundColor Cyan
    }
}

if ($Optimize -or $WebP) {
    if (-not $hasImageMagick -and -not $hasSharp) {
        Write-Host "❌ No image optimization tools available" -ForegroundColor Red
        exit 1
    }
    
    Write-Status "Optimizing Images"
    
    $optimized = 0
    $errors = 0
    
    foreach ($image in $images) {
        try {
            if ($WebP -and $image.Extension -match '\.(jpg|jpeg|png)$') {
                $webpPath = $image.FullName -replace '\.(jpg|jpeg|png)$', '.webp'
                
                if (Test-Path $webpPath) {
                    if ($Verbose) {
                        Write-Host "  Skipping $($image.Name) (WebP exists)" -ForegroundColor Gray
                    }
                    continue
                }
                
                Write-Host "  Creating WebP: $($image.Name)" -ForegroundColor Green
                
                if ($hasSharp) {
                    npx --yes sharp-cli -i $image.FullName -o $webpPath --webp.quality=$Quality
                } elseif ($hasImageMagick) {
                    magick $image.FullName -quality $Quality $webpPath
                }
                
                if ($LASTEXITCODE -eq 0) {
                    $optimized++
                    
                    # Compare sizes
                    $originalSize = [math]::Round($image.Length / 1KB, 1)
                    $webpSize = [math]::Round((Get-Item $webpPath).Length / 1KB, 1)
                    $savings = [math]::Round((1 - $webpSize / $originalSize) * 100, 1)
                    
                    if ($Verbose) {
                        Write-Host "    Original: ${originalSize}KB → WebP: ${webpSize}KB (${savings}% smaller)" -ForegroundColor Green
                    }
                } else {
                    $errors++
                    Write-Host "    Failed to convert $($image.Name)" -ForegroundColor Red
                }
            }
            
            if ($Optimize -and $image.Extension -match '\.(jpg|jpeg|png)$') {
                $backupPath = "$($image.FullName).backup"
                
                # Create backup
                Copy-Item $image.FullName $backupPath
                
                Write-Host "  Optimizing: $($image.Name)" -ForegroundColor Green
                
                if ($hasSharp) {
                    if ($image.Extension -match '\.png$') {
                        npx --yes sharp-cli -i $image.FullName -o $image.FullName --png.quality=$Quality --png.progressive
                    } else {
                        npx --yes sharp-cli -i $image.FullName -o $image.FullName --jpeg.quality=$Quality --jpeg.progressive
                    }
                } elseif ($hasImageMagick) {
                    magick $image.FullName -quality $Quality -strip $image.FullName
                }
                
                if ($LASTEXITCODE -eq 0) {
                    $optimized++
                    
                    # Compare sizes
                    $originalSize = [math]::Round((Get-Item $backupPath).Length / 1KB, 1)
                    $newSize = [math]::Round($image.Length / 1KB, 1)
                    $savings = [math]::Round((1 - $newSize / $originalSize) * 100, 1)
                    
                    if ($Verbose) {
                        Write-Host "    ${originalSize}KB → ${newSize}KB (${savings}% smaller)" -ForegroundColor Green
                    }
                    
                    # Remove backup if optimization successful
                    Remove-Item $backupPath
                } else {
                    $errors++
                    Write-Host "    Failed to optimize $($image.Name)" -ForegroundColor Red
                    # Restore from backup
                    Move-Item $backupPath $image.FullName -Force
                }
            }
        }
        catch {
            $errors++
            Write-Host "  Error processing $($image.Name): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    
    Write-Host "`n✅ Optimization complete!" -ForegroundColor Green
    Write-Host "  Images processed: $optimized" -ForegroundColor Green
    Write-Host "  Errors: $errors" -ForegroundColor $(if ($errors -gt 0) { 'Red' } else { 'Green' })
}

Write-Status "Image optimization script completed"
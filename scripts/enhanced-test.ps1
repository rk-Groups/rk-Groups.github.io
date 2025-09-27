#!/usr/bin/env pwsh
# Enhanced Docker-Based Testing Script
# Provides comprehensive testing using Docker containers for consistent cross-platform results

param(
    [switch]$SkipBuild,
    [switch]$SkipLighthouse,
    [switch]$SkipAxe,
    [switch]$SkipLinkCheck,
    [switch]$Parallel,
    [switch]$Verbose,
    [switch]$CleanupAfter
)

$ErrorActionPreference = "Stop"
$OriginalLocation = Get-Location

# Enhanced environment setup
$env:NPM_CONFIG_FUND = "false"
$env:NPM_CONFIG_AUDIT = "false"
$env:NPM_CONFIG_UPDATE_NOTIFIER = "false"
$env:NPM_CONFIG_PROGRESS = "false"
$env:NODE_NO_WARNINGS = "1"
$env:COMPOSE_PROJECT_NAME = "rk-groups-testing"

function Write-Step {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "`n🚀 === $Message ===" -ForegroundColor $Color
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Test-DockerRunning {
    try {
        $dockerInfo = docker info 2>$null
        return $LASTEXITCODE -eq 0
    }
    catch {
        return $false
    }
}

function Start-TestEnvironment {
    Write-Step "Starting Docker Test Environment"
    
    # Clean up any existing containers
    docker-compose -f docker-compose.test.yml down --remove-orphans 2>$null
    
    # Start services based on what tests we're running
    $services = @('jekyll-build')
    if (-not $SkipLighthouse) {
        $services += 'node-testing'
        $services += 'http-server'
    }
    
    Write-Host "Starting services: $($services -join ', ')"
    docker-compose -f docker-compose.test.yml up -d $services
    
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to start Docker test environment"
    }
    
    # Wait for services to be ready
    Write-Host "Waiting for services to initialize..."
    Start-Sleep -Seconds 10
    
    Write-Success "Docker test environment ready"
}

function Stop-TestEnvironment {
    if ($CleanupAfter) {
        Write-Step "Cleaning Up Test Environment"
        docker-compose -f docker-compose.test.yml down --remove-orphans --volumes
        Write-Success "Test environment cleaned up"
    }
}

function Test-JekyllBuild {
    Write-Step "Testing Jekyll Build in Docker"
    
    # Run Jekyll build
    $buildResult = docker-compose -f docker-compose.test.yml run --rm jekyll-build
    
    if ($LASTEXITCODE -ne 0) {
        throw "Jekyll build failed in Docker"
    }
    
    # Verify _site directory was created
    if (-not (Test-Path "_site")) {
        throw "_site directory not created by Docker build"
    }
    
    # Check for key files
    $keyFiles = @(
        "_site/index.html",
        "_site/companies/index.html", 
        "_site/Calc/GST/index.html",
        "_site/companies/rk-oxygen/gorakhpur/index.html"
    )
    
    $missingFiles = @()
    foreach ($file in $keyFiles) {
        if (-not (Test-Path $file)) {
            $missingFiles += $file
        }
    }
    
    if ($missingFiles.Count -gt 0) {
        Write-Warning "Missing expected files: $($missingFiles -join ', ')"
    } else {
        Write-Success "All key files generated successfully"
    }
    
    Write-Success "Jekyll build completed successfully"
}

function Test-LinkIntegrity {
    if ($SkipLinkCheck) {
        Write-Warning "Skipping link integrity check"
        return
    }
    
    Write-Step "Testing Link Integrity"
    
    # Use Docker Node.js service to run link checking
    $linkCheckScript = @"
const fs = require('fs');
const path = require('path');

function findHtmlFiles(dir) {
    const files = [];
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    
    for (const entry of entries) {
        const fullPath = path.join(dir, entry.name);
        if (entry.isDirectory() && !entry.name.startsWith('.')) {
            files.push(...findHtmlFiles(fullPath));
        } else if (entry.isFile() && entry.name.endsWith('.html')) {
            files.push(fullPath);
        }
    }
    return files;
}

function checkLinks(htmlFiles) {
    let totalLinks = 0;
    let brokenLinks = [];
    
    for (const file of htmlFiles) {
        const content = fs.readFileSync(file, 'utf8');
        const linkRegex = /href=["']([^"'#]+)/g;
        let match;
        
        while ((match = linkRegex.exec(content)) !== null) {
            const link = match[1];
            totalLinks++;
            
            // Skip external links and mailto
            if (link.startsWith('http') || link.startsWith('mailto')) {
                continue;
            }
            
            // Check internal links
            let checkPath = link.startsWith('/') ? 
                path.join('_site', link.slice(1)) : 
                path.resolve(path.dirname(file), link);
                
            // Try different variations
            const variations = [
                checkPath,
                path.join(checkPath, 'index.html'),
                checkPath + '.html',
                checkPath + '/index.html'
            ];
            
            let found = false;
            for (const variation of variations) {
                if (fs.existsSync(variation)) {
                    found = true;
                    break;
                }
            }
            
            if (!found) {
                brokenLinks.push({
                    link: link,
                    file: file.replace('_site/', ''),
                    variations: variations
                });
            }
        }
    }
    
    console.log(\`📊 Link Check Results:\`);
    console.log(\`  Total links checked: \${totalLinks}\`);
    console.log(\`  Broken links found: \${brokenLinks.length}\`);
    
    if (brokenLinks.length > 0) {
        console.log('❌ Broken links:');
        brokenLinks.forEach(broken => {
            console.log(\`  - \${broken.link} (in \${broken.file})\`);
        });
        process.exit(1);
    } else {
        console.log('✅ All internal links are valid!');
    }
}

const htmlFiles = findHtmlFiles('_site');
console.log(\`Found \${htmlFiles.length} HTML files to check\`);
checkLinks(htmlFiles);
"@
    
    # Write script to temp file
    $scriptPath = Join-Path $PWD "temp-link-check.js"
    Set-Content -Path $scriptPath -Value $linkCheckScript
    
    try {
        # Run link checking in Docker
        docker-compose -f docker-compose.test.yml exec -T node-testing node /app/temp-link-check.js
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Link integrity check passed"
        } else {
            throw "Link integrity check failed"
        }
    }
    finally {
        Remove-Item $scriptPath -ErrorAction SilentlyContinue
    }
}

function Test-Performance {
    if ($SkipLighthouse) {
        Write-Warning "Skipping performance testing"
        return
    }
    
    Write-Step "Testing Performance with Lighthouse"
    
    # Wait for HTTP server to be ready
    Write-Host "Waiting for HTTP server to be ready..."
    $maxRetries = 30
    $retryCount = 0
    
    while ($retryCount -lt $maxRetries) {
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:8080" -TimeoutSec 3 -ErrorAction SilentlyContinue
            if ($response.StatusCode -eq 200) {
                break
            }
        }
        catch {
            Start-Sleep -Seconds 1
            $retryCount++
        }
    }
    
    if ($retryCount -ge $maxRetries) {
        throw "HTTP server not responding after $maxRetries seconds"
    }
    
    Write-Success "HTTP server is ready"
    
    # Define test URLs
    $testUrls = @(
        "http://localhost:8080/",
        "http://localhost:8080/companies/",
        "http://localhost:8080/companies/rk-oxygen/gorakhpur/",
        "http://localhost:8080/Calc/GST/"
    )
    
    # Run Lighthouse tests
    foreach ($url in $testUrls) {
        Write-Host "Testing performance: $url"
        
        try {
            # Run Lighthouse in Docker Node service
            $lighthouseCmd = "npx --yes lighthouse '$url' --output=json --output=html --output-path=/app/lighthouse-results.json --chrome-flags='--headless --no-sandbox --disable-dev-shm-usage' --throttling-method=devtools --quiet"
            
            docker-compose -f docker-compose.test.yml exec -T node-testing sh -c $lighthouseCmd
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Lighthouse passed: $url"
                
                # Extract scores from results if verbose
                if ($Verbose -and (Test-Path "lighthouse-results.json")) {
                    $results = Get-Content "lighthouse-results.json" | ConvertFrom-Json
                    $scores = $results.categories
                    Write-Host "  Performance: $([math]::Round($scores.performance.score * 100))%" -ForegroundColor Yellow
                    Write-Host "  Accessibility: $([math]::Round($scores.accessibility.score * 100))%" -ForegroundColor Yellow
                    Write-Host "  Best Practices: $([math]::Round($scores.'best-practices'.score * 100))%" -ForegroundColor Yellow
                    Write-Host "  SEO: $([math]::Round($scores.seo.score * 100))%" -ForegroundColor Yellow
                }
            } else {
                Write-Warning "Lighthouse issues found for $url (non-blocking)"
            }
        }
        catch {
            Write-Warning "Lighthouse test failed for $url`: $($_.Exception.Message)"
        }
    }
}

function Test-Accessibility {
    if ($SkipAxe) {
        Write-Warning "Skipping accessibility testing"
        return
    }
    
    Write-Step "Testing Accessibility with axe-core"
    
    $testUrls = @(
        "http://localhost:8080/",
        "http://localhost:8080/companies/"
    )
    
    foreach ($url in $testUrls) {
        Write-Host "Accessibility test: $url"
        
        try {
            $axeCmd = "npx --yes @axe-core/cli '$url'"
            docker-compose -f docker-compose.test.yml exec -T node-testing sh -c $axeCmd
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Accessibility check passed: $url"
            } else {
                Write-Warning "Accessibility issues found for $url (review recommended)"
            }
        }
        catch {
            Write-Warning "Accessibility test failed for $url`: $($_.Exception.Message)"
        }
    }
}

function Test-AssetOptimization {
    Write-Step "Testing Asset Optimization"
    
    # Check for unoptimized assets
    $imageFiles = Get-ChildItem -Recurse -Path "_site" -Include *.png,*.jpg,*.jpeg,*.gif,*.svg | Where-Object { 
        $_.Length -gt 100KB 
    }
    
    if ($imageFiles.Count -gt 0) {
        Write-Warning "Large image files found (>100KB):"
        $imageFiles | ForEach-Object {
            $sizeKB = [math]::Round($_.Length / 1KB, 1)
            Write-Host "  - $($_.Name): ${sizeKB}KB" -ForegroundColor Yellow
        }
    } else {
        Write-Success "No oversized images found"
    }
    
    # Check CSS/JS file sizes
    $cssFiles = Get-ChildItem -Recurse -Path "_site" -Include *.css
    $jsFiles = Get-ChildItem -Recurse -Path "_site" -Include *.js
    
    $totalCssSize = ($cssFiles | Measure-Object -Property Length -Sum).Sum
    $totalJsSize = ($jsFiles | Measure-Object -Property Length -Sum).Sum
    
    Write-Host "Asset Summary:"
    Write-Host "  CSS: $([math]::Round($totalCssSize / 1KB, 1))KB ($($cssFiles.Count) files)" -ForegroundColor Cyan
    Write-Host "  JS: $([math]::Round($totalJsSize / 1KB, 1))KB ($($jsFiles.Count) files)" -ForegroundColor Cyan
    
    if ($totalCssSize -gt 50KB) {
        Write-Warning "CSS bundle is large (>50KB) - consider code splitting"
    }
    if ($totalJsSize -gt 100KB) {
        Write-Warning "JavaScript bundle is large (>100KB) - consider code splitting"
    }
}

# Main execution
try {
    Write-Step "Enhanced Docker-Based Testing Suite Starting"
    
    # Verify prerequisites
    if (-not (Test-Path "_config.yml")) {
        throw "Not in Jekyll root directory. Please run from repository root."
    }
    
    if (-not (Test-DockerRunning)) {
        throw "Docker is not running. Please start Docker and try again."
    }
    
    # Start test environment
    Start-TestEnvironment
    
    # Run tests based on parameters
    if (-not $SkipBuild) {
        Test-JekyllBuild
    }
    
    Test-LinkIntegrity
    Test-AssetOptimization
    
    if (-not $SkipLighthouse -or -not $SkipAxe) {
        # Start HTTP server for client-side testing
        Write-Host "Starting HTTP server for client-side tests..."
        docker-compose -f docker-compose.test.yml up -d http-server
        Start-Sleep -Seconds 5
        
        Test-Performance
        Test-Accessibility
    }
    
    # Success summary
    Write-Step "All Docker Tests Complete!" "Green"
    Write-Success "✅ Enhanced Docker-based testing passed!"
    Write-Host "`nYour site is ready for deployment! 🚀" -ForegroundColor Cyan
    Write-Host "Available at: http://localhost:8080" -ForegroundColor Yellow
    
}
catch {
    Write-Error "Test failed: $($_.Exception.Message)"
    Write-Host "`n💡 Fix the issues above before proceeding." -ForegroundColor Yellow
    exit 1
}
finally {
    Set-Location $OriginalLocation
    Stop-TestEnvironment
}
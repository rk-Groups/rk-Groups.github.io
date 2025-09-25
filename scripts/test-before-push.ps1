#!/usr/bin/env pwsh
# Local Workflow Testing Script
# Runs all major workflow checks locally before pushing to prevent CI failures

param(
    [switch]$SkipBuild,
    [switch]$SkipLighthouse,
    [switch]$SkipAxe,
    [switch]$SkipJekyll,
    [switch]$SkipLinkTraversal,
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"
$OriginalLocation = Get-Location

# Set enhanced NPM config to suppress deprecation warnings
$env:NPM_CONFIG_FUND = "false"
$env:NPM_CONFIG_AUDIT = "false"
$env:NPM_CONFIG_UPDATE_NOTIFIER = "false"
$env:NPM_CONFIG_WARNINGS = "false"
$env:NPM_CONFIG_PROGRESS = "false"
$env:NODE_NO_WARNINGS = "1"
$env:SUPPRESS_NO_CONFIG_WARNING = "true"

function Write-Step {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "`n=== $Message ===" -ForegroundColor $Color
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

function Test-Command {
    param([string]$Command)
    try {
        if (Get-Command $Command -ErrorAction SilentlyContinue) {
            return $true
        }
        return $false
    }
    catch {
        return $false
    }
}

try {
    Write-Step "Starting Local Workflow Tests"

    # Check we're in the right directory
    if (-not (Test-Path "_config.yml")) {
        throw "Not in Jekyll root directory. Please run from repository root."
    }

    # 1. Pull Latest Changes
    Write-Step "Step 1: Pulling Latest Changes"
    git pull
    if ($LASTEXITCODE -ne 0) {
        throw "Git pull failed"
    }
    Write-Success "Git pull completed"

    # 2. Check Dependencies
    Write-Step "Step 2: Checking Dependencies"

    $JekyllAvailable = $true
    if (-not $SkipJekyll) {
        if (-not (Test-Command "bundle")) {
            Write-Warning "Bundler not found. Jekyll-related tests will be skipped."
            Write-Host "To install Ruby and Bundler: https://jekyllrb.com/docs/installation/" -ForegroundColor Yellow
            $JekyllAvailable = $false
        } else {
            Write-Success "Ruby/Bundler found"
        }
    } else {
        Write-Warning "Skipping Jekyll dependency check (--SkipJekyll specified)"
        $JekyllAvailable = $false
    }

    if (-not (Test-Command "node")) {
        Write-Warning "Node.js not found locally. Some tests will be skipped."
        $NodeAvailable = $false
    } else {
        Write-Success "Node.js found"
        $NodeAvailable = $true
    }

    # 3. Install Jekyll Dependencies
    if ($JekyllAvailable -and -not $SkipBuild) {
        Write-Step "Step 3: Installing Jekyll Dependencies"
        bundle install --path vendor/bundle
        if ($LASTEXITCODE -ne 0) {
            throw "Bundle install failed"
        }
        Write-Success "Jekyll dependencies installed"
    } else {
        Write-Warning "Skipping Jekyll dependencies (Jekyll not available or --SkipBuild specified)"
    }

    # 3.5. Asset Minification
    Write-Step "Step 3.5: Minifying Assets"
    if (Test-Command "npm") {
        try {
            npm run minify
            Write-Success "Asset minification completed"
        } catch {
            Write-Warning "Asset minification failed, but continuing: $($_.Exception.Message)"
        }
    } else {
        Write-Warning "npm not found, skipping asset minification"
    }

    # 4. Jekyll Build Test
    if ($JekyllAvailable -and -not $SkipBuild) {
        Write-Step "Step 4: Testing Jekyll Build"
        bundle exec jekyll build --trace
        if ($LASTEXITCODE -ne 0) {
            throw "Jekyll build failed"
        }
        Write-Success "Jekyll build successful"

        # Check if _site directory was created
        if (-not (Test-Path "_site")) {
            throw "_site directory not created"
        }
        Write-Success "_site directory created"

        # Check for key files
        $keyFiles = @("_site/index.html", "_site/companies/index.html", "_site/Calc/GST/index.html")
        foreach ($file in $keyFiles) {
            if (-not (Test-Path $file)) {
                Write-Warning "Missing expected file: $file"
            } else {
                if ($Verbose) { Write-Success "Found: $file" }
            }
        }
    } else {
        if (-not $JekyllAvailable) {
            Write-Warning "Skipping Jekyll build test (Jekyll not available)"
        } else {
            Write-Warning "Skipping Jekyll build test (--SkipBuild specified)"
        }
    }

    # 5. Link Check (Markdown files)
    Write-Step "Step 5: Checking Markdown Links"
    $markdownFiles = Get-ChildItem -Recurse -Filter "*.md" | Where-Object {
        $_.FullName -notmatch "node_modules|vendor|_site"
    }

    if ($markdownFiles.Count -gt 0) {
        Write-Success "Found $($markdownFiles.Count) Markdown files to check"

        # Basic link validation (check for obvious issues)
        $linkIssues = 0
        foreach ($file in $markdownFiles) {
            $content = Get-Content $file.FullName -Raw
            # Check for broken internal links (basic check)
            if ($content -match '\]\(\/[^)]*\)') {
                $linkMatches = [regex]::Matches($content, '\]\((/[^)]*)\)')
                foreach ($match in $linkMatches) {
                    $link = $match.Groups[1].Value
                    if ($link -match '^/[^#]*$' -and -not $link.EndsWith('/')) {
                        $checkPath = "_site$link.html"
                        if (-not (Test-Path $checkPath)) {
                            $checkPath = "_site$link/index.html"
                            if (-not (Test-Path $checkPath)) {
                                Write-Warning "Potential broken link in $($file.Name): $link"
                                $linkIssues++
                            }
                        }
                    }
                }
            }
        }

        if ($linkIssues -eq 0) {
            Write-Success "No obvious link issues found"
        } else {
            Write-Warning "Found $linkIssues potential link issues"
        }
    } else {
        Write-Warning "No Markdown files found"
    }

    # 5.5 HTML Link Traversal Test
    if (-not $SkipLinkTraversal) {
        Write-Step "Step 5.5: HTML Link Traversal Test"
        Write-Host "Performing comprehensive link traversal on HTML files..."

        $htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse | Where-Object {
            $_.FullName -notmatch "node_modules|vendor|_site"
        }

        if ($htmlFiles.Count -gt 0) {
            Write-Success "Found $($htmlFiles.Count) HTML files to analyze"

            # Initialize tracking variables
            $totalLinks = 0
            $uniqueLinks = [System.Collections.Generic.HashSet[string]]::new()
            $brokenLinks = @()
            $jekyllGeneratedLinks = 0
            $staticAssetLinks = 0
            $externalLinks = 0
            $processedFiles = 0

            # Get repository root (where _config.yml is located)
            $repoRoot = Split-Path $PSScriptRoot -Parent

            # Define comprehensive patterns for links that are expected to be handled by Jekyll
            # Based on actual site structure and navigation.yml
            $jekyllPatterns = @(
                # Main pages
                '^/?$',  # Root
                '^/companies/?$',  # Companies index
                '^/Calc/?$',  # Calculators index

                # Top-level pages that exist as directories with index files
                '^/sitemap/?$',  # Sitemap page
                '^/terms/?$',  # Terms page
                '^/privacy/?$',  # Privacy page
                '^/contact/?$',  # Contact page
                '^/offline/?$',  # Offline page

                # Company main pages
                '^/companies/rk-electrodes/?$',
                '^/companies/rk-oxygen/?$',
                '^/companies/rk-palace/?$',
                '^/companies/sand-creations/?$',

                # Company policy pages (terms, refund-policy)
                '^/companies/[^/]+/terms/?$',
                '^/companies/[^/]+/refund-policy/?$',

                # RK Oxygen branches
                '^/companies/rk-oxygen/gorakhpur/?$',
                '^/companies/rk-oxygen/lucknow/?$',

                # RK Oxygen branch-specific pages
                '^/companies/rk-oxygen/[^/]+/terms/?$',
                '^/companies/rk-oxygen/[^/]+/refund-policy/?$',
                '^/companies/rk-oxygen/[^/]+/privacy/?$',
                '^/companies/rk-oxygen/[^/]+/contact/?$',
                '^/companies/rk-oxygen/[^/]+/shipping/?$',

                # Calculator pages
                '^/Calc/GST/?$',
                '^/Calc/EMI/?$',
                '^/Calc/LIQ/?$',
                '^/Calc/CI/?$',

                # Special pages (may not exist yet)
                '^/search/?$'
            )

            # Define patterns for static assets that should exist
            $staticAssetPatterns = @(
                '\.(css|js|ico|png|jpg|jpeg|gif|svg|woff|woff2|ttf|eot|json|xml|txt|pdf)$',
                '^/favicon\.ico$',
                '^/manifest\.json$',
                '^/robots\.txt$',
                '^/sitemap\.xml$',
                '^/feed\.xml$',
                '^/sw\.js$'
            )

            foreach ($file in $htmlFiles) {
                try {
                    $processedFiles++
                    $content = Get-Content $file.FullName -Raw -ErrorAction Stop
                    if (-not $content) {
                        if ($Verbose) { Write-Host "Skipping empty file: $($file.Name)" -ForegroundColor Gray }
                        continue
                    }

                    # Extract all href attributes from HTML files using more robust regex
                    try {
                        # Match href="..." and href='...' patterns
                        $linkMatches = [regex]::Matches($content, 'href=["'']([^"'']+)["'']')
                    }
                    catch {
                        if ($Verbose) { Write-Host "Regex error in $($file.Name): $($_.Exception.Message)" -ForegroundColor Gray }
                        continue
                    }

                    foreach ($match in $linkMatches) {
                        try {
                            if ($match.Groups.Count -lt 2) { continue }
                            $link = $match.Groups[1].Value
                            $totalLinks++

                            # Categorize links
                            if ($link -match '^https?://' -or $link -match '^//') {
                                $externalLinks++
                                continue  # Skip external links (including protocol-relative)
                            }
                            elseif ($link -match '^mailto:|^tel:|^javascript:') {
                                continue  # Skip non-HTTP protocols
                            }
                            elseif ($link -match '^#') {
                                continue  # Skip anchor-only links
                            }
                            elseif (-not ($link -match '^/')) {
                                continue  # Skip relative links that don't start with /
                            }

                            # Clean link for file existence check (remove anchors and query params)
                            $cleanLink = $link -replace '#.*$' -replace '\?.*$'

                            # Skip if we've already processed this unique link
                            if (-not $uniqueLinks.Add($cleanLink)) {
                                continue
                            }

                            # Check if this link matches Jekyll patterns (expected to be generated)
                            $isJekyllLink = $false
                            foreach ($pattern in $jekyllPatterns) {
                                if ($cleanLink -match $pattern) {
                                    $isJekyllLink = $true
                                    $jekyllGeneratedLinks++
                                    break
                                }
                            }

                            if ($isJekyllLink) {
                                if ($Verbose) { Write-Host "Jekyll link: $cleanLink" -ForegroundColor Cyan }
                                continue
                            }

                            # Check if this is a static asset
                            $isStaticAsset = $false
                            foreach ($pattern in $staticAssetPatterns) {
                                if ($cleanLink -match $pattern) {
                                    $isStaticAsset = $true
                                    $staticAssetLinks++
                                    break
                                }
                            }

                            if ($isStaticAsset) {
                                # Verify static asset exists
                                $assetPath = Join-Path $repoRoot ($cleanLink -replace '^/')
                                if (-not (Test-Path $assetPath)) {
                                    $brokenLinks += @{
                                        Link = $cleanLink
                                        SourceFile = $file.Name
                                        SourcePath = $file.FullName
                                        Type = "Missing Static Asset"
                                    }
                                } elseif ($Verbose) {
                                    Write-Host "Static asset OK: $cleanLink" -ForegroundColor Green
                                }
                                continue
                            }

                            # Skip template variables and dynamic content
                            if ($cleanLink -match '\{\{.*\}\}' -or $cleanLink -match '\{\%.*\%\}') {
                                continue
                            }

                            # For remaining links, check file existence
                            $relativePath = $cleanLink -replace '^/', '' -replace '/', '\'
                            $filePath = Join-Path $repoRoot $relativePath

                            if ($Verbose) {
                                Write-Host "Checking: $cleanLink -> $filePath" -ForegroundColor Gray
                            }

                            # Check multiple possible file locations
                            $exists = $false
                            $checkedPaths = @()

                            # 1. Check if it's a directory with index.html
                            $indexPath = Join-Path $filePath "index.html"
                            $checkedPaths += $indexPath
                            if (Test-Path $indexPath) {
                                $exists = $true
                            }

                            # 2. Check if it's a directory with index.md
                            if (-not $exists) {
                                $indexMdPath = Join-Path $filePath "index.md"
                                $checkedPaths += $indexMdPath
                                if (Test-Path $indexMdPath) {
                                    $exists = $true
                                }
                            }

                            # 3. Check if it's a direct HTML file
                            if (-not $exists) {
                                $htmlPath = "$filePath.html"
                                $checkedPaths += $htmlPath
                                if (Test-Path $htmlPath) {
                                    $exists = $true
                                }
                            }

                            # 4. Check if it's a direct Markdown file
                            if (-not $exists) {
                                $mdPath = "$filePath.md"
                                $checkedPaths += $mdPath
                                if (Test-Path $mdPath) {
                                    $exists = $true
                                }
                            }

                            if (-not $exists) {
                                if ($Verbose) {
                                    Write-Host "Not found at any of: $($checkedPaths -join ', ')" -ForegroundColor Gray
                                }
                                $brokenLinks += @{
                                    Link = $cleanLink
                                    SourceFile = $file.Name
                                    SourcePath = $file.FullName
                                    Type = "Missing Page/File"
                                    CheckedPaths = $checkedPaths
                                }
                            } elseif ($Verbose) {
                                Write-Host "Found: $cleanLink" -ForegroundColor Green
                            }

                        }
                        catch {
                            if ($Verbose) { Write-Host "Error processing link '$link' in $($file.Name): $($_.Exception.Message)" -ForegroundColor Gray }
                            continue
                        }
                    }
                }
                catch {
                    Write-Warning "Error processing $($file.Name): $($_.Exception.Message)"
                }
            }

            # Generate comprehensive report
            Write-Host "`n📊 Link Analysis Summary:" -ForegroundColor Cyan
            Write-Host "  Files processed: $processedFiles" -ForegroundColor White
            Write-Host "  Total links found: $totalLinks" -ForegroundColor White
            Write-Host "  Unique internal links: $($uniqueLinks.Count)" -ForegroundColor White
            Write-Host "  External links: $externalLinks" -ForegroundColor White
            Write-Host "  Jekyll-generated links: $jekyllGeneratedLinks" -ForegroundColor White
            Write-Host "  Static asset links: $staticAssetLinks" -ForegroundColor White

            if ($brokenLinks.Count -eq 0) {
                Write-Success "✅ All static internal links are valid! No broken links found."
            } else {
                Write-Error "❌ Found $($brokenLinks.Count) broken static internal links:"
                foreach ($brokenLink in $brokenLinks) {
                    Write-Host "  - $($brokenLink.Link) (in $($brokenLink.SourceFile)) - $($brokenLink.Type)" -ForegroundColor Red
                    if ($Verbose -and $brokenLink.ContainsKey('CheckedPaths')) {
                        Write-Host "    Checked: $($brokenLink.CheckedPaths -join ', ')" -ForegroundColor Gray
                    }
                }
                throw "HTML link traversal found $($brokenLinks.Count) broken static links"
            }
        } else {
            Write-Warning "No HTML files found for link traversal"
        }
    } else {
        Write-Warning "Skipping HTML link traversal test (--SkipLinkTraversal specified)"
    }

    # 6. Local Server & Lighthouse Test
    if ($NodeAvailable -and -not $SkipLighthouse) {
        Write-Step "Step 6: Testing with Lighthouse"        # Start local server in background
        Write-Host "Starting local server..."
        $serverJob = Start-Job -ScriptBlock {
            npx --yes http-server $args[0] -p 3000 -s
        } -ArgumentList (Resolve-Path "_site")

        Start-Sleep 5  # Wait for server to start

        try {
            # Test server is responding
            try {
                $response = Invoke-WebRequest -Uri "http://localhost:3000" -TimeoutSec 10
                if ($response.StatusCode -eq 200) {
                    Write-Success "Local server is responding"
                } else {
                    throw "Server returned status $($response.StatusCode)"
                }
            }
            catch {
                throw "Local server not responding: $($_.Exception.Message)"
            }

            # Run Lighthouse on key pages
            Write-Host "Running Lighthouse checks..."
            $lighthouseUrls = @(
                "http://localhost:3000/",
                "http://localhost:3000/companies/",
                "http://localhost:3000/companies/rk-oxygen/",
                "http://localhost:3000/companies/rk-oxygen/gorakhpur/",
                "http://localhost:3000/companies/rk-oxygen/lucknow/",
                "http://localhost:3000/companies/rk-electrodes/",
                "http://localhost:3000/companies/rk-palace/",
                "http://localhost:3000/companies/sand-creations/",
                "http://localhost:3000/companies/rk-oxygen/gorakhpur/contact/",
                "http://localhost:3000/companies/rk-oxygen/terms/",
                "http://localhost:3000/companies/rk-electrodes/terms/",
                "http://localhost:3000/companies/sand-creations/terms/",
                "http://localhost:3000/Calc/GST/",
                "http://localhost:3000/Calc/EMI/",
                "http://localhost:3000/Calc/LIQ/"
            )

            foreach ($url in $lighthouseUrls) {
                Write-Host "Testing: $url"
                npx --yes @lhci/cli collect --url=$url --numberOfRuns=1
                if ($LASTEXITCODE -ne 0) {
                    Write-Warning "Lighthouse warning for $url"
                } else {
                    Write-Success "Lighthouse passed for $url"
                }
            }

        }
        finally {
            # Stop the server
            if ($serverJob) {
                Stop-Job $serverJob -ErrorAction SilentlyContinue
                Remove-Job $serverJob -ErrorAction SilentlyContinue
            }
        }
    } else {
        if (-not $NodeAvailable) {
            Write-Warning "Skipping Lighthouse test (Node.js not available)"
        } else {
            Write-Warning "Skipping Lighthouse test (--SkipLighthouse specified)"
        }
    }

    # 7. Basic Accessibility Check
    if ($NodeAvailable -and -not $SkipAxe) {
        Write-Step "Step 7: Basic Accessibility Check"

        # Start server again for axe
        $serverJob = Start-Job -ScriptBlock {
            npx --yes http-server $args[0] -p 3001 -s
        } -ArgumentList (Resolve-Path "_site")

        Start-Sleep 3

        try {
            # Test a few key pages with axe-core
            $axeUrls = @(
                "http://localhost:3001/",
                "http://localhost:3001/companies/"
            )

            foreach ($url in $axeUrls) {
                Write-Host "Accessibility check: $url"
                npx --yes @axe-core/cli $url
                if ($LASTEXITCODE -eq 0) {
                    Write-Success "Accessibility check passed for $url"
                } else {
                    Write-Warning "Accessibility issues found for $url (non-blocking)"
                }
            }
        }
        finally {
            if ($serverJob) {
                Stop-Job $serverJob -ErrorAction SilentlyContinue
                Remove-Job $serverJob -ErrorAction SilentlyContinue
            }
        }
    } else {
        if (-not $NodeAvailable) {
            Write-Warning "Skipping accessibility test (Node.js not available)"
        } else {
            Write-Warning "Skipping accessibility test (--SkipAxe specified)"
        }
    }

    # 8. Validate GitHub Actions npm config commands
    Write-Step "Step 8: Validating GitHub Actions Configuration"

    # Check for invalid npm config commands in workflow files
    $workflowFiles = Get-ChildItem ".github/workflows/*.yml" -ErrorAction SilentlyContinue
    $npmConfigIssues = 0

    if ($workflowFiles) {
        foreach ($workflowFile in $workflowFiles) {
            $content = Get-Content $workflowFile.FullName -Raw

            # Check for npm config set commands
            $configMatches = [regex]::Matches($content, 'npm config set (\w+)')
            foreach ($match in $configMatches) {
                $configOption = $match.Groups[1].Value

                # Test if this is a valid npm config option
                $testResult = npm config get $configOption 2>&1
                if ($LASTEXITCODE -ne 0 -or $testResult -match "is not a valid npm option") {
                    Write-Warning "Invalid npm config option '$configOption' found in $($workflowFile.Name)"
                    $npmConfigIssues++
                }
            }
        }

        if ($npmConfigIssues -eq 0) {
            Write-Success "GitHub Actions npm config validation passed"
        } else {
            Write-Warning "Found $npmConfigIssues invalid npm config options in workflows"
        }
    }

    # 9. Pre-commit Checks
    Write-Step "Step 8: Running Pre-commit Checks"

    # Check for trailing whitespace
    $whitespaceIssues = 0
    Get-ChildItem -Recurse -File | Where-Object {
        $_.Extension -match '\.(md|yml|yaml|html|css|js)$' -and
        $_.FullName -notmatch 'node_modules|vendor|_site'
    } | ForEach-Object {
        $content = Get-Content $_.FullName -Raw
        if ($content -match ' +$') {
            Write-Warning "Trailing whitespace in: $($_.Name)"
            $whitespaceIssues++
        }
    }

    if ($whitespaceIssues -eq 0) {
        Write-Success "No trailing whitespace issues"
    } else {
        Write-Warning "Found $whitespaceIssues files with trailing whitespace"
    }

    # Final Status
    Write-Step "All Tests Complete!" "Green"
    Write-Success "✅ Local workflow tests passed!"
    Write-Host "`nYou can now safely push your changes:" -ForegroundColor Cyan
    Write-Host "git push" -ForegroundColor Yellow

}
catch {
    Write-Error "Test failed: $($_.Exception.Message)"
    Write-Host "`n💡 Fix the issues above before pushing." -ForegroundColor Yellow
    exit 1
}
finally {
    Set-Location $OriginalLocation
    # Clean up any background jobs
    Get-Job | Stop-Job -ErrorAction SilentlyContinue
    Get-Job | Remove-Job -ErrorAction SilentlyContinue
}

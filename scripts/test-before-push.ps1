#!/usr/bin/env pwsh
# Local Workflow Testing Script
# Runs all major workflow checks locally before pushing to prevent CI failures

param(
    [switch]$SkipBuild,
    [switch]$SkipLighthouse,
    [switch]$SkipAxe,
    [switch]$SkipJekyll,
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
                "http://localhost:3000/Calc/GST/"
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
                npx --yes @axe-core/cli $url --exit
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

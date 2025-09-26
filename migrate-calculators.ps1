#!/usr/bin/env pwsh

# RK Groups Calculator Submodule Migration Script
# This script helps migrate calculators to separate repositories and submodules

param(
    [switch]$ExtractCalculators,
    [switch]$CreateSubmodules,
    [switch]$UpdateWorkflows,
    [switch]$TestMigration,
    [switch]$Help
)

Write-Host "🔄 RK Groups Calculator Migration to Submodules" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

if ($Help) {
    Write-Host ""
    Write-Host "Migration Steps:" -ForegroundColor Yellow
    Write-Host "  1. Create separate GitHub repositories for each calculator"
    Write-Host "  2. Run: .\migrate-calculators.ps1 -ExtractCalculators"
    Write-Host "  3. Push each calculator to its repository"
    Write-Host "  4. Run: .\migrate-calculators.ps1 -CreateSubmodules"
    Write-Host "  5. Run: .\migrate-calculators.ps1 -UpdateWorkflows"
    Write-Host ""
    Write-Host "Commands:" -ForegroundColor Yellow
    Write-Host "  -ExtractCalculators : Extract calculators to separate directories"
    Write-Host "  -CreateSubmodules   : Convert directories to git submodules"
    Write-Host "  -UpdateWorkflows    : Update CI/CD and development workflows"
    Write-Host "  -TestMigration     : Test the migration setup"
    Write-Host "  -Help              : Show this help message"
    exit 0
}

function Write-Step {
    param([string]$Message)
    Write-Host "📋 $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

$calculators = @(
    @{
        Name = "GST"
        Path = "Calc/GST"
        RepoName = "calculator-gst"
        Description = "GST Calculator for tax calculations"
    },
    @{
        Name = "LIQ"
        Path = "Calc/LIQ"
        RepoName = "calculator-liquid"
        Description = "Liquid Calculator for gas conversions"
    },
    @{
        Name = "EMI"
        Path = "Calc/EMI"
        RepoName = "calculator-emi"
        Description = "EMI Calculator for loan calculations"
    },
    @{
        Name = "CI"
        Path = "Calc/CI"
        RepoName = "calculator-ci"
        Description = "CI Calculator for compound interest"
    }
)

if ($ExtractCalculators) {
    Write-Step "Extracting calculators to separate directories..."

    $tempDir = "temp-calculators"
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }
    New-Item -ItemType Directory -Path $tempDir | Out-Null

    foreach ($calc in $calculators) {
        Write-Step "Extracting $($calc.Name) calculator..."

        $sourcePath = $calc.Path
        $tempPath = Join-Path $tempDir $calc.RepoName

        if (Test-Path $sourcePath) {
            # Copy calculator files
            Copy-Item -Path $sourcePath -Destination $tempPath -Recurse

            # Create README for the calculator repo
            $readmePath = Join-Path $tempPath "README.md"
            $readmeContent = @"
# $($calc.Name) Calculator

$($calc.Description)

This calculator is part of the RK Groups website suite.

## Development

This calculator is developed as a submodule of the main RK Groups website.

## Files

- `index.html` - Interactive calculator interface
- `index.md` - Static calculator documentation

## Integration

This calculator is automatically included in the main website via git submodules.
"@

            Set-Content -Path $readmePath -Value $readmeContent

            # Create .gitignore for calculator repo
            $gitignorePath = Join-Path $tempPath ".gitignore"
            $gitignoreContent = @"
# Jekyll
_site/
.sass-cache/
.jekyll-cache/

# Dependencies
node_modules/

# Build outputs
*.min.js
*.min.css

# OS generated files
.DS_Store
Thumbs.db
"@

            Set-Content -Path $gitignorePath -Value $gitignoreContent

            Write-Success "$($calc.Name) calculator extracted to $tempPath"
        } else {
            Write-Warning "$($calc.Name) calculator not found at $sourcePath"
        }
    }

    Write-Success "All calculators extracted to $tempDir/"
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Create repositories on GitHub:" -ForegroundColor White
    foreach ($calc in $calculators) {
        Write-Host "   - https://github.com/rk-Groups/$($calc.RepoName)" -ForegroundColor Gray
    }
    Write-Host "2. Push each calculator to its repository" -ForegroundColor White
    Write-Host "3. Run: .\migrate-calculators.ps1 -CreateSubmodules" -ForegroundColor White
}

if ($CreateSubmodules) {
    Write-Step "Converting calculator directories to git submodules..."

    foreach ($calc in $calculators) {
        Write-Step "Setting up $($calc.Name) calculator submodule..."

        $calcPath = $calc.Path

        # Remove existing directory if it exists
        if (Test-Path $calcPath) {
            Write-Warning "Removing existing $($calc.Name) directory..."
            Remove-Item -Path $calcPath -Recurse -Force
        }

        # Ask for repository URL
        $repoUrl = Read-Host "Enter GitHub URL for $($calc.Name) calculator (e.g., https://github.com/rk-Groups/$($calc.RepoName).git)"

        if ($repoUrl) {
            try {
                # Add submodule
                git submodule add $repoUrl $calcPath

                # Initialize and update
                git submodule init $calcPath
                git submodule update $calcPath

                Write-Success "$($calc.Name) calculator submodule created!"
            }
            catch {
                Write-Error "Failed to create $($calc.Name) submodule: $_"
            }
        } else {
            Write-Warning "Skipped $($calc.Name) calculator - no URL provided"
        }
    }

    Write-Success "Submodule setup complete!"
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Commit the submodule changes: git add . && git commit -m 'Migrate calculators to submodules'" -ForegroundColor White
    Write-Host "2. Run: .\migrate-calculators.ps1 -UpdateWorkflows" -ForegroundColor White
}

if ($UpdateWorkflows) {
    Write-Step "Updating workflows for submodule support..."

    # Update package.json scripts
    Write-Step "Updating package.json..."
    $packageJsonPath = "package.json"
    if (Test-Path $packageJsonPath) {
        $packageJson = Get-Content $packageJsonPath -Raw | ConvertFrom-Json

        # Add submodule-related scripts
        $packageJson.scripts | Add-Member -MemberType NoteProperty -Name "submodules:init" -Value "git submodule init && git submodule update" -Force
        $packageJson.scripts | Add-Member -MemberType NoteProperty -Name "submodules:update" -Value "git submodule update --remote" -Force
        $packageJson.scripts | Add-Member -MemberType NoteProperty -Name "submodules:status" -Value "git submodule status" -Force

        $packageJson | ConvertTo-Json -Depth 10 | Set-Content $packageJsonPath
        Write-Success "package.json updated with submodule scripts"
    }

    # Update GitHub Actions workflow
    Write-Step "Updating GitHub Actions workflow..."
    $workflowPath = ".github/workflows/jekyll.yml"
    if (Test-Path $workflowPath) {
        $workflowContent = Get-Content $workflowPath -Raw

        # Add submodule checkout
        if ($workflowContent -notmatch "submodules:") {
            $workflowContent = $workflowContent -replace "uses: actions/checkout@v3", "uses: actions/checkout@v3`n        with:`n          submodules: recursive"

            Set-Content -Path $workflowPath -Value $workflowContent
            Write-Success "GitHub Actions workflow updated for submodules"
        } else {
            Write-Warning "GitHub Actions workflow already has submodule support"
        }
    }

    # Update README
    Write-Step "Updating README with submodule information..."
    $readmePath = "README.md"
    if (Test-Path $readmePath) {
        $readmeContent = Get-Content $readmePath -Raw

        $submoduleSection = @"

## 🧮 Calculator Submodules

This project uses git submodules for calculator components:

- **GST Calculator**: `Calc/GST/` - Tax calculations
- **Liquid Calculator**: `Calc/LIQ/` - Gas conversion calculations
- **EMI Calculator**: `Calc/EMI/` - Loan calculations
- **CI Calculator**: `Calc/CI/` - Compound interest calculations

### Working with Submodules

```bash
# Initialize submodules (first time)
npm run submodules:init

# Update submodules to latest
npm run submodules:update

# Check submodule status
npm run submodules:status

# Update specific calculator
cd Calc/GST && git pull origin main
```

### Managing Calculators

Use the calculator management script:

```bash
# Add new calculator submodule
.\manage-calculators.ps1 -AddGST

# Update all calculators
.\manage-calculators.ps1 -Update
```
"@

        if ($readmeContent -notmatch "Calculator Submodules") {
            $readmeContent += $submoduleSection
            Set-Content -Path $readmePath -Value $readmeContent
            Write-Success "README updated with submodule documentation"
        }
    }

    Write-Success "Workflows updated for submodule support!"
}

if ($TestMigration) {
    Write-Step "Testing submodule migration..."

    # Check if submodules are properly set up
    $submoduleStatus = git submodule status 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Git submodules are properly configured"

        # Check each calculator
        foreach ($calc in $calculators) {
            $calcPath = $calc.Path
            if (Test-Path $calcPath) {
                Write-Success "$($calc.Name) calculator submodule exists at $calcPath"
            } else {
                Write-Error "$($calc.Name) calculator submodule missing at $calcPath"
            }
        }
    } else {
        Write-Error "Git submodules not properly configured"
    }

    # Check if workflow files are updated
    if (Test-Path "package.json") {
        $packageJson = Get-Content "package.json" -Raw | ConvertFrom-Json
        if ($packageJson.scripts."submodules:init") {
            Write-Success "package.json has submodule scripts"
        } else {
            Write-Warning "package.json missing submodule scripts"
        }
    }

    Write-Success "Migration test complete!"
}

# Default action if no parameters provided
if (-not ($ExtractCalculators -or $CreateSubmodules -or $UpdateWorkflows -or $TestMigration -or $Help)) {
    Write-Host ""
    Write-Host "No command specified. Use -Help to see migration steps." -ForegroundColor Yellow
    Write-Host ""
    & $PSCommandPath -Help
}
#!/usr/bin/env pwsh

# RK Groups Calculator Submodule Management Script
# This script helps manage calculator submodules for the main website

param(
    [switch]$Init,
    [switch]$Update,
    [switch]$AddGST,
    [switch]$AddLIQ,
    [switch]$AddEMI,
    [switch]$AddCI,
    [switch]$Status,
    [switch]$Help
)

Write-Host "🧮 RK Groups Calculator Submodules" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

if ($Help) {
    Write-Host ""
    Write-Host "Available commands:" -ForegroundColor Yellow
    Write-Host "  -Init      : Initialize all submodules"
    Write-Host "  -Update    : Update all submodules to latest"
    Write-Host "  -AddGST    : Add GST calculator submodule"
    Write-Host "  -AddLIQ    : Add Liquid calculator submodule"
    Write-Host "  -AddEMI    : Add EMI calculator submodule"
    Write-Host "  -AddCI     : Add CI calculator submodule"
    Write-Host "  -Status    : Show submodule status"
    Write-Host "  -Help      : Show this help message"
    Write-Host ""
    Write-Host "Example workflow:" -ForegroundColor Green
    Write-Host "  1. Create separate repos for each calculator"
    Write-Host "  2. .\manage-calculators.ps1 -AddGST"
    Write-Host "  3. .\manage-calculators.ps1 -Init"
    Write-Host "  4. .\manage-calculators.ps1 -Update"
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

function Add-CalculatorSubmodule {
    param(
        [string]$Name,
        [string]$Path,
        [string]$Url
    )

    Write-Step "Adding $Name calculator submodule..."

    if (Test-Path $Path) {
        Write-Host "⚠️  Directory $Path exists. Removing..." -ForegroundColor Yellow
        Remove-Item -Path $Path -Recurse -Force
    }

    try {
        git submodule add $Url $Path
        Write-Success "$Name calculator submodule added successfully!"
    }
    catch {
        Write-Error "Failed to add $Name calculator submodule: $_"
    }
}

if ($AddGST) {
    $gstUrl = Read-Host "Enter GST calculator repository URL (e.g., https://github.com/rk-Groups/calculator-gst.git)"
    if ($gstUrl) {
        Add-CalculatorSubmodule -Name "GST" -Path "Calc/GST" -Url $gstUrl
    } else {
        Write-Error "No URL provided for GST calculator"
    }
}

if ($AddLIQ) {
    $liqUrl = Read-Host "Enter Liquid calculator repository URL"
    if ($liqUrl) {
        Add-CalculatorSubmodule -Name "Liquid" -Path "Calc/LIQ" -Url $liqUrl
    } else {
        Write-Error "No URL provided for Liquid calculator"
    }
}

if ($AddEMI) {
    $emiUrl = Read-Host "Enter EMI calculator repository URL"
    if ($emiUrl) {
        Add-CalculatorSubmodule -Name "EMI" -Path "Calc/EMI" -Url $emiUrl
    } else {
        Write-Error "No URL provided for EMI calculator"
    }
}

if ($AddCI) {
    $ciUrl = Read-Host "Enter CI calculator repository URL"
    if ($ciUrl) {
        Add-CalculatorSubmodule -Name "CI" -Path "Calc/CI" -Url $ciUrl
    } else {
        Write-Error "No URL provided for CI calculator"
    }
}

if ($Init) {
    Write-Step "Initializing all calculator submodules..."
    git submodule init
    git submodule update
    Write-Success "All calculator submodules initialized!"
}

if ($Update) {
    Write-Step "Updating all calculator submodules..."
    git submodule update --remote
    Write-Success "All calculator submodules updated!"
}

if ($Status) {
    Write-Step "Checking calculator submodule status..."
    git submodule status
}

# Default action if no parameters provided
if (-not ($Init -or $Update -or $AddGST -or $AddLIQ -or $AddEMI -or $AddCI -or $Status -or $Help)) {
    Write-Host ""
    Write-Host "No command specified. Use -Help to see available commands." -ForegroundColor Yellow
    Write-Host ""
    & $PSCommandPath -Help
}
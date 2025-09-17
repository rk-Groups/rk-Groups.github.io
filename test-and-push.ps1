#!/usr/bin/env pwsh
# Quick pre-push validation wrapper
# Usage: ./test-and-push.ps1 [commit-message]

param(
    [string]$CommitMessage = "",
    [switch]$Force,
    [switch]$QuickTest
)

$ErrorActionPreference = "Stop"

if (-not $CommitMessage -and -not $Force) {
    Write-Host "Usage: ./test-and-push.ps1 'Your commit message'" -ForegroundColor Yellow
    Write-Host "   or: ./test-and-push.ps1 -Force (to test and push without new commit)" -ForegroundColor Yellow
    exit 1
}

try {
    # Run the comprehensive tests
    Write-Host "🧪 Running pre-push tests..." -ForegroundColor Cyan

    if ($QuickTest) {
        & ".\scripts\test-before-push.ps1" -SkipLighthouse -SkipAxe
    } else {
        & ".\scripts\test-before-push.ps1"
    }

    if ($LASTEXITCODE -ne 0) {
        throw "Tests failed"
    }

    # If tests pass and we have a commit message, commit and push
    if ($CommitMessage) {
        Write-Host "`n📝 Committing changes..." -ForegroundColor Cyan
        git add .
        git commit -m $CommitMessage

        if ($LASTEXITCODE -ne 0) {
            throw "Commit failed"
        }
    }

    # Push the changes
    Write-Host "`n🚀 Pushing to remote..." -ForegroundColor Cyan
    git push

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✅ Successfully pushed changes!" -ForegroundColor Green
        Write-Host "🌐 Changes will be live shortly at GitHub Pages" -ForegroundColor Cyan
    } else {
        throw "Push failed"
    }

} catch {
    Write-Host "`n❌ $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "💡 Fix the issues and try again" -ForegroundColor Yellow
    exit 1
}

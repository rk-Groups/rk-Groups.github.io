param(
    [Parameter(Mandatory = $true)]
    [string]$Action,

    [Parameter(Mandatory = $false)]
    [string]$Workflow = "",

    [Parameter(Mandatory = $false)]
    [string]$Branch = "main",

    [switch]$DryRun
)

<#
.SYNOPSIS
    Advanced workflow management script for RK Groups Jekyll site

.DESCRIPTION
    This script provides comprehensive workflow management including:
    - Running specific workflows
    - Checking workflow status
    - Managing workflow artifacts
    - Docker build and deployment helpers

.PARAMETER Action
    The action to perform:
    - run: Run a specific workflow
    - status: Check workflow run status
    - artifacts: Download latest artifacts
    - docker-build: Build Docker images locally
    - docker-push: Push Docker images to registry
    - security-scan: Run security scanning locally
    - performance-test: Run performance tests locally

.PARAMETER Workflow
    The workflow name to target (for run/status actions)

.PARAMETER Branch
    The branch to target (default: main)

.PARAMETER DryRun
    Show what would be done without executing

.EXAMPLE
    .\manage-workflows.ps1 -Action run -Workflow slsa-provenance

.EXAMPLE
    .\manage-workflows.ps1 -Action status -Workflow jekyll-docker

.EXAMPLE
    .\manage-workflows.ps1 -Action docker-build -DryRun
#>

$ErrorActionPreference = "Stop"

# Configuration
$RepoOwner = "rk-Groups"
$RepoName = "rk-Groups.github.io"
$BaseUrl = "https://api.github.com/repos/$RepoOwner/$RepoName"

# Available workflows
$Workflows = @{
    "slsa-provenance" = "slsa-provenance.yml"
    "jekyll-docker" = "jekyll-docker.yml"
    "security-scan" = "security-scan.yml"
    "performance-monitoring" = "performance-monitoring.yml"
    "ci-cd" = "ci-cd.yml"
    "gh-pages" = "gh-pages.yml"
}

function Write-Header {
    param([string]$Message)
    Write-Host "`n🔧 $Message" -ForegroundColor Cyan
    Write-Host ("=" * ($Message.Length + 3)) -ForegroundColor Cyan
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

function Get-GitHubToken {
    $token = $env:GITHUB_TOKEN
    if (-not $token) {
        $token = Read-Host "Enter GitHub Personal Access Token"
    }
    return $token
}

function Invoke-GitHubApi {
    param(
        [string]$Url,
        [string]$Method = "GET",
        [object]$Body = $null
    )

    $token = Get-GitHubToken
    $headers = @{
        "Authorization" = "Bearer $token"
        "Accept" = "application/vnd.github.v3+json"
        "User-Agent" = "RK-Groups-Workflow-Manager"
    }

    $params = @{
        Uri = $Url
        Method = $Method
        Headers = $headers
    }

    if ($Body) {
        $params.Body = $Body | ConvertTo-Json
        $params.ContentType = "application/json"
    }

    try {
        $response = Invoke-RestMethod @params
        return $response
    }
    catch {
        Write-Error "GitHub API call failed: $($_.Exception.Message)"
        exit 1
    }
}

function Run-Workflow {
    param([string]$WorkflowName)

    if (-not $Workflows.ContainsKey($WorkflowName)) {
        Write-Error "Unknown workflow: $WorkflowName"
        Write-Host "Available workflows:" -ForegroundColor Yellow
        $Workflows.Keys | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
        exit 1
    }

    Write-Header "Running workflow: $WorkflowName"

    if ($DryRun) {
        Write-Host "Would run workflow: $($Workflows[$WorkflowName])" -ForegroundColor Yellow
        return
    }

    $url = "$BaseUrl/actions/workflows/$($Workflows[$WorkflowName])/dispatches"

    $body = @{
        ref = $Branch
    }

    try {
        Invoke-GitHubApi -Url $url -Method "POST" -Body $body
        Write-Success "Workflow '$WorkflowName' triggered successfully"
        Write-Host "Check GitHub Actions tab for progress..." -ForegroundColor Cyan
    }
    catch {
        Write-Error "Failed to trigger workflow: $($_.Exception.Message)"
    }
}

function Get-WorkflowStatus {
    param([string]$WorkflowName)

    if ($WorkflowName -and -not $Workflows.ContainsKey($WorkflowName)) {
        Write-Error "Unknown workflow: $WorkflowName"
        exit 1
    }

    Write-Header "Checking workflow status"

    $url = if ($WorkflowName) {
        "$BaseUrl/actions/workflows/$($Workflows[$WorkflowName])/runs?per_page=5"
    } else {
        "$BaseUrl/actions/runs?per_page=10"
    }

    try {
        $runs = Invoke-GitHubApi -Url $url

        foreach ($run in $runs.workflow_runs) {
            $status = $run.status
            $conclusion = $run.conclusion
            $workflowName = $run.name
            $created = [DateTime]::Parse($run.created_at).ToLocalTime()
            $updated = [DateTime]::Parse($run.updated_at).ToLocalTime()

            Write-Host "Workflow: $workflowName" -ForegroundColor White
            Write-Host "  Status: $status" -ForegroundColor $(if ($status -eq "completed") { "Green" } elseif ($status -eq "in_progress") { "Yellow" } else { "Red" })
            Write-Host "  Conclusion: $conclusion" -ForegroundColor $(if ($conclusion -eq "success") { "Green" } elseif ($conclusion -eq "failure") { "Red" } else { "Yellow" })
            Write-Host "  Created: $($created.ToString('g'))" -ForegroundColor Gray
            Write-Host "  Updated: $($updated.ToString('g'))" -ForegroundColor Gray
            Write-Host "  URL: $($run.html_url)" -ForegroundColor Blue
            Write-Host ""
        }
    }
    catch {
        Write-Error "Failed to get workflow status: $($_.Exception.Message)"
    }
}

function Get-Artifacts {
    Write-Header "Downloading latest artifacts"

    if ($DryRun) {
        Write-Host "Would download latest workflow artifacts" -ForegroundColor Yellow
        return
    }

    $url = "$BaseUrl/actions/artifacts?per_page=10"

    try {
        $artifacts = Invoke-GitHubApi -Url $url

        if ($artifacts.artifacts.Count -eq 0) {
            Write-Warning "No artifacts found"
            return
        }

        $artifactsDir = "workflow-artifacts"
        if (-not (Test-Path $artifactsDir)) {
            New-Item -ItemType Directory -Path $artifactsDir | Out-Null
        }

        foreach ($artifact in $artifacts.artifacts | Select-Object -First 5) {
            $downloadUrl = $artifact.archive_download_url
            $fileName = "$artifactsDir/$($artifact.name).zip"

            Write-Host "Downloading: $($artifact.name)" -ForegroundColor Cyan

            $token = Get-GitHubToken
            $headers = @{
                "Authorization" = "Bearer $token"
                "User-Agent" = "RK-Groups-Workflow-Manager"
            }

            Invoke-WebRequest -Uri $downloadUrl -Headers $headers -OutFile $fileName
            Write-Success "Downloaded: $fileName"
        }

        Write-Success "All artifacts downloaded to: $artifactsDir"
    }
    catch {
        Write-Error "Failed to download artifacts: $($_.Exception.Message)"
    }
}

function Invoke-DockerBuild {
    Write-Header "Building Docker images"

    if ($DryRun) {
        Write-Host "Would build Docker images:" -ForegroundColor Yellow
        Write-Host "  - Dockerfile.jekyll (production)" -ForegroundColor Yellow
        Write-Host "  - Dockerfile.builder (development)" -ForegroundColor Yellow
        return
    }

    # Check if Docker is available
    if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
        Write-Error "Docker is not installed or not in PATH"
        exit 1
    }

    $images = @(
        @{Name = "rk-groups:latest"; Dockerfile = "Dockerfile.jekyll"; Description = "Production image"},
        @{Name = "rk-groups:dev"; Dockerfile = "Dockerfile.builder"; Description = "Development image"}
    )

    foreach ($image in $images) {
        Write-Host "Building $($image.Description): $($image.Name)" -ForegroundColor Cyan

        $buildArgs = @(
            "build",
            "-f", $image.Dockerfile,
            "-t", $image.Name,
            "."
        )

        & docker $buildArgs

        if ($LASTEXITCODE -eq 0) {
            Write-Success "Built: $($image.Name)"
        } else {
            Write-Error "Failed to build: $($image.Name)"
            exit 1
        }
    }

    Write-Success "All Docker images built successfully"
}

function Invoke-DockerPush {
    Write-Header "Pushing Docker images to registry"

    if ($DryRun) {
        Write-Host "Would push images to GitHub Container Registry" -ForegroundColor Yellow
        return
    }

    # Check if logged in to GHCR
    $loginCheck = & docker login ghcr.io --get-login 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Not logged in to GitHub Container Registry"
        Write-Host "Run: docker login ghcr.io" -ForegroundColor Yellow
        exit 1
    }

    $registry = "ghcr.io/$RepoOwner/rk-groups"
    $tags = @("latest", "dev")

    foreach ($tag in $tags) {
        $imageName = "$registry`:$tag"
        Write-Host "Pushing: $imageName" -ForegroundColor Cyan

        & docker tag "rk-groups:$tag" $imageName
        & docker push $imageName

        if ($LASTEXITCODE -eq 0) {
            Write-Success "Pushed: $imageName"
        } else {
            Write-Error "Failed to push: $imageName"
            exit 1
        }
    }

    Write-Success "All images pushed successfully"
}

function Invoke-SecurityScan {
    Write-Header "Running local security scan"

    if ($DryRun) {
        Write-Host "Would run security scans:" -ForegroundColor Yellow
        Write-Host "  - Trivy filesystem scan" -ForegroundColor Yellow
        Write-Host "  - NPM audit" -ForegroundColor Yellow
        Write-Host "  - Bundle audit" -ForegroundColor Yellow
        return
    }

    # Check for required tools
    $tools = @("trivy", "npm", "bundle")
    foreach ($tool in $tools) {
        if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
            Write-Warning "$tool not found, skipping related checks"
        }
    }

    # Run Trivy if available
    if (Get-Command trivy -ErrorAction SilentlyContinue) {
        Write-Host "Running Trivy filesystem scan..." -ForegroundColor Cyan
        & trivy fs --format table --exit-code 0 .
        Write-Success "Trivy scan completed"
    }

    # Run NPM audit if available
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        Write-Host "Running NPM audit..." -ForegroundColor Cyan
        & npm audit --audit-level moderate
        Write-Success "NPM audit completed"
    }

    # Run Bundle audit if available
    if (Get-Command bundle -ErrorAction SilentlyContinue) {
        Write-Host "Running Bundle audit..." -ForegroundColor Cyan
        & bundle audit check
        Write-Success "Bundle audit completed"
    }

    Write-Success "Security scan completed"
}

function Invoke-PerformanceTest {
    Write-Header "Running performance tests"

    if ($DryRun) {
        Write-Host "Would run performance tests:" -ForegroundColor Yellow
        Write-Host "  - Lighthouse audit" -ForegroundColor Yellow
        Write-Host "  - Site availability check" -ForegroundColor Yellow
        return
    }

    $siteUrl = "https://rk-groups.github.io"

    # Check site availability
    Write-Host "Checking site availability..." -ForegroundColor Cyan
    try {
        $response = Invoke-WebRequest -Uri $siteUrl -TimeoutSec 10 -ErrorAction Stop
        Write-Success "Site is reachable (Status: $($response.StatusCode))"
    }
    catch {
        Write-Error "Site is not reachable: $($_.Exception.Message)"
        exit 1
    }

    # Run Lighthouse if available
    if (Get-Command lighthouse -ErrorAction SilentlyContinue) {
        Write-Host "Running Lighthouse audit..." -ForegroundColor Cyan
        & lighthouse $siteUrl --output json --output-path lighthouse-results.json --chrome-flags="--headless --disable-gpu --no-sandbox"
        Write-Success "Lighthouse audit completed"
    } else {
        Write-Warning "Lighthouse not installed. Install with: npm install -g lighthouse"
    }

    Write-Success "Performance tests completed"
}

# Main execution logic
switch ($Action.ToLower()) {
    "run" {
        if (-not $Workflow) {
            Write-Error "Workflow parameter is required for 'run' action"
            exit 1
        }
        Run-Workflow -WorkflowName $Workflow
    }
    "status" {
        Get-WorkflowStatus -WorkflowName $Workflow
    }
    "artifacts" {
        Get-Artifacts
    }
    "docker-build" {
        Invoke-DockerBuild
    }
    "docker-push" {
        Invoke-DockerPush
    }
    "security-scan" {
        Invoke-SecurityScan
    }
    "performance-test" {
        Invoke-PerformanceTest
    }
    default {
        Write-Error "Unknown action: $Action"
        Write-Host "Available actions:" -ForegroundColor Yellow
        Write-Host "  run <workflow>     - Run a specific workflow" -ForegroundColor Yellow
        Write-Host "  status [workflow]  - Check workflow status" -ForegroundColor Yellow
        Write-Host "  artifacts          - Download latest artifacts" -ForegroundColor Yellow
        Write-Host "  docker-build       - Build Docker images locally" -ForegroundColor Yellow
        Write-Host "  docker-push        - Push Docker images to registry" -ForegroundColor Yellow
        Write-Host "  security-scan      - Run security scanning locally" -ForegroundColor Yellow
        Write-Host "  performance-test   - Run performance tests locally" -ForegroundColor Yellow
        exit 1
    }
}
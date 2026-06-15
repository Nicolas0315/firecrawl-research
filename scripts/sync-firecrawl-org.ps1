param(
  [string]$Org = "firecrawl",
  [string]$MirrorRoot = (Join-Path (Resolve-Path (Join-Path $PSScriptRoot "..")).Path "mirrors/github-firecrawl"),
  [int]$Limit = 200,
  [switch]$CoreOnly,
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$core = @(
  "firecrawl",
  "cli",
  "firecrawl-docs",
  "firecrawl-mcp-server",
  "firecrawl-codex-plugin",
  "firecrawl-claude-plugin",
  "firecrawl-cursor-plugin",
  "firecrawl-grok-plugin",
  "firecrawl-workflows",
  "pdf-inspector",
  "html-extractor",
  "html-to-markdown",
  "firecrawl-py",
  "firecrawl-go",
  "firecrawl-java-sdk",
  "firecrawl-php",
  "n8n-nodes-firecrawl",
  "web-agent",
  "open-scouts"
)

$gate = "~\work\docs\scripts\agent-clone-gate.py"
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw "gh CLI is required" }
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "git is required" }
if (-not (Test-Path -LiteralPath $gate)) { throw "clone gate missing: $gate" }

New-Item -ItemType Directory -Force -Path $MirrorRoot | Out-Null

$repos = gh repo list $Org --limit $Limit --json name,url,isArchived | ConvertFrom-Json
$repos = $repos | Where-Object { -not $_.isArchived }
if ($CoreOnly) {
  $repos = $repos | Where-Object { $core -contains $_.name }
}

foreach ($repo in $repos) {
  $target = Join-Path $MirrorRoot $repo.name
  Write-Host "==> $($repo.name)"
  $gateOutput = python $gate --url $repo.url --name $repo.name --target $target --search-root (Resolve-Path (Join-Path $PSScriptRoot "..")).Path --min-score 80 --json
  $gateJson = $gateOutput | ConvertFrom-Json
  $targetGitExists = Test-Path -LiteralPath (Join-Path $target ".git")
  if ($gateJson.decision -eq "REVIEW_LOCAL_CANDIDATES_BEFORE_CLONE") {
    $candidatePaths = @($gateJson.candidates | ForEach-Object { $_.path })
    $onlyTargetCandidate = $targetGitExists -and $candidatePaths.Count -gt 0 -and (@($candidatePaths | Where-Object { $_ -ne $target }).Count -eq 0)
    if (-not $onlyTargetCandidate) {
      Write-Warning "Skipping $($repo.name): local candidates require review"
      continue
    }
  }

  if ($DryRun) {
    Write-Host "dry-run target: $target"
    continue
  }

  if ($targetGitExists) {
    git -C $target pull --ff-only
  } elseif (Test-Path -LiteralPath $target) {
    Write-Warning "Skipping $($repo.name): target exists but is not a git repo: $target"
  } else {
    git clone --depth 1 $repo.url $target
  }
}

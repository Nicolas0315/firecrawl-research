param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$required = @(
  "README.md",
  "AGENTS.md",
  "docs/re-scope.md",
  "docs/architecture-initial.md",
  "docs/repo-inventory.md",
  "docs/core-mirror-status.md",
  "docs/full-mirror-status.md",
  "scripts/sync-firecrawl-org.ps1",
  ".github/workflows/ci.yml",
  ".github/workflows/mirror-inventory.yml"
)

foreach ($path in $required) {
  $full = Join-Path $Root $path
  if (-not (Test-Path -LiteralPath $full)) {
    throw "Missing required file: $path"
  }
}

$scanRoots = @("README.md", "AGENTS.md", "docs", "scripts", ".github")
$patterns = @(
  "fc-[A-Za-z0-9_-]{20,}",
  "sk-[A-Za-z0-9_-]{20,}",
  "ghp_[A-Za-z0-9_]{20,}",
  "op://[^\\s]+/[^\\s]+/[^\\s]+"
)

$hits = @()
foreach ($scanRoot in $scanRoots) {
  $fullRoot = Join-Path $Root $scanRoot
  if (-not (Test-Path -LiteralPath $fullRoot)) { continue }
  $files = if ((Get-Item -LiteralPath $fullRoot).PSIsContainer) {
    Get-ChildItem -LiteralPath $fullRoot -Recurse -File
  } else {
    Get-Item -LiteralPath $fullRoot
  }
  foreach ($file in $files) {
    $text = Get-Content -Raw -LiteralPath $file.FullName
    foreach ($pattern in $patterns) {
      if ($text -match $pattern) {
        $hits += "$($file.FullName): pattern $pattern"
      }
    }
  }
}

if ($hits.Count -gt 0) {
  $hits | ForEach-Object { Write-Error $_ }
  throw "Potential secret reference found."
}

Write-Host "research validation ok"

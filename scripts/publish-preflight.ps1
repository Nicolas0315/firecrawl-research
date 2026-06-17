param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"
Push-Location $Root

try {
  pwsh -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root "scripts/validate-research.ps1")

  if (Get-Command gitleaks -ErrorAction SilentlyContinue) {
    gitleaks detect --source .
    if ($LASTEXITCODE -ne 0) { throw "gitleaks failed" }
  }

  $patterns = @(
    '~',
    '/Users/s30519',
    '100\.\d+\.\d+\.\d+',
    'sk-[A-Za-z0-9_-]{20,}',
    'ghp_[A-Za-z0-9_]{20,}'
  )

  $files = git ls-files
  foreach ($pattern in $patterns) {
    $hits = $files | ForEach-Object {
      if (Test-Path -LiteralPath $_) {
        Select-String -Path $_ -Pattern $pattern -ErrorAction SilentlyContinue
      }
    }
    if ($hits) {
      $hits | ForEach-Object { Write-Error "$($_.Path):$($_.LineNumber):$($_.Line.Trim())" }
      throw "tracked leak pattern matched: $pattern"
    }
  }

  if (git ls-files mirrors/) {
    throw "mirrors/ must stay untracked"
  }

  Write-Host "publish preflight ok"
}
finally {
  Pop-Location
}

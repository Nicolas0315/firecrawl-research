# Full Public Mirror Status

date: 2026-06-15
command: `pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/sync-firecrawl-org.ps1`
mirror root: `mirrors/github-firecrawl`

Result:
- Firecrawl GitHub org non-archived public repo count from `gh repo list firecrawl --limit 200 --json name,isArchived`: `98`
- Local mirror directory count under `mirrors/github-firecrawl`: `98`
- Clone mode: shallow clone via `git clone --depth 1`
- Existing mirror update mode: `git pull --ff-only`

Notes:
- `mirrors/` is intentionally ignored by git.
- This mirror is public-source evidence only. It does not include private hosted Firecrawl SaaS infrastructure, secrets, customer data, managed proxy configuration, or production account state.
- Use `scripts/sync-firecrawl-org.ps1 -CoreOnly` for fast refresh of the core set, and run the full script when public-org completeness is required.

# Firecrawl Research Repo Instructions

Global baseline: follow `~\AGENTS.md`.

Repo-specific rules:
- Scope is public-source research, architecture recovery, reproducibility notes, and defensive review.
- Do not attempt credential discovery, SaaS tenant access, production endpoint probing, or authentication bypass.
- Keep cloned upstream repositories under `mirrors/github-firecrawl/`; keep analysis under `docs/`.
- Do not commit generated clone contents unless explicitly asked. Treat `mirrors/` as disposable local evidence.
- Record command evidence with date, source path, commit SHA, and verification command.
- Use shallow clones by default. Run `~\work\docs\scripts\agent-clone-gate.py` before any new external clone or fetch.
- Secrets must be referenced only by 1Password item names or environment variable names, never by value.

Validation:
- Run `pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/validate-research.ps1`.
- For mirror refresh, run `pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/sync-firecrawl-org.ps1 -CoreOnly` first, then all repos only when needed.

# SearXNG Mirror Status

date: 2026-06-15
repo: `searxng/searxng`
local path: `mirrors/github-searxng/searxng`
commit read: `cf1410a`

Status:
- Local-first clone gate result: `NO_LOCAL_CANDIDATES_FOUND`.
- Shallow clone fetched Git objects, but Windows checkout failed on paths containing `:socket`.
- The mirror is still usable for source review through `git show HEAD:<path>` and `git grep`.
- `mirrors/` remains ignored and is not a tracked source-of-truth artifact.

Source paths reviewed:
- `searx/webadapter.py`
- `searx/results.py`
- `searx/search/__init__.py`
- `searx/search/models.py`
- `searx/search/processors/abstract.py`
- `searx/search/processors/online.py`
- `searx/engines/openalex.py`
- `searx/engines/github.py`
- `searx/engines/github_code.py`
- `searx/engines/braveapi.py`
- `searx/engines/brave.py`
- `docs/dev/search_api.rst`

Katala follow-through:
- Added local validation for SearXNG `time_range` and `safesearch` environment values in `katala-web-research`.
- Aligned Katala OpenAlex with SearXNG's public-API behavior: API key optional, `mailto` optional, language filter supported. Added official OpenAlex exact publication-year filtering as `OPENALEX_YEAR`.
- Aligned Katala GitHub repository results with SearXNG's package-style metadata: language, topics, license, homepage, and clone URL are retained when available.
- Added Katala `github_code` provider from SearXNG's GitHub code engine shape: text-match metadata is requested, repo/path/fragment metadata is retained, paging is supported, and invalid syntax HTTP 422 returns empty results.
- Aligned Katala Brave with official API localization, freshness, safesearch, and paging controls while keeping the official API path instead of HTML scraping.
- Preserved HTTP API boundary; no SearXNG source was copied or vendored.

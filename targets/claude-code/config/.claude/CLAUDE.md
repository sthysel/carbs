# Global Preferences

## Python Projects

- Use `uv` for package management, never pip
- Use `pre-commit` for linting and formatting hooks
- Use `ty` for type checking (no official pre-commit hook yet — use a local hook with `uv run ty check .`)
- Use `ruff` for linting and formatting
- Use `pytest` for testing
- Use bump-my-version for version management
- Type hints on all public functions
- Common commands:
  - `uv sync` — install dependencies
  - `uv run pytest` — run tests
  - `uv run pre-commit run --all-files` — lint and format
  - `uv run ty check` — type check
- Use `direnv` with `.envrc` (`source .venv/bin/activate`) to auto-load the venv
- New projects: initialize with `uv init`, add pre-commit config, add ty and ruff to dev dependencies, add `.envrc`

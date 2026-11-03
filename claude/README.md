# Claude Code

Global configuration for [Claude Code](https://claude.ai/code).

## What this topic does

- Installs Claude Code via the native installer (`install.sh`)
- Symlinks every file in `config/` → `~/.claude/` (currently `settings.json`,
  `CLAUDE.md` and `statusline-account.sh`)
- Sets up a separate [Permanent profile](#permanent-profile) for repositories
  in the Permanent workspace

The symlinks are created at provision time by `install.sh`, which `bootstrap.sh`
runs automatically. It follows the same nested-config pattern as
`postgresql`/`newsyslog`: an existing symlink is left alone, and a real file at
the target is backed up to `<name>.backup` before linking. Drop a new file in
`config/` and it gets linked on the next run — no script changes needed.

Settings reload automatically on save, except `model` and `outputStyle`, which
take effect in a new session.

## settings.json

`config/settings.json` is the source of truth. The live `~/.claude/settings.json`
is a symlink to it, so edits here apply everywhere.

Current keys:

| Key                        | Purpose                                               |
| -------------------------- | ----------------------------------------------------- |
| `alwaysThinkingEnabled`    | Extended thinking on by default                       |
| `effortLevel`              | Persisted reasoning effort (`high`)                   |
| `skipAutoPermissionPrompt` | Don't prompt for the auto-permission opt-in           |
| `permissions`              | `defaultMode: auto`, plus an explicit allow/deny list |
| `attribution`              | Strips the `Co-Authored-By` trailer from commits      |
| `spinnerVerbs`             | Custom "thinking" phrases (see below)                 |
| `theme`                    | Follow the system light/dark appearance               |
| `statusLine`               | Shows the signed-in account and organization          |

## Commit attribution

```json
"attribution": {
  "commit": ""
}
```

An empty `commit` string hides the standard attribution (including the
`Co-Authored-By: Claude` trailer) from git commits. Add `"pr": ""` to also drop
the attribution footer from generated pull request descriptions. (This replaces
the deprecated `includeCoAuthoredBy` boolean.)

## Custom thinking phrases (spinnerVerbs)

The words shown while Claude works are themed for fun. Schema:

```json
"spinnerVerbs": {
  "mode": "replace",
  "verbs": ["Seeking the Ocarina of Time", "..."]
}
```

- `mode: "replace"` — show **only** these phrases.
- `mode: "append"` — add these on top of Claude's built-in defaults.

To add or change phrases, just edit the `verbs` array in
`config/settings.json`. The current set mixes Legend of Zelda, Lord of the
Rings, and Star Wars references.

## Global instructions (CLAUDE.md)

`config/CLAUDE.md` is symlinked to `~/.claude/CLAUDE.md` and holds personal
preferences that apply to **every** project (working style, git habits, editing
defaults). Project-level `CLAUDE.md` files take precedence where they conflict.
Edit it directly — keep it cross-project; project-specific rules belong in that
project's own `CLAUDE.md`.

## Permanent profile

Repositories under the Permanent workspace (`~/Code/permanent` by default;
override with `CLAUDE_PERMANENT_ROOT`) run Claude Code against a separate
configuration directory, `~/.claude-permanent`, so they sign in to the
Permanent account while everything else keeps the personal one.

- `permanent.zsh` wraps `claude`: inside the workspace it sets
  `CLAUDE_CONFIG_DIR`, layers `permanent/settings.json` over the base settings
  with `--settings`, and loads the Tank plugins listed in
  `CLAUDE_PERMANENT_PLUGINS` straight from the local checkout with
  `--plugin-dir`, so plugin edits apply on the next session without a
  reinstall. `command claude` skips the wrapper.
- `install.sh` links `~/.claude-permanent/settings.json` to the base
  `config/settings.json`, so the profile inherits every base setting, and
  `~/.claude-permanent/CLAUDE.md` to `permanent/CLAUDE.md`, which imports the
  base `CLAUDE.md` before adding Permanent-only instructions.
- `~/.claude-permanent/projects` links to `~/.claude/projects`, so session
  history and auto-memory for Permanent repositories carry over.
- Put Permanent-only settings in `permanent/settings.json`; lists such as
  `permissions.allow` merge with the base rather than replace it.
- Run `/login` once in a Permanent repository to sign in to the Permanent
  account; its credentials are stored separately from the personal account.

Editors and the desktop app don't go through the shell wrapper, so they use the
personal profile unless `CLAUDE_CONFIG_DIR` is set for them.

## Other global configs worth considering

Not set up yet, but easy to add as their own symlinked files in this topic:

- **Spinner tips** — `spinnerTipsEnabled` (bool) and `spinnerTipsOverride`
  (string) control the hint line under the spinner.
- **Output style** — `outputStyle` (e.g. `"Explanatory"`) adjusts response style.
- **keybindings** — `~/.claude/keybindings.json` for custom shortcuts / vim mode
  (`editorMode`).

### Do not check in

- `~/.claude.json` — OAuth tokens, MCP auth, and session state.
- `~/.claude/settings.local.json` — per-project personal overrides (gitignored).

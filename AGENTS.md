# Agent Instructions for Dotfiles Project

This document provides guidance for AI agents working within this dotfiles repository. The instructions are designed to be agent-agnostic and applicable to any LLM-based assistant.

## Core Principles

1. **Maintain User Agnosticism**: Do not include references to specific usernames, personal details, or local paths beyond those explicitly defined in the project setup (`.env`, `local/config.json`). The dotfiles should remain portable and reusable.

2. **Agent Agnosticism**: Do not include references to specific AI agents or assistants in code, documentation, or commit messages. Keep all content neutral and applicable to any development workflow.

3. **Documentation Maintenance**: When making changes to the project, always update relevant documentation to reflect those changes. This includes both the README.md and this AGENTS.md file.

## Project Structure

This is a topic-based dotfiles repository inspired by Zach Holman's dotfiles structure. Each directory represents a "topic" (an area of functionality).

### Directory Organization

- Each topic directory contains configuration and setup files for a specific tool or functionality area
- Examples: `git/`, `zsh/`, `python/`, `docker/`, `macos/`, etc.
- When adding new functionality, create a new topic directory at the root level

### Special Files by Naming Convention

Understanding these patterns is critical for working efficiently in this project:

#### Within Topic Directories

- **`*.zsh`**: Shell scripts that get automatically sourced into the zsh environment
    - Recommended prefixes: `env.zsh` (environment variables), `path.zsh` (PATH modifications), `alias.zsh` (command aliases), `hook.zsh` (shell hooks)
    - Example: `git/alias.zsh`, `python/env.zsh`

- **`*.symlink`**: Files that get automatically symlinked to `$HOME` (without the `.symlink` extension)
    - Example: `git/gitconfig.symlink` � `~/.gitconfig`
    - Example: `zsh/zshrc.symlink` � `~/.zshrc`

- **`preinstall.sh`**: Scripts executed during bootstrap BEFORE Homebrew runs
    - Use for setup that must happen before package installation
    - Example: `homebrew/preinstall.sh` (installs Homebrew itself)

- **`install.sh`**: Scripts executed during bootstrap AFTER Homebrew runs
    - Use for post-installation configuration and setup
    - Example: `macos/install.sh` (installs macOS applications)

#### Root Directory Special Files

- **`bin/`**: Executables added to `$PATH`, available system-wide
- **`Brewfile`**: Homebrew bundle file listing packages and applications to install
- **`bootstrap.sh`**: Main installation script that orchestrates the entire setup
- **`.env`**: Local environment variables (not checked into git, created from `.env.template`)
- **`local/config.json`**: Local configuration data (not checked into git, created from `local/config.json.example`)

## Bootstrap Process Flow

Understanding the execution order is important for making modifications:

1. `setup_gitconfig()` - Generates local git configuration
2. `install_dotfiles()` - Creates symlinks for all `*.symlink` files
3. All `preinstall.sh` scripts execute
4. `brew bundle` runs (processes `Brewfile`)
5. All `install.sh` scripts execute

## Common Tasks

### Adding a New Tool Configuration

1. Create a new directory at the root level named after the tool
2. Add configuration files following the naming conventions above
3. If the tool requires packages, add them to `Brewfile`
4. If custom setup is needed, create `install.sh` or `preinstall.sh`
5. Update README.md if the tool requires manual setup steps

### Modifying Shell Environment

- Add environment variables in `topic/env.zsh`
- Add PATH modifications in `topic/path.zsh`
- Add aliases in `topic/alias.zsh`
- These files are automatically sourced when a new shell starts

### Adding Homebrew Packages

Edit `Brewfile` in the root directory. Use these formats:

- `brew "package-name"` for command-line tools
- `cask "app-name"` for GUI applications
- `mas "App Name", id: 123456` for Mac App Store applications

### Creating Symlinked Configuration Files

1. Place the file in the appropriate topic directory
2. Name it with the `.symlink` extension
3. The bootstrap process will automatically symlink it to `$HOME`
4. Example: `vim/vimrc.symlink` becomes `~/.vimrc`

## Working with Local Configuration

### Environment Variables (`.env`)

- Template: `.env.template`
- Actual file: `.env` (gitignored)
- Used for: `DEVICE_NAME`, `USER_EMAIL`, and other user-specific values
- These variables are sourced during bootstrap and can be used in scripts

### JSON Configuration (`local/config.json`)

- Template: `local/config.json.example`
- Actual file: `local/config.json` (gitignored)
- Used for: Structured configuration data like SMB mounts
- Parse this file in scripts when you need user-specific structured data

## Error Handling and Script Patterns

This project follows specific patterns for error handling to ensure reliable installations while maintaining flexibility.

### Philosophy

- **Individual scripts fail fast**: Each `install.sh` should exit on error within its own scope (`set -e`)
- **Bootstrap continues on failure**: The main `bootstrap.sh` tracks failures but continues with other scripts
- **Logical isolation**: Each install script is treated as an independent task that won't break others

### Shared Utility Functions

All scripts should source the shared functions library:

```bash
#!/usr/bin/env bash
set -e
source ~/.dotfiles/lib/functions.sh
```

Available functions from `lib/functions.sh`:

- **`info "message"`** - Display informational message with blue indicator
- **`success "message"`** - Display success message with green indicator
- **`fail "message"`** - Display error message with red indicator and exit
- **`warn "message"`** - Display warning message with yellow indicator
- **`user "message"`** - Display user prompt message
- **`check_command tool_name`** - Verify a command exists, fail if not
- **`require_env VAR_NAME`** - Verify an environment variable is set, fail if not
- **`check_exists /path/to/file`** - Verify a file/directory exists, fail if not

### Standard install.sh Pattern

Every `install.sh` script should follow this pattern:

```bash
#!/usr/bin/env bash
set -e # Exit on error within this script
source ~/.dotfiles/lib/functions.sh

# 1. Validate prerequisites
check_command required_tool
require_env REQUIRED_VAR # If script needs environment variables

# 2. Inform user what's happening
info "Installing something"

# 3. Check if already installed/configured (idempotency)
if [ -f ~/.config/something ]; then
	info "Already configured"
	exit 0
fi

# 4. Perform operations
some_command
mkdir -p ~/.config
ln -s ~/.dotfiles/topic/config ~/.config/something

# 5. Report success
success "Installation complete"
```

### Environment Variable Validation

Scripts that require environment variables should validate them:

- **In bootstrap.sh**: `validate_environment()` checks `USER_EMAIL` and `DEVICE_NAME`
- **In install scripts**: Use `require_env VAR_NAME` for script-specific requirements

### Idempotency Guidelines

Scripts should be safely re-runnable:

```bash
# Check before creating
if [ ! -d "$DIR" ]; then
	mkdir -p "$DIR"
fi

# Check before symlinking
if [ ! -L "$LINK" ]; then
	ln -s "$TARGET" "$LINK"
fi

# Check if already installed
if command_output | grep -q "already installed"; then
	info "Already installed"
else
	install_command
fi
```

### Destructive Operations

For potentially destructive operations (like replacing directories):

1. **Check if target exists**
2. **Warn user** about what will happen
3. **Create backups** before removing
4. **Provide recovery information**

Example from `maestral/install.sh`:

```bash
if [ -e "$local_dir" ] && [ ! -L "$local_dir" ]; then
	warn "$dir_name exists and will be replaced with a symlink"
	info "Backing up existing $dir_name to ${dir_name}.backup"
	mv "$local_dir" "${local_dir}.backup"
fi
```

### Bootstrap Error Tracking

The `bootstrap.sh` script:

- Uses `set +e` to continue on errors
- Tracks which scripts succeed and fail
- Reports a summary at the end
- Shows clear indication of what needs attention

### When Writing New Scripts

1. Always start with the standard pattern (shebang, set -e, source functions)
2. Validate prerequisites before making changes
3. Make operations idempotent
4. Use informative logging (info/success/warn)
5. Handle errors gracefully within the script's scope
6. Test that the script can be run multiple times safely

## Best Practices for Agents

### When Modifying Files

1. **Read before writing**: Always read existing files to understand their structure and style
2. **Preserve structure**: Maintain consistency with existing patterns and conventions
3. **Test considerations**: Remember that changes to `*.zsh` files affect shell startup
4. **Symlink awareness**: Modifications to `*.symlink` files affect the user's home directory

### When Adding Features

1. **Check existing topics**: See if functionality fits in an existing directory
2. **Follow conventions**: Use the established naming patterns
3. **Consider bootstrap order**: Think about whether setup needs to happen in `preinstall.sh` or `install.sh`
4. **Update documentation**: Add information to README.md for any manual steps

### When Troubleshooting

1. **Check execution order**: Issues may relate to when scripts run in the bootstrap process
2. **Verify symlinks**: Use `ls -la ~/` to see what's linked where
3. **Test in isolation**: Individual install scripts can be run independently
4. **Review shell files**: Check `*.zsh` files for conflicts or errors

### Documentation Updates

When making changes, always update documentation:

1. **README.md**: Update if you add new manual setup steps, change the bootstrap process, or add significant new features
2. **AGENTS.md** (this file): Update if you add new patterns, conventions, or architectural decisions that future agents should know about
3. **Topic-specific READMEs**: Some topics have their own README files (e.g., `local/README.md`) - update these if you change topic-specific behavior

## Code Quality Guidelines

- Use bash best practices in shell scripts
- Include error handling where appropriate
- Add comments for complex logic
- Keep scripts modular and focused on single responsibilities
- Avoid hardcoding user-specific values (use `.env` or `local/config.json` instead)

## Code Formatting and Linting

This project uses [Prettier](https://prettier.io/) with [prettier-plugin-sh](https://github.com/un-ts/prettier/tree/master/packages/sh) to maintain consistent code formatting across all files, including shell scripts.

### Running Formatting and Linting

- **Format all files**: `npm run format`
- **Check formatting**: `npm run lint`

### When to Run Formatting

**Always run the formatter before committing code.** This is a required expectation for all changes to the repository.

1. **Before commits**: Run `npm run format` to automatically fix formatting issues
2. **During development**: Run `npm run lint` to check if your changes meet formatting standards
3. **After making changes**: Verify all files pass linting with `npm run lint`

### What Gets Formatted

Prettier with the shell plugin handles formatting for:

- Shell scripts (`.sh`, `.bash`, `.zsh` files)
- JavaScript and JSON files (`package.json`, configuration files)
- Markdown files (`.md`)
- YAML files (`.yml`, `.yaml`)
- And other common file types

### Configuration

- **`.prettierrc`**: Project formatting rules (uses tabs, includes shell plugin)
- **`.editorconfig`**: Editor-level formatting hints (tabs for most files, spaces for YAML)
- **`.node-version`**: Specifies Node.js version (24) for consistent tooling

### CI Integration

The CI pipeline runs `npm run lint` on all pull requests and pushes to the main branch. Code that doesn't pass Prettier checks will fail CI and must be fixed before merging.

### Best Practices

1. **Install Node.js**: Ensure you have Node.js installed (version 24 or compatible)
2. **Install dependencies**: Run `npm install` in the repository root
3. **Format early and often**: Don't wait until the end to format your changes
4. **Trust the formatter**: Prettier is opinionated by design; let it handle formatting decisions
5. **Check before pushing**: Always run `npm run lint` before pushing commits

## Privacy and Security

- Never commit `.env` or `local/config.json` files
- Never commit SSH keys, GPG keys, or other secrets
- Be cautious with API tokens and credentials
- Use templates (`.example` or `.template` files) to show structure without revealing secrets

## Git Workflow

- The main branch is `main`
- Feature branches should be descriptive
- Commit messages should be clear and concise
- When committing, ensure changes don't include personal information beyond what's documented in setup instructions

## Testing Changes

To test changes without affecting the user's system:

1. Review what symlinks will be created
2. Check what Homebrew packages will be installed
3. Consider running individual `install.sh` scripts rather than full bootstrap
4. Remember that `bootstrap.sh` can be re-run safely

## Platform Considerations

- This repository is primarily designed for macOS
- Some components may be platform-specific (e.g., `macos/` directory)
- Use platform detection (`uname -s`) when adding cross-platform features
- The default credential helper and some tools are macOS-specific

## Resources

- Bootstrap script: `bootstrap.sh`
- Main documentation: `README.md`
- Homebrew packages: `Brewfile`
- Example configurations: Files ending in `.example` or `.template`

---

**Remember**: Keep this documentation current. When you make significant changes to the project structure, conventions, or workflow, update this file accordingly.

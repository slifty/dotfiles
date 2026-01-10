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

# slifty's dotfiles

These dotfiles contain my provisioning script for setting up fresh MacOS devices. It is a modified fork of the structured dotfiles of [Zach Holman](https://github.com/holman/dotfiles).

## Instructions

This repository is designed to run on a completely clean machine, though that isn't necessarily a requirement. For best results, however, you should follow these instructions immediately after logging in and before manually installing anything else (except were asked to as part of the instructions).

### Step 1: Preparation

Before running these dotfiles you'll need to do the following:

1. Install git (you can do this on a new MacOS machine by typing "git" in terminal and doing whatever Apple tells you to do)
2. Set up your git authentication however you want (this might mean setting up ssh keys, for instance)
2. Cloning this repository to `~/.dotfiles`

```
git clone git@github.com:slifty/dotfiles.git ~/.dotfiles
```

### Step 2: Review

From here you may want to take a moment to review the dotfiles:

* Applications in the `Brewfile` that are no longer relevant?
* Applications in `macos/install.sh` that you don't use any more?
* Go through the `macos/set-defaults.sh` to see if you still like all of those settings.

### Step 3: Installing the dotfiles

Finally you can run the bootstrap script which will install everything:

```
cd ~/.dotfiles && ./bootstrap.sh
```

You can re-run `./bootstrap.sh` whenever you feel inspired.

### Step 4: Setting MacOS Defaults (Optional)

I suppose every step is optional, but this one really is.  You can set up a series of MacOS defaults by running:

```
cd ~/.dotfiles/macos && ./set-defaults.sh
```

## Modifying the dotfiles

### Organizaztion

Each folder is intended to cover an area of functionality of your computer (as Zach Holman said: topics).  As you find new topics of functionality in your computing life you should just toss in a new root directory.

### Special Topic Files

There are a few special files which exist in the root directory have a few special files.

- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your environment.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into your `$HOME` (with `.symlink` removed).
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed as part of `bootstrap.sh`.

### Special Root Files

There are also a few special files in the root directory:

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install.

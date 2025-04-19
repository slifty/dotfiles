# slifty's dotfiles

These dotfiles contain my provisioning script for setting up fresh MacOS devices. It is a modified fork of the structured dotfiles of [Zach Holman](https://github.com/holman/dotfiles).

## Instructions

This repository is designed to run on a completely clean machine, though that isn't necessarily a requirement. For best results, however, you should follow these instructions immediately after logging in and before manually installing anything else (except were asked to as part of the instructions).

### Step 1: Preparation

Before running these dotfiles you'll need to do the following:

1. Install git (you can do this on a new MacOS machine by typing "git" in terminal and doing whatever Apple tells you to do)
2. Clone this repository to `~/.dotfiles`

```
git clone https://github.com/slifty/dotfiles.git ~/.dotfiles
git remote set-url origin git@github.com:slifty/dotfiles.git
```

3. Define local configuration settings

```
cd ~/.dotfiles
cp .env.template .env
cp local/config.json.example local/config.json
vi .env
vi local/config.json
```

4. Source the configuration settings

```
source .env
```

### Step 2: Review everything

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

### Step 5: Manual setup

1. Register the shiny new SSH key that the script generated in appropriate places

 - GitHub
 - Any necessary servers

2. Install your GPG key:

```
# On the old machine...
gpg --list-secret-keys --keyid-format LONG
gpg --export --armor KEYID > private.key.asc

# Transfer the key securely

# On the new machine...
gpg -d private.key.asc > private.key
gpg --import private.key
rm private.key
```

## Modifying the dotfiles

### Organizaztion

Each folder is intended to cover an area of functionality of your computer (as Zach Holman said: topics).  As you find new topics of functionality in your computing life you should just toss in a new root directory.

### Special Topic Files

There are a few special files which exist in the root directory have a few special files.

- **topic/\*.zsh**: Any files ending in `.zsh` get sourced into your environment.  (Recommended prefixes: env, path, alias, hook)
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into your `$HOME` (with `.symlink` removed).
- **topic/preinstall.sh**: Any file named `preinstall.sh` is executed as part of `bootstrap.sh` but BEFORE brew is invoked.
- **topic/install.sh**: Any file named `install.sh` is executed as part of `bootstrap.sh`.

### Special Root Files

There are also a few special files in the root directory:

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install.

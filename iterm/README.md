# iTerm2 Configuration

This directory manages iTerm2 configuration using a clean, version-controlled approach that avoids tracking ephemeral state.

## Architecture

Instead of tracking the entire `com.googlecode.iterm2.plist` file (which changes constantly with window positions, sizes, and temporary state), we use:

1. **Dynamic Profiles** (`profiles/*.json`) - Profile-specific settings like colors, fonts, keybindings
2. **Settings Script** (`settings.sh`) - Global behavior settings applied via `defaults write`

This approach provides:

- ✅ Clean git history (no noise from window resizing, etc.)
- ✅ Easy-to-review configuration changes
- ✅ Device-specific customization support
- ✅ Clean provisioning to new machines

## Files

### `profiles/Default.json`

Dynamic Profile configuration in JSON format. This defines:

- Terminal type and character encoding
- Font settings (bold, italic, ligatures)
- Scrollback behavior
- Bell/visual feedback
- Smart selection rules
- Triggers

**Note:** Colors and fonts can be added here. See [iTerm2 Dynamic Profiles Documentation](https://iterm2.com/documentation-dynamic-profiles.html) for all available options.

### `settings.sh`

Global iTerm2 settings applied via `defaults write` commands. This includes:

- Quit behavior (prompt settings)
- Appearance preferences
- Window behavior
- Keyboard mappings
- Performance settings

Many settings are commented out by default. Uncomment the ones you want to apply.

### `install.sh`

Installation script that:

1. Disables the old plist sync folder approach
2. Symlinks Dynamic Profiles to the correct location
3. Applies global settings via `settings.sh`

## Usage

### Initial Setup

Run the install script (typically called by `bootstrap.sh`):

```bash
cd ~/.dotfiles/iterm && ./install.sh
```

**Important:** Restart iTerm2 after running the install script for changes to take effect.

### Customizing Settings

#### To modify profile settings (colors, fonts, etc.):

1. Edit `profiles/Default.json`
2. Restart iTerm2 or reload profiles (Preferences > Profiles > Other Actions > Reload All Dynamic Profiles)

#### To modify global behavior:

1. Edit `settings.sh`
2. Run `~/.dotfiles/iterm/settings.sh`
3. Restart iTerm2 if needed

#### Device-specific settings:

You can add device-specific logic in `settings.sh` using the `$DEVICE_NAME` variable from your `.env` file:

```bash
if [ "$DEVICE_NAME" = "MyLaptop" ]; then
	# Smaller font for laptop screen
	defaults write com.googlecode.iterm2 "NormalFont" -string "Monaco 12"
elif [ "$DEVICE_NAME" = "MyDesktop" ]; then
	# Larger font for desktop monitors
	defaults write com.googlecode.iterm2 "NormalFont" -string "Monaco 16"
fi
```

## Discovering Settings

To find the correct key names for settings you want to configure:

### Method 1: Dump all preferences

```bash
defaults read com.googlecode.iterm2 > /tmp/before.txt
# Change setting in iTerm2 UI
defaults read com.googlecode.iterm2 > /tmp/after.txt
diff /tmp/before.txt /tmp/after.txt
```

### Method 2: Monitor changes in real-time

```bash
defaults read com.googlecode.iterm2 | tee /tmp/iterm-prefs.txt
# Change setting in UI
defaults read com.googlecode.iterm2 | diff /tmp/iterm-prefs.txt -
```

### Method 3: Check specific key

```bash
defaults read com.googlecode.iterm2 "KeyNameHere"
```

## Backup

The old plist-based configuration was backed up to `local/com.googlecode.iterm2.plist.backup` during migration. This file is gitignored and kept for reference only.

## Migration Notes

This setup replaced the old "preference sync folder" approach which tracked the entire plist file. Benefits of the new approach:

**Old approach:**

- ❌ Constant git noise from window resizing, position changes
- ❌ Merge conflicts when syncing across machines
- ❌ Hard to review meaningful changes
- ❌ Binary plist format difficult to read

**New approach:**

- ✅ Only meaningful settings tracked
- ✅ JSON format (easy to read/review)
- ✅ Declarative settings via scripts
- ✅ Device-specific customization support
- ✅ No ephemeral state noise

## Resources

- [iTerm2 Dynamic Profiles Documentation](https://iterm2.com/documentation-dynamic-profiles.html)
- [iTerm2 Scripting](https://iterm2.com/python-api/)
- [macOS defaults command](https://macos-defaults.com/)

## Troubleshooting

### Changes not appearing

- Make sure you've restarted iTerm2
- Check that Dynamic Profiles are enabled: Preferences > General > Preferences > "Load preferences from custom folder" should be **OFF**
- Verify the symlink exists: `ls -la ~/Library/Application\ Support/iTerm2/DynamicProfiles/`

### Profile not showing up

- Go to Preferences > Profiles > Other Actions > Reload All Dynamic Profiles
- The "Default" profile from Dynamic Profiles should appear in the list

### Settings reverting

- Some settings require iTerm2 to be completely quit and restarted
- Some settings may conflict with existing user preferences
- Check `defaults read com.googlecode.iterm2` to see actual values

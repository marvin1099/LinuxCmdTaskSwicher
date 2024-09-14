# LinuxCmdTaskSwitcher

This is a simple script I use with `xbindkeys` to switch between open tasks with a single key combination. 
It cycles through tasks based on the order in which they were opened.

- **Main Repository**: [LinuxCmdTaskSwitcher on Codeberg](https://codeberg.org/marvin1099/LinuxCmdTaskSwicher)
- **Backup Repository**: [LinuxCmdTaskSwitcher on GitHub](https://github.com/marvin1099/LinuxCmdTaskSwicher)

## Installation

To use this script, you need to install the following packages:

```bash
xdotool xorg-xprop xorg-xwininfo
```

After that, you can download the script from one of these sources:

- [Main Repository](https://codeberg.org/marvin1099/LinuxCmdTaskSwicher/releases)
- [Backup Repository](https://github.com/marvin1099/LinuxCmdTaskSwicher/releases)

## Usage

To use the script, simply run it in a terminal or add it as a keyboard shortcut (for example, with `xbindkeys`).

You can configure the script to show the desktop after switching between all open programs.  
Additionally, it can restore minimized windows after the desktop is shown. The syntax is as follows:

```bash
./SwitchOpenWindows.sh desktop=true restore=true
```
You can replace `true` with `false` to customize your settings.  

If you'd like to run the script with default settings, you can simply execute:

```bash
./SwitchOpenWindows.sh
```

### Default Settings
- **desktop**: `false` (does not show the desktop by default)
- **restore**: `true` (restores minimized windows by default)

If `desktop` is set to `true` and all windows are minimized,  
the script will restore the previously minimized windows.

## Notifications

The notification feature was removed because it caused issues.
Since the changes are usually obvious, keeping this feature was not necessary.

# Sonic-TTE: The High-Impact Media Screensaver

**Sonic-TTE** is a high-impact, animated media screensaver for your terminal, built for the Arch/Hyprland community. It monitors your music playback (via `playerctl`) and displays your current song title in beautifully centered, high-contrast ASCII art, all animated with the powerful **TerminalTextEffects**.

## Features
- **Event-Driven Updates**: Detects song changes immediately via `playerctl --follow`.
- **Responsive Centering**: Dynamically calculates terminal size and text ink-width for pixel-perfect centering.
- **Dynamic Animation**: Randomly cycles through 30+ terminal effects from `terminaltexteffects`.
- **Smart Wrapping**: Ensures long song titles wrap cleanly without breaking words.
- **Interactive Controls**: Skip animations or exit with simple keybinds.

## Installation

### 1. Requirements
Ensure you have the following tools installed:
- `playerctl` (for media monitoring)
- `figlet` (for ASCII generation)
- `python-terminaltexteffects` (available in AUR or `omarchy` repo as `python-terminaltexteffects` / `tte`)

### 2. Arch Linux (AUR)
The recommended way to install on Arch Linux is via the AUR:
```bash
# Using paru
paru -S sonic-tte-git

# Using yay
yay -S sonic-tte-git
```

### 3. Manual / Development Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/shmall03/sonic-tte.git
   cd sonic-tte
   ```
2. Make the launcher executable:
   ```bash
   chmod +x bin/sonic-tte bin/center_text.py
   ```
3. Run directly from the repo:
   ```bash
   ./bin/sonic-tte
   ```

## Configuration
Sonic-TTE follows the **XDG Base Directory Specification**. It searches for configuration in this order:
1. `~/.config/sonic-tte/config`
2. `/etc/sonic-tte/config`
3. `./share/sonic-tte.conf.example` (Fallback/Reference)

### Customizable Variables:
- `FONT_PATH`: Absolute path to your `.flf` font (defaults to the included `Delta-Corps-Priest-1.flf`).
- `WRAP_WIDTH`: Maximum characters per line before wrapping (default: 20).
- `INCLUDE_EFFECTS`: Space-separated list of specific animations (e.g., `burn matrix decrypt`).
- `EXCLUDE_EFFECTS`: Animations you wish to skip.

## Usage
Simply run the script:
```bash
sonic-tte
```

### Controls
- **[SPACE]**: Skip the current effect and trigger a new random one.
- **[Q]**: Gracefully exit the program.

---
*Created for aesthetic terminal enthusiasts. Part of the Omarchy & Arch + Hyprland communities.*

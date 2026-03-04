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
- `python3` & `terminaltexteffects` (e.g., `pip install terminaltexteffects`)

### 2. Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/shmall03/sonic-tte.git
   cd sonic-tte
   ```
2. Make the launcher executable:
   ```bash
   chmod +x sonic-tte.sh center_text.py
   ```

## Configuration
Sonic-TTE follows the **XDG Base Directory Specification**. It looks for configuration in:
1. `~/.config/sonic-tte/config`
2. `/etc/sonic-tte/config`
3. `./sonic-tte.conf` (Local fallback)

Edit the config file to customize:
- `WRAP_WIDTH`: How many characters per line before wrapping.
- `INCLUDE_EFFECTS`: List specific animations you want (e.g., `burn matrix decrypt`).
- `EXCLUDE_EFFECTS`: Animations you want to skip.

## Usage
Simply run the script:
```bash
./sonic-tte.sh
```

### Controls
- **[SPACE]**: Skip the current effect and fire a new random one.
- **[Q]**: Gracefully exit the program.

---
*Created for the aesthetic terminal enthusiasts.*

# 🔊 Sonic-TTE: High-Impact Media Screensaver

[![Arch Linux](https://img.shields.io/badge/OS-Arch%20Linux-1793d1?logo=arch-linux&logoColor=white)](https://aur.archlinux.org/packages/sonic-tte-git)
[![Omarchy](https://img.shields.io/badge/Distro-Omarchy-8a2be2?logo=arch-linux&logoColor=white)](https://github.com/basecamp/omarchy)
[![Hyprland](https://img.shields.io/badge/WM-Hyprland-33ccff?logo=hyprland&logoColor=white)](https://hyprland.org/)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![TerminalTextEffects](https://img.shields.io/badge/Powered%20By-TerminalTextEffects-ff69b4)](https://github.com/ChrisBuilds/terminaltexteffects)

**Sonic-TTE** is a high-octane, event-driven animated screensaver for your terminal. Designed for the Arch & Hyprland communities, it transforms your current music playback into a living ASCII art performance.

---

## ✨ Features

- 🚀 **Event-Driven**: Monitors music playback via `playerctl` with near-zero latency.
- 📐 **Smart Resizing**: Automatically adapts to terminal window resizing (`SIGWINCH`) without breaking the animation.
- 🔒 **Secure & Robust**: Multi-user safe (via user-specific temp files) and features a secure configuration parser.
- 🎨 **Fully Customizable**: Support for any FIGlet font and fine-grained control over animation effects.
- 🔌 **Agnostic**: Works with Spotify, Firefox, VLC, and any player supporting the MPRIS spec.

---

## ✨ Visuals

![Example gif](example.gif)

---

## 🚀 Installation

### 1. Arch Linux (The Pro Way)
Install directly from the **AUR** using your favorite helper:

```bash
# Using paru (Recommended)
paru -S sonic-tte-git

# Using yay
yay -S sonic-tte-git
```

### 2. Dependencies
If installing manually, ensure you have:
- `playerctl` (Media monitoring)
- `figlet` (ASCII generation)
- `python-terminaltexteffects` (The engine)

---

## 🎨 Omarchy Integration

Want to add Sonic-TTE to your Omarchy dash? It's easy!

1. Open the **Omarchy Menu** (`SUPER` + `ALT` + `SPACE`).
2. Navigate to **'Install'** ➔ **'TUI'**.
3. **Name**: `Sonic TTE`.
4. **Command**: `sonic-tte`.
5. **Window Type**: Choose *either* `floating` or `tiling` window type! Either will work.
6. **Icon URL**: Use your own favorite icon URL (e.g. from [Flaticon](https://www.flaticon.com)).
7. **Enjoy!** ✨

---

## 🛠️ Configuration

Sonic-TTE follows the **XDG** standard. Custom settings live in:
`~/.config/sonic-tte/config`

### Key Options:
| Variable | Description | Default |
| :--- | :--- | :--- |
| `PLAYER` | Target a specific player (e.g. `spotify`) | *(All)* |
| `WRAP_WIDTH` | Chars per line before wrapping | `20` |
| `POLL_INTERVAL`| Delay when nothing is playing (sec) | `2` |
| `INCLUDE_EFFECTS`| Space-separated list of effects | *(All)* |
| `EXCLUDE_EFFECTS`| Effects to skip | *(None)* |
| `FONT_PATH` | Path to your favorite FIGlet `.flf` font | *(Bundled)* |

---

## ⌨️ Keybinds

| Key | Action |
| :--- | :--- |
| `[SPACE]` | Skip current animation & roll a new one |
| `[Q]` | Graceful Exit |

---

<p align="center">
  <i>Created with ❤️ for aesthetic terminal enthusiasts. Part of the <b>Omarchy</b> & <b>Arch + Hyprland</b> communities.</i>
</p>

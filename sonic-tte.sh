#!/bin/bash

# Sonic-TTE: High-Impact Animated Media Screensaver
# ------------------------------------------------
# Monitors music playback and displays animated ASCII art titles.
# Created for the Omarchy & Arch + Hyprland communities.
# License: GPLv3

# --- 1. Pre-flight Dependency Check ---
# Ensures all required tools are available before starting.
for cmd in playerctl figlet python3 tte; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: '$cmd' is not installed. Please install it to use Sonic-TTE." >&2
        exit 1
    fi
done

# --- 2. Load Configuration ---
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# XDG Standard: Check User Config, then Global, then Local fallback.
# This allows AUR installations to be customized per-user without sudo.
USER_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/sonic-tte/config"
GLOBAL_CONF="/etc/sonic-tte/config"
LOCAL_CONF="$SCRIPT_DIR/sonic-tte.conf"

if [ -f "$USER_CONF" ]; then
    source "$USER_CONF"
elif [ -f "$GLOBAL_CONF" ]; then
    source "$GLOBAL_CONF"
elif [ -f "$LOCAL_CONF" ]; then
    source "$LOCAL_CONF"
else
    # Hardcoded fallback defaults if no config file is found.
    FONT_PATH="$SCRIPT_DIR/fonts/Delta-Corps-Priest-1.flf"
    OUTPUT_FILE="$SCRIPT_DIR/cmd-saver.txt"
    WRAP_WIDTH=20
    POLL_INTERVAL=2
    INCLUDE_EFFECTS=""
    EXCLUDE_EFFECTS=""
fi

TTE_PID=0

# --- 3. Core Functions ---

# Generates ASCII art from the current song title.
generate_ascii() {
    local title="$1"
    if [ -z "$title" ]; then title="Nothing Playing"; fi
    
    # tr: converts to uppercase for font compatibility.
    # fmt: wraps text to the configured width.
    # figlet: generates the ASCII art blocks.
    # center_text.py: handles complex terminal centering logic.
    echo "$title" | tr '[:lower:]' '[:upper:]' | fmt -w "$WRAP_WIDTH" | \
        figlet -f "$FONT_PATH" -w 1000 | \
        "$SCRIPT_DIR/center_text.py" > "$OUTPUT_FILE.tmp"
    
    # Atomic move to prevent 'tte' from reading a partial file.
    mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
}

# Handles song changes by killing the current animation to start a new one.
handle_change() {
    [ "$TTE_PID" -ne 0 ] && kill "$TTE_PID" 2>/dev/null
}
trap handle_change USR1

# Graceful shutdown: cleans up background processes and restores terminal state.
cleanup() {
    echo -e "\nShutting down Sonic-TTE..."
    [ "$TTE_PID" -ne 0 ] && kill "$TTE_PID" 2>/dev/null
    pkill -P $$ 2>/dev/null
    stty echo    # Restore terminal input visibility
    exit 0
}
trap cleanup SIGINT SIGTERM

# --- 4. Background Media Monitor ---
(
    # Initial generation
    generate_ascii "$(playerctl metadata title 2>/dev/null)"
    kill -USR1 $$
    
    # Event-driven monitor: waits for playerctl to report a title change.
    playerctl metadata --follow title 2>/dev/null | while read -r title; do
        generate_ascii "$title"
        kill -USR1 $$
    done
) &

# --- 5. Foreground Display & Input Loop ---
echo "Sonic-TTE is active. Monitoring playerctl..."
echo "Keys: [SPACE] Skip Effect | [Q] Quit"

# stty -echo hides the keypresses from the terminal while the screensaver runs.
stty -echo

while true; do
    # 5a. Start a new effect if one isn't currently running.
    if [ "$TTE_PID" -eq 0 ] && grep -q "[^[:space:]]" "$OUTPUT_FILE" 2>/dev/null; then
        COLS=$(tput cols)
        LINES=$(tput lines)
        
        # Build TerminalTextEffects arguments.
        TTE_ARGS="--input-file $OUTPUT_FILE --random-effect --canvas-width $COLS --canvas-height $LINES --anchor-text c --reuse-canvas --no-eol"
        [ -n "$INCLUDE_EFFECTS" ] && TTE_ARGS="$TTE_ARGS --include-effects $INCLUDE_EFFECTS"
        [ -n "$EXCLUDE_EFFECTS" ] && TTE_ARGS="$TTE_ARGS --exclude-effects $EXCLUDE_EFFECTS"

        tte $TTE_ARGS &
        TTE_PID=$!
    fi

    # 5b. Keybind handling (non-blocking read).
    # We check for input every 0.2 seconds.
    if read -t 0.2 -n 1 key; then
        case "$key" in
            " ") # SPACE: Skip the current effect.
                [ "$TTE_PID" -ne 0 ] && kill "$TTE_PID" 2>/dev/null
                ;;
            "q"|"Q") # Q: Exit the program.
                cleanup
                ;;
        esac
    fi

    # 5c. Housekeeping: check if the tte process has finished naturally.
    if [ "$TTE_PID" -ne 0 ] && ! kill -0 "$TTE_PID" 2>/dev/null; then
        TTE_PID=0
    fi
    
    # 5d. Idle behavior: if no music is playing, sleep to save CPU.
    if [ "$TTE_PID" -eq 0 ] && ! grep -q "[^[:space:]]" "$OUTPUT_FILE" 2>/dev/null; then
        sleep "$POLL_INTERVAL"
    fi
done

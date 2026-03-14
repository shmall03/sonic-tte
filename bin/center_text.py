#!/usr/bin/env python3
import sys

def main():
    # 0. Get height from argument or default to 9
    HEIGHT = int(sys.argv[1]) if len(sys.argv) > 1 else 9

    lines = [l.rstrip() for l in sys.stdin]
    if not lines: sys.exit(0)

    # 1. Group into blocks (font height)
    groups = [lines[i:i+HEIGHT] for i in range(0, len(lines), HEIGHT)]

    # 2. Normalize each group (slam ink to left) and measure ink-width
    processed = []
    for g in groups:
        ink_lines = [l for l in g if l.strip()]
        if not ink_lines: continue
        local_min = min(len(l) - len(l.lstrip()) for l in ink_lines)
        slid = [l[local_min:] if len(l) > local_min else "" for l in g]
        width = max(len(l.rstrip()) for l in slid)
        processed.append((width, slid))

    if not processed:
        sys.exit(0)

    # 3. Find global max width across all groups
    global_max = max(w for w, g in processed)

    # 4. Print each group perfectly centered in a rectangle
    for width, g in processed:
        shift = (global_max - width) // 2
        for l in g:
            # Ensure we maintain the exact same global width for TTE to align correctly
            centered = " " * shift + l.rstrip()
            print(centered.ljust(global_max))

if __name__ == "__main__":
    main()

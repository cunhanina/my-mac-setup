##!/usr/bin/env python3
"""
screenshot_mover.py — moves macOS screenshots from Desktop into
~/Screenshots/YYYY-MM/ folders automatically.

Called by launchd every 10 minutes. Safe to run manually too.
"""

import re
import shutil
from pathlib import Path

DESKTOP = Path.home() / "Desktop"
SCREENSHOTS_ROOT = Path.home() / "Screenshots"

# Handles standard English (new/old layout) and German macOS screenshot naming conventions
SCREENSHOT_PATTERN = re.compile(
    r"^(?:Screenshot|Screen Shot|Bildschirmfoto) (\d{4})-(\d{2})-\d{2}.*\.(png|jpg|jpeg)$",
    re.IGNORECASE
)

def move_screenshots():
    if not DESKTOP.exists():
        return

    moved = 0

    for f in DESKTOP.iterdir():
        if not f.is_file():
            continue

        match = SCREENSHOT_PATTERN.match(f.name)
        if not match:
            continue

        year, month = match.group(1), match.group(2)
        dest_dir = SCREENSHOTS_ROOT / f"{year}-{month}"
        dest_dir.mkdir(parents=True, exist_ok=True)

        dest = dest_dir / f.name

        # Handle collisions by appending an incremental counter
        if dest.exists():
            stem, suffix = f.stem, f.suffix
            counter = 1
            while dest.exists():
                dest = dest_dir / f"{stem}_{counter}{suffix}"
                counter += 1

        shutil.move(str(f), str(dest))
        print(f"Moved: {f.name} → Screenshots/{year}-{month}/")
        moved += 1

    if moved > 0:
        print(f"✅ Moved {moved} screenshot(s).")
    else:
        print("No screenshots to move.")

if __name__ == "__main__":
    move_screenshots()
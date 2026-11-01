#!/usr/bin/env bash
set -euo pipefail

# Application launcher
dnf5 install -y fuzzel

# Python X11 display control
# Used by custom xrandr primary-display script
dnf5 install -y python3-xlib

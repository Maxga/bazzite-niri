#!/usr/bin/env bash
set -euo pipefail
# needed for sunshine homebrew
dnf5 install -y libayatana-appindicator-gtk3

# Podman API socket
systemctl enable podman.socket

# DMS integration with the Niri session
systemctl --global add-wants niri.service dms

# Umbriel/Noctalia:
# Do not globally enable either as a login service.

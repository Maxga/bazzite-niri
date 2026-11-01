#!/usr/bin/env bash
set -euo pipefail

# Bazzite supplies Terra already.
# Enable only the regular Terra repository for this transaction.
#
# Protect the existing Niri and DMS package identities
# against replacement by a different repository version.

existing_wm_rpms="$(rpm -q niri dms | sort)"

dnf5 clean metadata dbcache

dnf5 --refresh --enable-repo=terra \
    --setopt=terra.skip_if_unavailable=False \
    install -y \
    --setopt=install_weak_deps=False \
    --exclude='niri*' \
    --exclude='dms*' \
    umbriel-nightly \
    xdg-desktop-portal-umbriel-nightly \
    noctalia-nightly \
    xdg-desktop-portal-gtk \
    kitty \
    playerctl \
    brightnessctl \
    libnotify \
    orca

# Verify Xwayland is available
command -v Xwayland

# Detect unexpected changes to Niri/DMS packages
after_wm_rpms="$(rpm -q niri dms | sort)"

if [[ "$existing_wm_rpms" != "$after_wm_rpms" ]]; then
    echo 'Niri/DMS package identity changed; stopping build.' >&2
    exit 1
fi

# Verify Umbriel session and portal integration
test -x /usr/bin/start-umbriel
test -r /usr/share/wayland-sessions/umbriel.desktop
test -r /usr/share/xdg-desktop-portal/umbriel-portals.conf

# Verify installation
umbriel --version
noctalia --version

# Do not globally enable Umbriel or Noctalia
# as login services.
#
# Noctalia is started by:
# ~/.config/umbriel/config.toml

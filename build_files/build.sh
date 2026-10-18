#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux nvim alacritty fuzzel
dnf5 copr -y enable avengemedia/dms
dnf5 install -y dms --setopt=install_weak_deps=True
dnf5 install -y niri
# Complete Rust development environment
dnf5 install -y \
    rust \
    cargo \
    rust-analyzer \
    rustfmt \
    clippy \
    rust-src \
    gcc \
    gcc-c++ \
    make \
    pkgconf-pkg-config \
    openssl-devel
# nodejs
dnf5 install -y nodejs npm
# git stuff
dnf5 install -y git-gui gitk
# chat gpt gui
dnf5 install -y https://persistent.oaistatic.com/codex-app-prod/linux/rpm/latest/chatgpt.x86_64.rpm
# some dependencies for tdf (cli pdf viewer in rust)
dnf5 install -y fontconfig-devel pkgconf-pkg-config clang

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl --global add-wants niri.service dms

# Insert after your existing `dnf5 install -y niri` line in build.sh.
# Runs inside the image build, not on the booted immutable host.
# Keep all current Niri/DMS installation and systemctl lines.

# Bazzite supplies Terra already. Enable only its regular repository for this
# transaction; do not enable terra-mesa or import a broad new compositor COPR.
# Excluding niri/dms also protects a patched Niri package from replacement.
trial_existing_wm_rpms="$(rpm -q niri dms | sort)"
dnf5 --enable-repo=terra install -y \
    --setopt=install_weak_deps=False \
    --exclude='niri*' --exclude='dms*' \
    umbriel-nightly \
    xdg-desktop-portal-umbriel-nightly \
    noctalia-nightly \
    xorg-x11-server-Xwayland \
    xdg-desktop-portal-gtk \
    kitty playerctl brightnessctl libnotify orca

# Refuse to produce an image if the existing WM/shell package identities changed.
trial_after_wm_rpms="$(rpm -q niri dms | sort)"
if [[ "$trial_existing_wm_rpms" != "$trial_after_wm_rpms" ]]; then
    echo 'Niri/DMS package identity changed; stopping the trial image build.' >&2
    exit 1
fi
unset trial_existing_wm_rpms trial_after_wm_rpms

# Let the RPM own the display-manager session and portal routing.
test -x /usr/bin/start-umbriel
test -r /usr/share/wayland-sessions/umbriel.desktop
test -r /usr/share/xdg-desktop-portal/umbriel-portals.conf
umbriel --version
noctalia --version

# DO NOT globally enable Noctalia or Umbriel as a login service.
# Noctalia is started only by ~/.config/umbriel/config.toml.
# KEEP your existing final line:
# systemctl --global add-wants niri.service dms

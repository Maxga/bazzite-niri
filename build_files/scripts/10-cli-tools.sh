#!/usr/bin/env bash
set -euo pipefail

# Terminal utilities and editor
dnf5 install -y \
    tmux \
    nvim \
    ripgrep \
    git-gui \
    gitk \
    strace

# wezterm and zsh
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 install -y wezterm
dnf5 install -y \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zoxide
# disable copr again to not have it in image
dnf5 copr -y disable wezfurlong/wezterm-nightly

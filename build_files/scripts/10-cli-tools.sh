#!/usr/bin/env bash
set -euo pipefail

# Terminal utilities and editor
dnf5 install -y \
    tmux \
    nvim \
    alacritty \
    ripgrep \
    git-gui \
    gitk \
    strace

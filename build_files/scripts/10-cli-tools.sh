#!/usr/bin/env bash
set -euo pipefail

# Terminal utilities and editor
dnf5 install -y \
    tmux \
    nvim \
    ripgrep \
    git-gui \
    gitk \
    strace \
    bat \
    bc \
    curl \
    ddgr \
    fzf \
    git-core \
    podman \
    tar

# wezterm and zsh
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 install -y wezterm
dnf5 install -y \
    zsh \
    zsh-syntax-highlighting \
    zoxide
# disable copr again to not have it in image
dnf5 copr -y disable wezfurlong/wezterm-nightly

# Compatibility with the dotfiles' bat=batcat alias.
if [[ ! -e /usr/bin/batcat && ! -L /usr/bin/batcat ]]; then
    ln -sT /usr/bin/bat /usr/bin/batcat
fi

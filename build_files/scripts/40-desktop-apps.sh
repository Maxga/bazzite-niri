#!/usr/bin/env bash
set -euo pipefail

# File synchronization
dnf5 install -y syncthing

# ChatGPT desktop application
dnf5 install -y \
    https://persistent.oaistatic.com/codex-app-prod/linux/rpm/latest/chatgpt.x86_64.rpm

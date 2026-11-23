#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/../dotfiles"

# Pull request and local builds can run without the private repository.
if [[ ! -f "$DOTFILES_DIR/dotfiles.bundle" ]]; then
    echo "==> No dotfiles bundle supplied; skipping dotfiles setup"
    exit 0
fi

dnf5 install -y git-core rsync util-linux

install -Dm644 "$DOTFILES_DIR/dotfiles.bundle" /usr/share/bazzite-dotfiles/dotfiles.bundle
install -Dm755 "$DOTFILES_DIR/bazzite-setup-dotfiles" /usr/bin/bazzite-setup-dotfiles
install -Dm644 "$DOTFILES_DIR/bazzite-dotfiles.service" /usr/lib/systemd/user/bazzite-dotfiles.service

systemctl --global enable bazzite-dotfiles.service

#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/../dotfiles"

# Pull request and local builds can run without the private repository.
if [[ ! -f "$DOTFILES_DIR/dotfiles.bundle" ]]; then
    echo "==> No dotfiles bundle supplied; skipping dotfiles setup"
    exit 0
fi

dnf5 install -y git-core rsync util-linux shadow-utils

install -Dm644 "$DOTFILES_DIR/dotfiles.bundle" /usr/share/bazzite-dotfiles/dotfiles.bundle
install -Dm644 "$DOTFILES_DIR/nvim.bundle" /usr/share/bazzite-dotfiles/nvim.bundle
install -Dm644 "$DOTFILES_DIR/tmux.bundle" /usr/share/bazzite-dotfiles/tmux.bundle
install -Dm755 "$DOTFILES_DIR/bazzite-setup-dotfiles" /usr/bin/bazzite-setup-dotfiles
install -Dm644 "$DOTFILES_DIR/bazzite-dotfiles.service" /usr/lib/systemd/user/bazzite-dotfiles.service
install -Dm755 "$DOTFILES_DIR/bazzite-set-default-shell" /usr/libexec/bazzite-set-default-shell
install -Dm644 "$DOTFILES_DIR/20-bazzite-default-shell.conf" \
    /usr/lib/systemd/system/user@.service.d/20-bazzite-default-shell.conf

systemctl --global enable bazzite-dotfiles.service

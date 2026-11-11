#!/usr/bin/env bash
set -euo pipefail

if ! command -v starship >/dev/null 2>&1; then
    curl -fsSL https://starship.rs/install.sh |
        sh -s -- --yes --bin-dir /usr/bin --version v1.26.0
fi

plugin_dir=/usr/share/zsh/merged-config/plugins
install -d -m 0755 "$plugin_dir"

git clone --depth 1 \
    https://github.com/marlonrichert/zsh-autocomplete.git \
    "$plugin_dir/zsh-autocomplete"

git clone --depth 1 \
    https://github.com/imonior/zsh-smart-complete.git \
    "$plugin_dir/zsh-smart-complete"

# Make the upstream Autocomplete worker available before the first prompt.
zasync_dir=/usr/share/zsh/merged-config/zasync
site_functions=/usr/share/zsh/site-functions
git clone --depth 1 https://github.com/marlonrichert/zasync.git "$zasync_dir"
install -d -m 0755 "$site_functions"
ln -sT "$zasync_dir/zasync" "$site_functions/zasync"
zsh -fc 'autoload -Uz +X zasync'

test -r "$plugin_dir/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
test -r "$plugin_dir/zsh-smart-complete/zsh-smart-complete.plugin.zsh"
test -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fzf --zsh >/dev/null
zoxide init zsh >/dev/null
starship init zsh >/dev/null

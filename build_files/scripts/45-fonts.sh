#!/usr/bin/env bash
set -euo pipefail

dnf5 install -y fontconfig xz

font_version=v3.5.1
font_checksum=04d5e8f903693f9dd13e16f867e994834e681eb3c72c0d337a770dcda09010cf
font_dir=/usr/share/fonts/jetbrains-mono-nerd-font
work_dir=$(mktemp -d)
trap 'rm -rf -- "$work_dir"' EXIT

curl --fail --location --retry 3 \
    --output "$work_dir/JetBrainsMono.tar.xz" \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/$font_version/JetBrainsMono.tar.xz"
printf '%s  %s\n' "$font_checksum" "$work_dir/JetBrainsMono.tar.xz" | sha256sum --check
tar -xJf "$work_dir/JetBrainsMono.tar.xz" -C "$work_dir"

install -d -m 0755 "$font_dir"
install -m 0644 "$work_dir"/*.ttf "$font_dir/"
install -m 0644 "$work_dir/OFL.txt" "$font_dir/OFL.txt"
fc-cache -f "$font_dir"

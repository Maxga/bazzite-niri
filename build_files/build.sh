#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

for script in "$SCRIPT_DIR"/scripts/[0-9]*.sh; do
    echo "==> Executing $(basename "$script")"
    bash "$script"
done

echo "==> Image customization complete"

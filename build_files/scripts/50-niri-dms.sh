#!/usr/bin/env bash
set -euo pipefail

# Dank Material Shell repository
dnf5 copr -y enable avengemedia/dms

# Dank Material Shell and Niri compositor
dnf5 install -y dms \
    --setopt=install_weak_deps=True

dnf5 install -y niri

# Disable the COPR after installation to avoid leaving
# this extra repository enabled in the resulting image.
dnf5 copr -y disable avengemedia/dms

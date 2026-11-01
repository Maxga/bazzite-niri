#!/usr/bin/env bash
set -euo pipefail

# Rust development and native compilation
dnf5 install -y \
    rustup \
    gcc \
    gcc-c++ \
    make \
    pkgconf-pkg-config \
    openssl-devel

# Node.js development
dnf5 install -y \
    nodejs \
    npm

# tdf (Rust CLI PDF viewer) dependencies
dnf5 install -y \
    fontconfig-devel \
    pkgconf-pkg-config \
    clang

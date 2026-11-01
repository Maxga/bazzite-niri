#!/usr/bin/env bash
set -euo pipefail

# QEMU and UEFI support
dnf5 install -y \
    qemu-system-x86 \
    qemu-img \
    qemu-ui-gtk \
    edk2-ovmf

# Kernel debugging and boot image utilities
dnf5 install -y \
    gdb \
    nasm \
    xorriso \
    mtools \
    dosfstools

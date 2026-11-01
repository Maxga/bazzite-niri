#!/usr/bin/env bash
set -euo pipefail

# Eclipse Adoptium repository
cat >/etc/yum.repos.d/adoptium.repo <<'EOF'
[Adoptium]
name=Eclipse Adoptium
baseurl=https://packages.adoptium.net/artifactory/rpm/fedora/$releasever/$basearch
enabled=0
gpgcheck=1
gpgkey=https://packages.adoptium.net/artifactory/api/gpg/key/public
EOF

# Install Temurin JDK 17
dnf5 --enable-repo=Adoptium install -y temurin-17-jdk

# Java build tooling
dnf5 install -y maven

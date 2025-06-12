#!/bin/bash

set -ouex pipefail

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Config files
curl -s https://raw.githubusercontent.com/Emblem-66/ServerBlue/refs/heads/main/ConfigFiles.sh | bash

# COPR repo add
curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-repo.list | xargs -r dnf config-manager addrepo

# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf install -y tailscale
systemctl enable tailscaled
rm /etc/yum.repos.d/tailscale.repo

# SSH
#systemctl enable sshd
systemctl status sshd

# COPR repo add
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-copr.list | xargs -r dnf copr enable -y

# DNF remove packages
curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-remove.list | xargs -r dnf remove -y

# DNF install packages
curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-install.list | xargs -r dnf install -y

# DNF install packages
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/systemd.list | xargs -r systemctl enable

# COPR repo remove
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-copr.list | xargs -r dnf copr remove -y


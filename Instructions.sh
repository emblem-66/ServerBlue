#!/bin/bash

set -ouex pipefail

rpm -qa | sort

dnf install -y dnf-plugins-core

# remove gnome
#dnf remove -y gnome*

# RPM Fusion
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Config files
#curl -s https://raw.githubusercontent.com/Emblem-66/ServerBlue/refs/heads/main/ConfigFiles.sh | bash

# COPR repo add
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-repo.list | xargs -r dnf config-manager addrepo

# Tailscale
#dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

cat << EOF > /etc/yum.repos.d/tailscale.repo
[tailscale-stable]
name=Tailscale stable
baseurl=https://pkgs.tailscale.com/stable/fedora/$basearch
enabled=1
type=rpm
repo_gpgcheck=1
gpgcheck=1
gpgkey=https://pkgs.tailscale.com/stable/fedora/repo.gpg
EOF

dnf install -y tailscale
systemctl enable tailscaled.service
rm /etc/yum.repos.d/tailscale.repo

# SSH
systemctl enable sshd.service

# libvirt

dnf install -y libvirt
systemctl enable libvirtd

# Cockpit
dnf install -y cockpit cockpit-machines cockpit-podman cockpit-files cockpit-navigator cockpit-selinux
systemctl enable cockpit.socket

# COPR repo add
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-copr.list | xargs -r dnf copr enable -y

# DNF remove packages
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-remove.list | xargs -r dnf remove -y

# DNF install packages
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-install.list | xargs -r dnf install -y

# DNF install packages
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/systemd.list | xargs -r systemctl enable

# COPR repo remove
#curl -sSL https://raw.githubusercontent.com/emblem-66/ServerBlue/refs/heads/main/dnf-copr.list | xargs -r dnf copr remove -y



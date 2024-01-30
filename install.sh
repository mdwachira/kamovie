#!/bin/bash
user=kamovie
remote_svr=10.10.10.8
remote_media=/volume1/kamovie
remote_backup=/volume1/docker/backup/kamovie
docker_dir=/opt/docker
secrets_dir=/home/$user/.secrets
backup_dir=/mnt/backup
media_dir=/mnt/media
download_dir=/home/$user/downloads

# Remove old fingerprint and add ssh key to device
# ssh-keygen -R {IP_ADDRESS}
# cat ~/.ssh/id_rsa.pub | ssh {user}@{IP_ADDRESS} "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

# Disable firewall
sudo systemctl disable firewalld --now

# Configure DNF for Faster Downloads of Packages
sudo tee -a /etc/dnf/dnf.conf<<EOF
fastestmirror=true
max_parallel_downloads=10
EOF

# Enable RPM Fusion Repository
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Update the System
sudo dnf update -y
sudo dnf upgrade --all

# Install required software
sudo dnf -y install git curl qemu-guest-agent neofetch
sudo systemctl enable qemu-guest-agent.service --now

# Hide login messages
touch .hushlogin

# # Create user
# useradd $user
# passwd $user
# usermod -aG sudo $user

# Install Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf update -y
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Make directory structure
mkdir -p $docker_dir/docker/{admin_stack,database_stack,download_stack,finance_stack,monitoring_stack,network_stack,streaming_stack}
mkdir -p $download_dir/{complete,incomplete,torrents}
# mkdir -p ~/download/complete/{ebooks,movies,series}
mkdir -p $media_dir/{ebooks,documentary,movies,series,reality,anime}
mkdir -p $media_dir/documentary/{single,series}
mkdir -p $backup_dir
mkdir -p $secrets_dir

# Install NFS
sudo dnf -y install nfs-utils libnfsidmap sssd-nfs-idmap

# Remote NFS mount
sudo tee -a /etc/fstab<<EOF
$remote_media:$remote_media $media_dir nfs defaults 0 0
$remote_media:$remote_backup $backup_dir nfs defaults 0 0
EOF
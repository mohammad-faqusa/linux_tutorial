#!/usr/bin/env bash
set -e

echo "=== Updating system ==="
sudo dnf update -y

echo "=== Installing required packages ==="
sudo dnf install -y \
  gcc \
  make \
  perl \
  bzip2 \
  elfutils-libelf-devel \
  kernel-devel \
  kernel-headers

echo "=== Disabling Wayland for better clipboard support ==="
sudo cp /etc/gdm/custom.conf /etc/gdm/custom.conf.bak 2>/dev/null || true

sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm/custom.conf

if ! grep -q "^WaylandEnable=false" /etc/gdm/custom.conf; then
  sudo bash -c 'cat >> /etc/gdm/custom.conf <<EOF

[daemon]
WaylandEnable=false
EOF'
fi

echo "=== Creating autostart for VirtualBox clipboard ==="
mkdir -p ~/.config/autostart

cat > ~/.config/autostart/vboxclient.desktop <<EOF
[Desktop Entry]
Type=Application
Exec=VBoxClient --clipboard
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=VBox Clipboard
EOF

echo "=== Done basic setup ==="
echo
echo "Now do this manually from VirtualBox menu:"
echo "Devices -> Insert Guest Additions CD Image"
echo
echo "Then run:"
echo "sudo mkdir -p /mnt/cdrom"
echo "sudo mount /dev/cdrom /mnt/cdrom || sudo mount /dev/sr0 /mnt/cdrom"
echo "cd /mnt/cdrom"
echo "sudo sh VBoxLinuxAdditions.run"
echo "sudo reboot"
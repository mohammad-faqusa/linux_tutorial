#!/usr/bin/env bash
set -e

echo "=== Ubuntu VM Guest Additions Setup ==="

echo "=== Updating system ==="
sudo apt update
sudo apt upgrade -y

echo "=== Installing required packages ==="
sudo apt install -y \
  build-essential \
  dkms \
  linux-headers-$(uname -r) \
  perl \
  bzip2

echo "=== Disabling Wayland for better VirtualBox clipboard/resize support ==="
sudo cp /etc/gdm3/custom.conf /etc/gdm3/custom.conf.bak 2>/dev/null || true

if grep -q "^#WaylandEnable=false" /etc/gdm3/custom.conf; then
  sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
elif ! grep -q "^WaylandEnable=false" /etc/gdm3/custom.conf; then
  sudo sed -i '/^\[daemon\]/a WaylandEnable=false' /etc/gdm3/custom.conf
fi

echo "=== Creating VirtualBox clipboard autostart ==="
mkdir -p ~/.config/autostart

cat > ~/.config/autostart/vboxclient-clipboard.desktop <<EOF
[Desktop Entry]
Type=Application
Exec=VBoxClient --clipboard
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=VirtualBox Clipboard
EOF

cat > ~/.config/autostart/vboxclient-dragdrop.desktop <<EOF
[Desktop Entry]
Type=Application
Exec=VBoxClient --draganddrop
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=VirtualBox Drag and Drop
EOF

echo
echo "=== Base setup finished ==="
echo
echo "Now from the VirtualBox window menu:"
echo "Devices -> Insert Guest Additions CD Image"
echo
echo "Then run these commands:"
echo
echo "sudo mkdir -p /mnt/cdrom"
echo "sudo mount /dev/cdrom /mnt/cdrom || sudo mount /dev/sr0 /mnt/cdrom"
echo "cd /mnt/cdrom"
echo "sudo sh VBoxLinuxAdditions.run"
echo "sudo reboot"
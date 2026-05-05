#!/usr/bin/env bash
set -e

echo "=== Acer Ryzen Linux Optimization Setup ==="

# 1. Update system
sudo apt update
sudo apt upgrade -y

# 2. Essential tools
sudo apt install -y \
  git curl wget build-essential \
  vim nano htop btop neofetch \
  lm-sensors psensor \
  linux-tools-common linux-tools-generic \
  linux-firmware fwupd \
  ufw preload

# 3. Remove TLP to avoid conflict with auto-cpufreq
sudo systemctl stop tlp 2>/dev/null || true
sudo systemctl disable tlp 2>/dev/null || true
sudo apt remove -y tlp tlp-rdw 2>/dev/null || true

# 4. Install auto-cpufreq properly
if ! command -v auto-cpufreq >/dev/null 2>&1; then
  cd /tmp
  git clone https://github.com/AdnanHodzic/auto-cpufreq.git
  cd auto-cpufreq
  sudo ./auto-cpufreq-installer
fi

sudo auto-cpufreq --install || true

# 5. Install AMD graphics/Vulkan support
sudo apt install -y \
  mesa-utils \
  mesa-vulkan-drivers \
  vulkan-tools \
  radeontop

# 6. Enable sensors
sudo sensors-detect --auto || true

# 7. Enable firewall
sudo ufw enable || true

# 8. Enable preload for faster app launch
sudo systemctl enable preload
sudo systemctl start preload

# 9. Enable zram for better 8GB RAM performance
sudo apt install -y zram-tools

sudo tee /etc/default/zramswap > /dev/null <<EOF
ALGO=zstd
PERCENT=50
PRIORITY=100
EOF

sudo systemctl restart zramswap || true

# 10. Clean system
sudo apt autoremove -y
sudo apt autoclean -y

echo "=== Setup completed ==="
echo "Reboot your laptop now:"
echo "sudo reboot"

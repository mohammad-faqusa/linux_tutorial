#!/usr/bin/env bash
set -e

echo "=== Installing aria2 ==="
sudo apt update
sudo apt install -y aria2

echo "=== Creating aria2 config directory ==="
mkdir -p "$HOME/.config/aria2"

echo "=== Writing aria2 config ==="
cat > "$HOME/.config/aria2/aria2.conf" <<EOF
# Basic speed settings
max-connection-per-server=16
split=16
min-split-size=1M

# Resume downloads
continue=true
always-resume=true

# Multiple downloads
max-concurrent-downloads=5

# Better performance
file-allocation=none
disk-cache=64M

# Retry settings
max-tries=10
retry-wait=5
timeout=60
connect-timeout=30

# Save downloads here by default
dir=$HOME/Downloads

# Cleaner terminal output
summary-interval=5
console-log-level=notice
EOF

echo "=== Testing aria2 installation ==="
aria2c --version | head -n 1

echo
echo "✅ aria2 installed and configured successfully."
echo
echo "Config file location:"
echo "$HOME/.config/aria2/aria2.conf"
echo
echo "Example usage:"
echo 'aria2c -x 16 -s 16 "https://example.com/file.iso"'
echo
echo "Or simply:"
echo 'aria2c "https://example.com/file.iso"'
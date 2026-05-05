#!/usr/bin/env bash
set -e

echo "=== Installing Git ==="
sudo apt update
sudo apt install -y git curl

echo "=== Setting global Git identity ==="
read -p "Enter your GitHub name: " GIT_NAME
read -p "Enter your GitHub email: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

echo "=== Setting default branch to main ==="
git config --global init.defaultBranch main

echo "=== Improving Git defaults ==="
git config --global core.editor "nano"
git config --global color.ui auto

echo "=== Generating SSH key ==="
read -p "Enter your GitHub email again for SSH key: " SSH_EMAIL

ssh-keygen -t ed25519 -C "$SSH_EMAIL" -f "$HOME/.ssh/id_ed25519" -N ""

echo "=== Starting SSH agent ==="
eval "$(ssh-agent -s)"

echo "=== Adding SSH key to agent ==="
ssh-add ~/.ssh/id_ed25519

echo "=== Copy your public key to GitHub ==="
echo
echo "👉 Go to: https://github.com/settings/keys"
echo "👉 Click: New SSH Key"
echo "👉 Paste the key below:"
echo
cat ~/.ssh/id_ed25519.pub
echo
echo "======================================"
echo "After adding the key, press ENTER..."
read

echo "=== Testing GitHub SSH connection ==="
ssh -T git@github.com || true

echo
echo "✅ GitHub setup complete!"
echo
echo "Now you can clone like this:"
echo 'git clone git@github.com:USERNAME/REPO.git'
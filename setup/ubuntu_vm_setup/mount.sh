sudo mkdir -p /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom || sudo mount /dev/sr0 /mnt/cdrom
cd /mnt/cdrom
sudo sh VBoxLinuxAdditions.run
sudo reboot
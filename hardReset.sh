#!/bin/bash
# Unmount server partition
umount -lf /server
# Format server partition (UBOOT 6)
yes | mkfs.ext4 /dev/mmcblk0p6
# Create tmpfs on OPT to not change opt folder files
mount -t tmpfs tmpfs /opt
cd /
# Mount and untar firmware to server folder
mount /dev/mmcblk0p6 /server
tar -xvf /mnt/overlay.tar --no-same-owner -C /
# Umount opt to get original opt. Rewrite version to old. For normally work online updating
umount /opt
mount -o remount,rw /
echo "1.0.20" >> /opt/FWVersion
mount -o remount,ro /
# Save all changes and reboot printer
sync
reboot

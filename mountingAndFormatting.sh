#!/bin/zsh

# this file is meant to be sourced, and then you have many functions with
# which to install arch

# this installs grub on /mnt/boot
function mountAndFormatBootPartition {
	mkfs.fat -F 32 $1
	mount $1 /mnt/boot
}


# https://www.atulhost.com/how-to-disable-or-enable-os-prober-from-the-grub
function mountAndFormatRootPartition {
	mkfs.ext4 $1
	mount $1 /mnt
 }


function generateFsTab {
	genfstab -U /mnt >> /mnt/etc/fstab
}

function bootAndRootSetup {
	rm -rf /mnt/etc/fstab
	mountAndFormatRootPartition $1
	mountAndFormatBootPartition $2
	genfstab -U /mnt >> /mnt/etc/fstab
}

echo "use bootAndRootSetup /path/to/root/partition /path/to/boot/partition"
echo "to format and mount a boot and root partition"


function bootRootAndSwapSetup {
	rm -rf /mnt/etc/fstab
	mountAndFormatRootPartition $1
	mountAndFormatBootPartition $2
	swapon $3
	genfstab -U /mnt >> /mnt/etc/fstab
}

echo "use bootRootAndSwapSetup /path/to/root/partition /path/to/boot/partition /path/to/swap/partition"
echo "to format and mount a boot, swap and root partition"

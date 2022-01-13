#########################################
# Christian's ArchLinux Install Scripts #
#  --updated 1.10.2022                  #
#########################################
#!/bin/bash
# ~/arch-install/init.sh
#
# initial disk setup
#


### Variables
source ${HOME}/arch-install/common/vars.sh

# Setting up variables for partions and mountpoints for system
if [[ ! -f /dev/nvme0n1 ]]; then
	export DEV_TYPE='/dev/sda'
else
	export DEV_TYPE='/dev/nvme0n1p' 
fi

export NEW_ROOT=${DEV_TYPE}3
export NEW_BOOT=${DEV_TYPE}1
export NEW_SWAP=${DEV_TYPE}2
export NEW_HOME=${DEV_TYPE}4

export MNT_ROOT_DIR=/mnt/arch
export MNT_BOOT_DIR=$MNT_ROOT_DIR/boot
export MNT_HOME_DIR=$MNT_ROOT_DIR/home


### Functions
source ${HOME}/arch-install/common/funcs.sh

# Unmounts disks if they exist 
unmounting () {
  	echo "Unmounting any mounted filesystem"
	echo ""
	sleep 1
  	if [[ -d /mnt/boot ]] || [[ -d /mnt/home ]]; then 
  		umount -vR /mnt 
  		swapoff -v /dev/sda2
	fi

  	if [[ -d /mnt/arch/boot ]] || [[ -d /mnt/arch/home ]]; then 
  		umount -vR /mnt/arch
  		swapoff -v /dev/sda2
  	fi
	sleep 3
}

# Cleans and backs up left over files
clean_up () {
	# Backing up mirrorlist
	echo "Backing up default pacman mirrors..."
	echo ""
	sleep 1
	cp -v /etc/pacman.d/mirrorlist $MNT_ROOT_DIR/etc/pacman.d/mirrorlist.original && 
	[[ -f $MNT_ROOT_DIR/etc/pacman.d/mirrorlist.original ]] ; outcome "$?" "Back Up"
	
	# Install scripts moved to new system
	echo "Copying install scripts to $MNT_ROOT_DIR/root"
	echo ""
	sleep 1
	cp -vr $ROOT_SCRIPT_DIR $MNT_ROOT_DIR/root
	[[ -d $MNT_ROOT_DIR/$ROOT_SCRIPT_DIR ]] ; outcome "$?" "Script Passing"
}

# arch-chroot's into target mount point
new_system_chroot () {
	echo "Chrooting into new system..."
	echo ""
	sleep 1
	arch-chroot $MNT_ROOT_DIR /bin/bash<<EOF
$ROOT_SCRIPT_DIR/$CHROOT_SCRIPT 
EOF
}

# User decides if partioning is needed script decides which disk
initial_setup () {
	# Disk unmounting
	echo "Unmounting partitions, if mounted"
	echo ""
	sleep 1
	unmounting ; outcome "$?" "Unmounting"

	# Creating mountpoint
	echo "Creating mountpoint if it doesn't exist"
	echo ""
	sleep 1
	[[ ! -d /mnt/arch ]] && mkdir -pv /mnt/arch
	
	echo "Do you need to launch fdisk for disk partioning? (y/N)"
	read keep_going
	echo ""
	sleep 1

	if [[ $keep_going == "y" ]]; then
		lsblk
		echo "Take note of the partion table you'll need it in the next steps."
		echo "Launching fdisk"
		sleep 3

		if [[ ! -f /dev/nvme0n1 ]]; then
			fdisk /dev/sda
		else
			fdisk /dev/nvme0n1
		fi
	else
		echo "Disk partioning skipped"
		echo ""
		sleep 1
	fi
	
	# user inputs desired mount point
	echo "Input mount point for root partition. [/mnt/arch]: "
	read user_mnt_root
	if [[ $user_mnt_root == "" ]]; then
		printf '\nKeeping default of '
	else
		export MNT_ROOT_DIR=$user_mnt_root
		printf '\nChanged to '
	fi
	printf '%s \n\n' $MNT_ROOT_DIR
	
	# user inputs desired disk
	echo "Input root partition. [/dev/sda3]: "
	read user_root
	if [[ $user_root == "" ]]; then
		printf '\nKeeping default of '
	else
		export NEW_ROOT=$user_root
		printf '\nChanged to '
	fi
	printf '%s \n\n' $NEW_ROOT

	# user inputs desired disk
	echo "Input boot partition. [/dev/sda1]: "
	read user_boot
	if [[ $user_boot == "" ]]; then
		printf '\nKeeping default of '
	else
		export $NEW_BOOT=$user_boot
		printf '\nChanged to '
	fi
	printf '%s \n\n' $NEW_BOOT

	# user inputs desired disk
	echo "Input swap partition. [/dev/sda2]: "
	read user_swap
	if [[ $user_swap == "" ]]; then
		printf '\nKeeping default of '
	else
		export $NEW_SWAP=$user_swap
		printf '\nChanged to '
	fi
	printf '%s \n\n' $NEW_SWAP

	# user inputs desired disk
	# checks if a home drive is needed
	echo "Will you have a seperate home partition? (y/N)"
	read -r keep_going

	if [[ $keep_going == "y" ]]; then
		echo "Input home partition. [/dev/sda4]: "
		read user_home
		if [[ $user_home == "" ]]; then
			printf '\nKeeping default of '
		else
			export $NEW_HOME=$user_home
			printf '\nChanged to '
		fi
		printf '%s \n\n' $NEW_HOME
	else
		echo "A home partition was not created."
		echo ""
		sleep 1
		unset NEW_HOME
	fi
}


# Writes new filesystems to partitions
create_filesystems () {
	echo "Creating systems filesystems"
	echo ""
	sleep 1

	# Root as ext4
	echo "Setting up root partition as an ext4 filesystem"
	echo ""
	sleep 1

	mkfs.ext4 -F -L root $NEW_ROOT ; outcome "$?" "mkfs.ext4"
	
	# Boot as FAT32
	echo "Setting up boot partition FAT32 filesystem"
	echo ""
	sleep 1

	mkfs.vfat -F32 -n BOOT $NEW_BOOT ; outcome "$?" "mkfs.vfat"
	
	# Swap
	echo "Running mkswap"
	echo ""
	sleep 1
	mkswap -L swap $NEW_SWAP ; outcome "$?" "mkswap"

	# Home as ext4
	if [[ -n $NEW_HOME ]]; then 
		echo "Setting up home partition as an ext4 filesystem"
		echo ""
		sleep 1
		mkfs.ext4 -F -L home $NEW_HOME ; outcome "$?" "mkfs.ext4"
	fi
}

# Menu calls the various *_setup functions
menu () {
  # Check to see which script to run
	# Calling the menu function
	echo "Choose disk layout and multi-boot..."
	echo ""
	sleep 1
  	echo "Are you:
  1) Wiping a disk? 
  2) Installing alongside another system?
  3) Continueing an install?
  q) Quitting "
  	read USE_CASE
  
  	# Menu case switch statement
  	case $USE_CASE in 
  	"1")
  		# Wipe everything
  		echo "Okay you are about to wipe the contents of your permenant storage device.
  Are you sure? (y/N)"
  		read -r keep_going
  		if [[ $keep_going == "y" ]]; then
			echo "Creating standard setup..."
			echo ""
  			sleep 1
			initial_setup ; outcome "$?" "PARTIONING"
  			create_filesystems ; outcome "$?" "FILESYSTEMS"
  		else 
  			echo "Rerun install.sh to startover. 
  Bye!"
  			sleep 3
  			exit 1
  		fi
  		;;
  	"2")
  		#  Choose which partion to use
  		echo "Okay, you are installing alongside an existing operating system. \
  Is this correct? (y/N) "
  		read -r keep_going
  		if [[ $keep_going == "y" ]]; then
  			echo "You will enter fdisk to repartion if needed. Then you will be asked where to mount '/', /home, and /boot.
  Default values will be displayed next to the prompts inside square brackets. foo prompt. [bar] "
  			sleep 1
  			multi_boot "$@" "A multi-boot setup"
  		else 
  			echo "Rerun install.sh to startover. 
  Bye! "
  			sleep 3
  			exit 1
  		fi
  		;;
  	"3")
  		# Choose where you want to start from
  		echo "NOT YET IMPLEMENTED Okay, there was an error and you would like to choose to start from a predefined point in the installation.
  Is this correct? (y/N)"
  		read -r keep_going
  		if [[ $keep_going == "y" ]]; then
  			echo "Continueing with the install script"
  			restart_point "$@"
  		else 
  			echo "Rerun install.sh to startover. 
  Bye!"
  			sleep 3
  			exit 1
  		fi
  		;;
  	"q")
  		echo "Rerun install.sh to startover. 
  Bye! "
  		sleep 3
  		exit 1
  		;;
  	"*") 
  		exit 1
  		;;
  	esac
}

prep_work () {
	echo "Mounting our newly created filesystems"
	echo ""
	sleep 1

	# Mounts root filesystem
	echo "Mounting root filesystem."
	echo ""
	sleep 1  
	mount -v $NEW_ROOT $MNT_ROOT_DIR ; outcome "$?" "Mounting $NEW_ROOT"

	# Creats boot mountpoint and mounts boot filesystem
	echo "Setting up and mounting boot directory" 
	echo "" 
	sleep 1
	mkdir -pv $MNT_BOOT_DIR 
	mount -v $NEW_BOOT $MNT_BOOT_DIR ; outcome "$?" "Mounting $NEW_BOOT"
	
	# Checks if NEW_HOME is set and mounts home filesystem
	if [[ -n $NEW_HOME ]]; then
		echo "Mounting /home drive"
		mkdir -pv $MNT_HOME_DIR 
		mount -v $NEW_HOME $MNT_HOME_DIR ; outcome "$?" "Mounting $NEW_HOME"
	else
		echo "Mounting /home isn't required"
	fi
	echo ""
	sleep 1

	# Initializes swapspace
	echo "Initializing swap space"
	echo ""
	sleep 1
	swapon -v $NEW_SWAP ; outcome "$?" "swapon"
}

initial_packages () {

	# Updating pacman repos and installing: 
		# base(-devel)
		# linux-zen kernel(-headers)
		# firmware 
		# git 
		# neovim 
		# pass 
		# openssh 
		# reflector
		# efibootmgr
		# dosfstools
		# iwd
		# rustup
		# openresolv
	
	echo "Installing initial software"
	echo ""
	sleep 1
	pacstrap $MNT_ROOT_DIR base linux linux-headers linux-firmware sccache git base-devel neovim reflector dosfstools efibootmgr iwd rustup openresolv intel-ucode rsync ;
	outcome "$?" "pacstrap"

	# Creating fstab on the new root filesystem
	echo "Creating /etc/fstab configuration file"
	echo ""
	sleep 1
	genfstab -t PARTUUID $MNT_ROOT_DIR >> $MNT_ROOT_DIR/etc/fstab 
	[[ -f $MNT_ROOT_DIR/etc/fstab ]] ; outcome "$?" "genfstab"
	cat $MNT_ROOT_DIR/etc/fstab
}


# Main function
main () {
	
  	# Greeting
  	echo ".Not/Very.X.CHRISTIAN.X.\Arch.Installer"
	echo ""
  	sleep 2
  	# Reminder to set up network
  	echo "Remember to set up network connection before continueing (wlan0 or wlp2s0)"
	echo ""
  	sleep 1
	
  	# Setup time
  	echo "Initializing propper date"
	echo ""
	sleep 1
  	timedatectl set-ntp true

  	menu ; outcome "$?" "DISK LAYOUT"
	prep_work ; outcome "$?" "MOUNT"
	initial_packages ; outcome "$?" "PACKAGES"
	clean_up ; outcome "$?" "CLEAN UP"
	new_system_chroot ; outcome "$?" "CHROOTING"
}

### Initialization

main 
outcome "$?" "INSTALLATION'"


# TODO: Installing alongside a
# multi_boot () {
# 	# call initial_setup	
# 	initial_setup ; outcome "$?" "Initial Setup"
# 
# 	# user inputs desired disk
# 	echo "Input root partition. [/dev/sda3]: "
# 	read user_root
# 	if [[ -z $user_root ]]; then
# 		printf "Keeping default: "
# 	else
# 		export NEW_ROOT=$user_root
# 		printf "Changed to: "
# 	fi
# 	printf $NEW_ROOT
# 	echo
# 	sleep 1
# 
# 	# Root as ext4
# 	echo "Setting up root partition as an ext4 filesystem"
# 	mkfs.ext4 -v -F -L root $NEW_ROOT ; outcome "$?" "mkfs.ext4"
# 	echo ""
# 
# 	# checks if a home drive is needed
# 	echo "Will you have a seperate home partition? (y/N)"
# 	read -r keep_going
# 
# 	if [[ $keep_going == "y" ]]; then
# 		echo "Input where your home drive is located"
# 		read user_home_drive
# 		echo "Your new /home filesystem will be located at "
# 		export NEW_HOME=$user_home_drive
# 		echo $NEW_HOME
# 		echo "Setting up home partition as an ext4 filesystem"
# 		mkfs.ext4 -v -F -L home $NEW_HOME ; outcome "$?" "mkfs.ext4"
# 	else
# 		echo "You deam it unnescessary to have a seperate home drive.
# The rest of the installation will assume this same thing"
# 		unset NEW_HOME
# 	fi
# 	echo ""
# 	sleep 1
# }

#!/bin/bash
#########################################
# Christian's ArchLinux Install Scripts #
#  --updated 1.10.2022                  #
#########################################
# ~/arch-install/chroot.sh
#
# chroot environment 
#   - root setup scripts
#

### Variables
source "${HOME}"/arch-install/common/vars.sh

### Functions
source "${HOME}"/arch-install/common/funcs.sh

# Setting up timezone
timezone () {
	echo "Linking timezone"
	ln -svf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
	[[ -f /etc/localtime ]] ; outcome "$?" "Timezone Setup'"
	sleep 1
}

# Setting up date and time
time_setup () {
	echo "Setting hwclock to system clock"
	hwclock --systohc
	sleep 1
}
	
# Setting up locale
locale_setup () {
	echo "Creating /etc/locale.gen file"
	cat > /etc/locale.gen <<EOF
en_US.UTF-8 UTF-8  
en_US ISO-8859-1  
EOF
	[[ -f /etc/locale.gen ]] ; outcome "$?" "Locale Setup"
	cat /etc/locale.gen
	echo ""
	sleep 1
	locale-gen &&
		echo "LANG=en_US.UTF-8" > /etc/locale.conf
	[[ -f /etc/locale.conf ]] ; outcome "$?" "Locale Generation'"
	cat /etc/locale.conf
	echo ""
	sleep 1
}
	
# Keymap
keymap_setup () {
	echo "Setting up keymaps"
	echo "KEYMAP=us" > /etc/vconsole.conf
	[[ -f /etc/vconsole.conf ]] ; outcome "$?" "Keymap Setup"
	cat /etc/vconsole.conf
	echo ""
	sleep 1
}
	
	
# Setting up hostname
hostname_setup () {
	echo "Creating /etc/hostname file"
	echo "lappy" > /etc/hostname
	[[ -f /etc/hostname ]] ; outcome "$?" "Hostname Setup"
	cat /etc/hostname
	echo ""
	sleep 1
}
	
# Setting up hosts
host_setup () {
	echo "Creating /etc/hosts file"
	cat > /etc/hosts << EOF
127.0.0.1	localhost
::1	localhost
127.0.1.1	lappy.home.network.net	lappy
EOF
	[[ -f /etc/hosts ]] ; outcome "$?" "Hosts Setup"
	cat /etc/hosts
	echo ""
	sleep 1
}
	
# Checking for reflector
mirrorlist_setup () {
	echo "Checking for reflector (mirror site url generator)"
	[[ ! -x /usr/bin/reflector ]] && echo "Oops, reflector not found. Installing reflector..." && pacman -S --no-confirm reflector || \
	echo "Reflector found." ;
	echo ""
	sleep 1
	
	# Updating mirros
	echo "Creating updated mirrorlist..."
	reflector -cUS --latest 3 --sort rate --save "/etc/pacman.d/mirrorlist"
	cat /etc/pacman.d/mirrorlist
	echo ""
	sleep 1
}
	
# Setting up wireless network access via iwd for internet acces on reboot
network_config () {
	echo "Checking for iwd config..."
	[[ ! -d /etc/iwd ]] && mkdir -pv /etc/iwd || echo "/etc/iwd exists"
	echo "Configuring iwd..."
	cat > /etc/iwd/main.conf << EOF
[General]
EnableNetworkConfiguration=true

[Network]
EnableIPv6=true
NameResolvingService=resolvconf
EOF
	[[ -f /etc/iwd/main.conf ]] ; outcome "$?" "Network Config"
	cat /etc/iwd/main.conf
	echo ""
	sleep 1
}
	
# Enabling network service
network_service () {
	echo "Enabling iwd to start on reboot and creating resolv.conf with openresolv..."
	systemctl enable iwd.service ; outcome "$?" "Network Setup"
}
	
# Settting up dns 
dns_setup () {
	resolvconf -u
	[[ -f /etc/resolv.conf ]] ; outcome "$?" "DNS Setup"
}
	
# Creating a user
user_creation () {
	user=$REG_USER
	echo "Creating the user $user" 
	useradd -G wheel,video,audio -s /bin/bash -m "$user" &&
	[[ -d /home/${user} ]] ; outcome "$?" "User Setup"
}
	
# Copying and changing ownership of user-me.sh
pass_scripts () {
	cp -rv "$ROOT_SCRIPT_DIR" "$REG_SCRIPT_DIR" &&
		chown -R -v "$REG_USER":"$REG_USER" "$REG_SCRIPT_DIR" &&
	  chmod -v +x "${REG_SCRIPT_DIR}/${USER_SCRIPT}"
	[[ -f "${REG_SCRIPT_DIR}/${USER_SCRIPT}" ]] ; outcome "$?" "Copying Scripts"
}
	
# Setting up wheel gorup to use sudo with no password
permission_setup () {
	echo "Edit sudoers file so we won't be frustrated later"
	export EDITOR="/usr/bin/nvim"
	chmod +w /etc/sudoers
	echo "%wheel	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
	chmod -w /etc/sudoers
	sleep 1
}
	
# Setting up UEFI stub bootloader with efibootmgr
bootloader () {
	echo "Adding stub loader for UEFI boot"
	efibootmgr -c --disk /dev/sda --part 1 --label "ARCH" --loader '\vmlinuz-linux' --unicode 'root=/dev/sda3 resume=/dev/sda2 rw initrd=\intel-ucode.img initrd=\initramfs-linux.img' --verbose
	sleep 1
}
	
# Switching to newly created user me
switch_user () {
	echo "Logging into my user and running the ~/user-me.sh executable..."
	sleep 1
	su --login me --command "${REG_SCRIPT_DIR}/${USER_SCRIPT}"
}
	
# Main function
main () {
	echo "CHROOT'ED ENVIRONMENT"
	cp -v /root/arch-install/sys-files/* /etc
	timezone ; outcome "$?" 'TIME'
	time_setup ; outcome "$?" 'TIME'
	locale_setup ; outcome "$?" 'LOCALE'
	keymap_setup ; outcome "$?" 'KEYMAP'
	hostname_setup ; outcome "$?" 'LOCAL NET'
	host_setup ; outcome "$?" 'LOCAL NET'
	mirrorlist_setup ; outcome "$?" 'MIRRORS'
	network_config ; outcome "$?" 'INTERNET'
	network_service ; outcome "$?" 'INTERNET'
	dns_setup ; outcome "$?" 'INTERNET'
	user_creation ; outcome "$?" 'USER'
	pass_scripts ; outcome "$?" 'USER'
	permission_setup ; outcome "$?" 'USER'
	permission_setup ; outcome "$?" 'USER'
	bootloader ; outcome "$?" 'BOOT'
	switch_user ; outcome "$?" 'SU'
}

# INIT

main

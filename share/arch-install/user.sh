#!/bin/bash
#########################################
# Christian's ArchLinux Install Scripts #
#  --updated 1.10.2022                  #
#########################################
# ~/arch-install/user.sh
#
# chroot enviornment 
#   - user setup script
#


### Variables

source "${HOME}"/arch-install/common/vars.sh
SCCACHE="/usr/bin/sccache"


### Functions

source "${HOME}"/arch-install/common/funcs.sh

exit_message () {
	if [ "$?" -eq 0 ]; then
		echo "Install Finished Successfully!"
		sleep 2

		printf "Huzzah! Hail Satan"
		sleep 1
		printf '.'
		sleep 1
		printf '.'
		sleep 1
		printf '.\n'
		sleep 1

		printf "Praise The Old Gods"
		sleep 1
		printf '.'
		sleep 1
		printf '.'
		sleep 1
		printf '.'
		sleep 1
		printf 'death to the Christians!!\n'
		sleep 2
		exit 0
	else
		printf 'Build failed fix script and start over'
		sleep 1
		printf '.'
		sleep 1
		printf '.'
		sleep 1
		printf '.'
		sleep 1
		printf ' duh\n'

	fi
}

push () {
	pushd "$1" || die ''
}	

pop () {
	popd || die ''
}	


get_dotfiles () {
	# Cloning config repo 
	echo "Checking for existing dotfiles"
	if [[ ! -f /home/$USER/.config/.git-add ]]; then
		echo "Local dotfile repo not found"
		echo "Cloning dotfiles from github..."

		git clone https://github.com/sorbetofbeef/dotfiles /home/"$USER"/.config  ; outcome "$?" "Cloning"
	else
		echo "Found dotfiles locally!" ; outcome "$?" "Cloning"
		sleep 1
	fi

	# Cloning data repo
	echo "Checking for existing data files"
	if [[ ! -f /home/$USER/.local/.git-add ]]; then
		echo "Local data files not found"
		echo "Cloning data files from github..."

		git clone https://github.com/sorbetofbeef/datafiles /home/$USER/.local  ; outcome "$?" "Cloning"
	else
		echo "Found data files locally!"
		sleep 1
	fi

	# Cloning document repo
	echo "Checking for existing document files"
	if [[ ! -f /home/$USER/docs/.git-add ]]; then
		echo "Local documents not found"
		echo "Cloning documents from github..."

		git clone https://github.com/sorbetofbeef/documents /home/$USER/docs ; outcome "$?" "Cloning" 
	else
		echo "Found documents locally!" ; outcome "$?" "Cloning"
		sleep 1
	fi
}

get_packages () {
	echo "Installing rusts default stable toolchain."
	rustup default stable ; outcome "$?" "Rust Installation"

	echo "Paru is the aur helper being used on the new system (man paru.conf)."
	if [[ ! -x /usr/bin/paru ]]; then
		echo "Cloning paru into dl/paru..." 
		git clone https://aur.archlinux.org/paru.git ~/dl/paru

		# Changing to /home/$USER/dl/paru
		push /home/$USER/dl/paru

		echo "Building paru..."
		makepkg -si --needed --noconfirm ; outcome "$?" "Building paru"

		pop
	else
		echo "Paru already made"  ; outcome "$?" "Cloning paru"
    echo ""
		sleep 1
	fi

  # Updating mirrorlist
  echo "Reflector is going to update our mirrolist"
  echo ""
  sleep 1
  sudo reflector -cUS --score 15 -l10 -f5 --save /etc/pacman.d/mirrorlist.new ; outcome "$?" "reflector"
  sudo mv -v /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old &&
  sudo mv -v /etc/pacman.d/mirrorlist.new /etc/pacman.d/mirrorlist ; outcome "$?" "Backing Up Mirrorlist"

	# Using paru to update and install a shit load of packages
	echo "Updating local repos, upgrading system, and installing packages"
	paru -Syu --needed --noconfirm acpi \
alsa-firmware \
alsa-plugins \
alsa-utils \
bash-completion \
ctags \
dbus-broker \
firefox \
foot \
github-cli \
go \
grim \
gst-libav \
gst-plugin-gtk \
gst-plugin-pipewire \
gst-plugins-bad \
gst-plugins-bad-libs \
gst-plugins-base \
gst-plugins-base-libs \
gst-plugins-good \
gst-plugins-ugly \
htop \
hunspell-en_us \
imv \
lf \
lazygit \
lm_sensors \
logrotate \
lsof \
lua-lanes \
luacheck \
lynx \
mako \
man-db \
man-pages \
pandoc \
pass \
pfetch \
plocate \
mpv \
neomutt \
newsboat \
nodejs \
noto-fonts-emoji \
nvim-packer-git \
opendoas \
openssh \
pacman-contrib \
python-pynvim \
slurp \
stylua \
swayidle \
terminus-font \
texinfo \
otf-font-awesome \
unace \
unrar \
unzip \
usbutils \
wget \
wireless-regdb \
xdg-user-dirs \
yarn \
zip \
zsh \
zsh-completions \
zsh-syntax-highlighting \
zsh-autosuggestions \
zsh-autopair-git ; outcome "$?" "Package Installation"


  RUSTC_WRAPPER=$SCCACHE cargo install fd-find 
  RUSTC_WRAPPER=$SCCACHE cargo install starship
  RUSTC_WRAPPER=$SCCACHE cargo install ripgrep
  RUSTC_WRAPPER=$SCCACHE cargo install exa
  RUSTC_WRAPPER=$SCCACHE cargo install bat
}

clean_up () {
	echo "Adding links and moving directories to where they belong..."
	echo ""
	sleep 1

  	echo "Checking if cargo is in the right place..."
  	if [ -d "/home/$USER/.cargo" ]; then
  	  cp -r /home/$USER/.cargo/* "/home/$USER/.local/share/cargo" && 
  	    rm -rf "/home/$USER/.cargo"
  	fi
  	sleep 1

  	echo "Checking if rustup is in the right place..."
  	if [ -d "/home/$USER/.rustup" ]; then
  	  cp -r /home/$USER/.rustup/* "/home/$USER/.local/share/rustup" && 
  	    rm -rf "/home/$USER/.rustup"
  	fi
  	sleep 1

  	echo "Checking if go is in the right place..."
  	[ -d "/home/$USER/go" ] && mv "/home/$USER/go" "/home/$USER/.local/share"
  	sleep 1

	echo "Linking zshrc and zprofile..."
	(ln -sfv /home/$USER/.config/zsh/zshrc /home/$USER/.config/zsh/.zshrc &&
		ln -sfv /home/$USER/.config/zsh/zprofile /home/$USER/.zprofile) ; outcome "$?" "Linking"

  	echo "Backing up various files..."
  	cp -r $REG_SCRIPT_DIR /home/$USER/.local/share
  	sudo cp -r $REG_SCRIPT_DIR / && rm -rf $REG_SCRIPT_DIR
}

password_reminder () {
  echo "Adding todo checklist to our startup build"
  echo ""

	cat > /home/$USER/OPEN_ME.txt << EOF
*TODO*
======

FOR AFTER BUILD
---------------
- [ ] Clone development repos
- [ ] Configure Neovim

FOR INSTALL SCRIPTS
-------------------
- [ ] INFERNAL BEEPING!!
- [ ] Add passwords to users
	- [ ] also chsh to fish
- [ ] Clone proper git dirs
- [ ] Debug changes in:
	- [X] init.sh
	- [X] chroot.sh
	- [X] user.sh
	- [ ] final passthrough
EOF

  sleep 1
}

main () {
	echo ""
	echo "Swapped to user: ${USER} at $(pwd)"
	echo ""
	sleep 1
	
	# Creating directories
	mkdir -pv dl github.com/sorbetofbeef

	get_dotfiles ; outcome "$?" "CONFIG"

	get_packages ; outcome "$?" "PACKAGES"

	# enable_services ; outcome "$?" "Services"
	
	clean_up ; outcome "$?" "CLEAN UP"

	password_reminder ; outcome "$?" "TODO"
}

### INITIALIZATION ###

main
exit_message


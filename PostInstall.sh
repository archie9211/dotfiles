#!/bin/bash
if [ -f /etc/debian_version ]; then
	echo "Debian/Ubuntu"
	sudo apt update
	sudo apt upgrade    
	sudo apt install docky
	sudo apt install gedit
	sudo apt install openvpn
	sudo apt install git
	sudo apt install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

elif [ -f /etc/arch-release ]; then
	echo "Arch Linux"
	sudo pacman -Syu reflector 
	sudo reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist 
	sudo pacman -Sy vim vlc tmux openssh gnome-tweaks julia git
	sudo systemctl enable sshd.service
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd -
	yay -S zsh google-chrome sublime-text-dev  
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	
	
# elif [ -f /etc/redhat-release ] || [ -f /etc/system-release-cpe ]; then
# 	echo "Red Hat / CentOS"
# elif [ -f /etc/SUSE-brand ] || [ -f /etc/SuSE-brand ] || [ -f /etc/SuSE-release ] || [ -d /etc/susehelp.d ]; then
# 	echo "SuSE"
# elif [ "$OPERATING_SYSTEM_TYPE" = "FreeBSD" ]; then
# 	echo "FreeBSD"
# elif [ "$OPERATING_SYSTEM_TYPE" = "OpenBSD" ]; then
# 	echo "OpenBSD"
# elif [ "$OPERATING_SYSTEM_TYPE" = "Cygwin" ]; then
# 	echo "Cygwin"
fi

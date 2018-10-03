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
	sudo pacman-mirrors -f && sudo pacman -Syy
	sudo pacman -Sy yaourt
	yaourt -Syyu --aur --noconfirm --force
	yaourt -s gedit
	yaourt -s docky
	yaourt -s zsh
	yaourt -s openvpn
	yaourt -s git
	yaourt -s google-chrome
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

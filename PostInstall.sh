#!/bin/bash
if [ -f /etc/debian_version ]; then
	echo "Debian/Ubuntu"
	sudo apt update
	sudo apt upgrade    
	sudo apt install git vim 
	#lets install chrome 
	rm -rf /etc/apt/sources.list.d/*chrome*
	rm -rf /etc/apt/*chrome*
	
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
	sudo apt-get update && sudo apt-get install google-chrome-stable
	sudo apt install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	mkdir "$HOME/.vim"
	curl -o "$HOME/.vim/vimrc" "https://raw.githubusercontent.com/archie9211/scripts/8fcfba08135823635112748dee14bb262214768b/vimrc"
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"



elif [ -f /etc/arch-release ]; then
	echo "Arch Linux"
	sudo pacman -Syu reflector 
	sudo reflector --country India --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist 
	sudo pacman -Sy vim vlc tmux openssh gnome-tweaks julia git cmake clang
#	sudo systemctl enable sshd.service
	git clone https://aur.archlinux.org/yay.git
	cd yay || exit
	makepkg -si
	cd - || exit
	yay -S zsh google-chrome sublime-text-dev  
	yay -S ttf-google-fonts-opinionated-git
	yay -S bibata-cursor-theme
	yay -S grub2-theme-archlinux
	yay -S vertex-themes 
	sudo pacman -S zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	mkdir "$HOME/.vim"
	curl -o "$HOME/.vim/vimrc" "https://raw.githubusercontent.com/archie9211/scripts/8fcfba08135823635112748dee14bb262214768b/vimrc"
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

fi

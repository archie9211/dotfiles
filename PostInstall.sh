#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

if [ -f /etc/debian_version ]; then
	echo "Debian/Ubuntu"
	whiptail --title "Linux Distro Init Setup" --checklist --separate-output "Please Select Items to install:" 20 78 15 \
	"1" "Do Update and Upgrade" on \
	"2" "Google Chrome"  off \
	"3" "zsh" on \
	"4" "oh my zsh" on \
	"5" "zsh-autosuggestions" on \
	"6" "zsh-syntax-highlighting" on \
	"7" "Custom .zshrc" on \
	"8" "vim" on \
	"9" "Custom vimrc" on \
	"10" "VIM PLUG" on 2>results

	hr="+-----------+------------+"
	echo "performing intial setup : Installing git and curl"
	echo "${hr}"
	echo "|  Program  |   Status   |"
	echo "${hr}"
	echo -ne "|  git      |${red}Installing..${reset}|\033[0K\r"
	sudo apt-get -y install git >> /tmp/scripts.log
	echo "|  git      |  ${green}Installed${reset} |"
	echo "${hr}"
	echo -ne "|  curl     |${red}Installing..${reset}|\033[0K\r"
	sudo apt-get -y install curl >> /tmp/scripts.log
	echo "|  curl     |  ${green}Installed${reset} |"
	echo "${hr}"

	while read choice
	do
		case $choice in
			1) 
				echo -ne "|  Update   |${red}Installing..${reset}|\033[0K\r"
				sudo apt-get -y update >> /tmp/scripts.log
				echo  "|  Update   | ${green}Completed${reset}  |"
				echo "${hr}"
				echo -ne "|  Upgrade  |${red}Installing..${reset}|\033[0K\r"
				sudo apt-get -y upgrade  >> /tmp/scripts.log 
				echo  "|  Upgrade  | ${green}Completed${reset}  |"
				echo "${hr}"

			;;
			2) 
				echo -ne "|Google Chrome|${red}Installing..${reset}|\033[0K\r"
				sudo rm -rf /etc/apt/sources.list.d/*chrome*
				sudo rm -rf /etc/apt/*chrome*
				
				wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - >> /dev/null
				echo -ne "|Google Chrome|${red}Installing..${reset}|\033[0K\r"

				sudo bash -c "echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list "
				sudo apt-get -y update  >> /tmp/scripts.log && sudo apt-get -y install google-chrome-stable >> /tmp/scripts.log
				echo  "|Google Chrome|${green}Installed${reset}   |"

			;;
			3) 
				echo -ne "|  zsh      |${red}Installing..${reset}|\033[0K\r"
				sudo apt-get -y install zsh >> /tmp/scripts.log
				echo "|  zsh      |  ${green}Installed${reset} |"
				echo "${hr}"

			;;
			4)
				echo -ne "| oh-my-zsh |${red}Installing..${reset}|\033[0K\r"
				if [ -f install.sh ];then mv install.sh install.bak; fi
				if [ -d .oh-my-zsh ];then
					if (whiptail --title "Warning" --yesno "Oh My ZSH is already installed. Do you want to reinstall :." 8 78); then
					    rm -rf $HOME/.oh-my-zsh					   
					fi
				fi
				wget -q https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh >> /tmp/scripts.log
				sed -i 's/RUNZSH=${RUNZSH:-yes}/RUNZSH=${RUNZSH:-no}/g' install.sh 
				bash install.sh >> /tmp/scripts.log
				rm install.sh
				
				if [ -f install.bak ];then mv install.sh.bak install.sh; fi
				echo "| oh-my-zsh |  ${green}Installed${reset} |"
				echo "${hr}"

			;;
			5)
				echo -ne "| auto-sugg |${red}Installing..${reset}|\033[0K\r"
				if [ -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ];then rm -rf "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ; fi
				git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions >> /tmp/scripts.log
				echo "| auto-sugg |  ${green}Installed${reset} |"
				echo "${hr}"

			;;
			6) 
				echo -ne "| syn-high  |${red}Installing..${reset}|\033[0K\r"
				if [ -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then rm -rf $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; fi
				git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting >> /tmp/scripts.log
				echo  "| syn-high  | ${green}Installed${reset}  |"
				echo "${hr}"
			;;
			7)
				echo -ne "| .zshrc   |${red}Installing..${reset}|\033[0K\r"
				mv $HOME/.zshrc $HOME/.zshrc.bak
				curl -so $HOME/.zshrc "https://raw.githubusercontent.com/archie9211/scripts/master/.zshrc" >> /tmp/scripts.log
				echo  "| .zshrc    | ${green}Installed${reset}  |"
				echo "${hr}"
			;;
			8)
				echo -ne "|  vim      |${red}Installing..${reset}|\033[0K\r"
				sudo apt-get install vim  >> /tmp/scripts.log

				echo "|  vim      | ${green}Installed${reset}  |"
				echo "${hr}"
			;;
			9)
				echo -ne "| .vimrc    |${red}Installing..${reset}|\033[0K\r"				
				curl -so "$HOME/.vim/vimrc" "https://raw.githubusercontent.com/archie9211/scripts/8fcfba08135823635112748dee14bb262214768b/vimrc" >> /tmp/scripts.log
				echo "| .vimrc    | ${green}Installed${reset}  |"
				echo "${hr}"
			;;

			10)
				echo -ne "|  vim plug |${red}Installing..${reset}|\033[0K\r"
				curl -fLso ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >> /tmp/scripts.log
				vim +'PlugInstall --sync' +qa 
				echo "|  vim plug | ${green}Installed${reset}  |"
				echo "${hr}"
			;;
			
			*)
			;;
			
		esac
	done < results

elif [ -f /etc/arch-release ]; then
	echo "Arch Linux"
	sudo pacman -Syu reflector 
	sudo reflector --country India --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist 
	sudo pacman -Sy vim vlc tmux openssh gnome-tweaks julia git cmake clang curl
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
	if [ -f install.sh ]; then
		mv install.sh install.bak
	fi
	wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	sed -i 's/RUNZSH=${RUNZSH:-yes}/RUNZSH=${RUNZSH:-no}/g' install.sh
	bash install.sh
	rm install.sh
	if [ -f install.bak];then mv install.sh.bak install.sh; fi	
	mkdir "$HOME/.vim"
	curl -o "$HOME/.vim/vimrc" "https://raw.githubusercontent.com/archie9211/scripts/8fcfba08135823635112748dee14bb262214768b/vimrc"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	mv $HOME/.zshrc $HOME/.zshrc.bak
	curl -o $HOME/.zshrc "https://raw.githubusercontent.com/archie9211/scripts/master/.zshrc"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +'PlugInstall --sync' +qa
fi

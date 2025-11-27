PWD=$(shell pwd)

.PHONY: debian
debian:
	sudo apt install aptitude
	sudo aptitude update
	sudo aptitude upgrade
	sudo aptitude install linux-image-amd64 linux-headers-amd64
	sudo aptitude install mesa-utils pipewire-v4l2 v4l2loopback-dkms v4l2loopback-utils curl wget \
		git git-lfs tree p7zip-full xz-utils zip unzip gzip bzip2 bzip3 7zip lzma vlc \
		vlc-plugin-pipewire pipewire-audio pipewire-jack pipewire-libcamera flameshot piper \
		pavucontrol-qt qt6-style-kvantum qt-style-kvantum-l10n qt-style-kvantum-themes vim \
		plasma-workspace-wallpapers
	sudo cp -f ${PWD}/10-xorg.conf /etc/X11/xorg.conf.d
	sudo cp -f ${PWD}/environment /etc
	sudo cp -f ${PWD}/local.conf /etc/fonts
	sudo cp -f ${PWD}/Xresources /etc/X11/Xresources
	sudo cp -f ${PWD}/apt.conf /etc/apt
	sudo cp -f ${PWD}/config/sddm/hidpi.conf /etc/sddm.conf.d
	sudo cp -f ${PWD}/config/sddm/kde_settings.conf /etc/sddm.conf.d
	sudo cp -fR ./assets/fonts/JetBrainsMono /usr/share/fonts
	sudo cp -fR ./assets/fonts/JetBrainsMonoNerd /usr/share/fonts
	sudo cp -fR ./assets/fonts/SF-Pro-Display /usr/share/fonts
	sudo cp -fR ./assets/fonts/Roboto /usr/share/fonts
	sudo cp -fR ./assets/fonts/RobotoMono /usr/share/fonts
	sudo cp -fR ./assets/fonts/Windows /usr/share/fonts
	sudo fc-cache -r
	sudo reboot

.PHONY: dotfiles
dotfiles:
#	ln -fns ${PWD}/config/flameshot ~/.config/flameshot
	ln -fns ${PWD}/bashrc ~/.bashrc
	ln -fns ${PWD}/gitconfig ~/.gitconfig

.PHONY: themes
themes:
	cd ~/Descargas; ssh-add ~/.ssh/github
	git clone git@github.com:vinceliuice/Layan-kde.git
	git clone git@github.com:vinceliuice/Layan-gtk-theme.git
	git clone git@github.com:vinceliuice/Tela-icon-theme.git
	Layan-kde/install.sh
	Layan-gtk-theme/install.sh
	Tela-icon-theme/install.sh
	rm -rf Layan-kde Layan-gtk-theme Tela-icon-theme

.PHONY: emacs
emacs:
	sudo aptitude install ripgrep fd-find shellcheck tidy sqlite3 libtool libtool-bin cmake gcc g++ gdb clang \
		clang-format clang-tidy clang-tools clangd make manpages-dev glslang-tools emacs
	rm -rf ~/.emacs.d;
	ln -fns ${PWD}/doom.d ~/.doom.d
	git clone https://github.com/doomemacs/doomemacs ~/.emacs.d
	~/.emacs.d/bin/doom install
	~/.emacs.d/bin/doom sync
	~/.emacs.d/bin/doom doctor

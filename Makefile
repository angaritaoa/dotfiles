PWD=$(shell pwd)

.PHONY: fedora
fedora:
	sudo dnf install --assumeyes \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(shell rpm -E %fedora).noarch.rpm
	sudo dnf update --refresh --assumeyes
	sudo dnf install --assumeyes libva-utils libva-v4l2-request vulkan fedora-workstation-repositories \
		mesa-libOpenCL curl wget git git-lfs coreutils tree p7zip xz bzip2 lzo lz4 lzma \
		pipewire-v4l2 v4l2loopback vlc vlc-core bash-completion kernel-tools google-chrome-stable \
		gnome-tweaks vim

.PHONY: fonts
fonts:
	sudo cp -fR ./assets/fonts/JetBrainsMono /usr/share/fonts
	sudo cp -fR ./assets/fonts/JetBrainsMonoNerd /usr/share/fonts
	sudo cp -fR ./assets/fonts/Roboto /usr/share/fonts
	sudo cp -fR ./assets/fonts/RobotoMono /usr/share/fonts
	sudo cp -fR ./assets/fonts/Windows /usr/share/fonts
	sudo fc-cache -r

.PHONY: awesome
awesome:
	mkdir -p ~/.config
	ln -fns ${PWD}/config/awesome ~/.config/awesome
	ln -fns ${PWD}/config/picom ~/.config/picom
	ln -fns ${PWD}/config/rofi ~/.config/rofi

.PHONY: dotfiles
dotfiles:
#	mkdir -p ~/.config
	sudo ln -fns ${PWD}/local.conf /etc/fonts/local.conf
#	sudo ln -fns ${PWD}/Xresources /etc/X11/Xresources
#	ln -fns ${PWD}/config/flameshot ~/.config/flameshot
	ln -fns ${PWD}/bashrc ~/.bashrc
	ln -fns ${PWD}/gitconfig ~/.gitconfig
#	ln -fns ${PWD}/../.ssh ~/.ssh

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
	sudo dnf install -y emacs git ripgrep fd-find ShellCheck tidy sqlite libtool cmake gcc g++ clang make \
		clang-tools-extra nodejs glslang
	rm -rf ~/.emacs.d;
	ln -fns ${PWD}/doom.d ~/.doom.d
	git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
	~/.emacs.d/bin/doom install
	~/.emacs.d/bin/doom sync
	~/.emacs.d/bin/doom doctor

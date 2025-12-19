PWD=$(shell pwd)

.PHONY: fedora
fedora:
	sudo dnf install --assumeyes \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(shell rpm -E %fedora).noarch.rpm
	sudo dnf update --refresh --assumeyes
	sudo dnf install --assumeyes libva-utils libva-v4l2-request vulkan fedora-workstation-repositories \
		mesa-libOpenCL curl wget git git-lfs coreutils tree p7zip xz bzip2 lzo lz4 lzma pipewire-v4l2 \
		v4l2loopback vlc vlc-core bash-completion kernel-tools google-chrome-stable gnome-tweaks vim
	sudo dnf remove --assumeyes zram-generator zram-generator-defaults
	sudo grubby --update-kernel=ALL --args="ipv6.disable=1"
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg
	sudo depmod -ae
	sudo reboot

.PHONE: systemd
systemd:
	systemctl --user enable --now ssh-agent.socket

.PHONY: dotfiles
dotfiles:
	sudo ln -fns ${PWD}/fontconfig/local.conf /etc/fonts/local.conf
#	ln -fns ${PWD}/config/flameshot ~/.config/flameshot
	ln -fns ${PWD}/bashrc ~/.bashrc
	ln -fns ${PWD}/gitconfig ~/.gitconfig
	ln -fns ${PWD}/profile ~/.profile
	mkdir -p ~/.config/foot && ln -fns ${PWD}/foot/foot.ini ~/.config/foot/foot.ini

.PHONY: fonts
fonts:
	sudo cp -fR /mnt/archivos/config/fonts/JetBrainsMono /usr/share/fonts
	sudo cp -fR /mnt/archivos/config/fonts/JetBrainsMonoNerd /usr/share/fonts
	sudo cp -fR /mnt/archivos/config/fonts/Roboto /usr/share/fonts
	sudo cp -fR /mnt/archivos/config/fonts/RobotoMono /usr/share/fonts
	sudo cp -fR /mnt/archivos/config/fonts/Windows /usr/share/fonts
	sudo fc-cache -r

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

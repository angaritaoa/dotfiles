PWD=$(shell pwd)

.PHONY: fedora
fedora:
	sudo dnf install --assumeyes \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(shell rpm -E %fedora).noarch.rpm
	sudo dnf upgrade --refresh --assumeyes
	sudo dnf remove --assumeyes \
		zram-generator zram-generator-defaults
	sudo dnf install --assumeyes \
		fedora-workstation-repositories curl wget git git-lfs coreutils tree \
		p7zip xz bzip2 lzo lz4 lzma vlc vlc-core bash-completion kernel-tools \
		google-chrome-stable gnome-tweaks vim niri foot mako waybar swaybg \
		swayidle pipewire-v4l2 v4l2loopback intel-media-driver libva libva-v4l2-request \
		libva-utils nvtop breeze-cursor-theme libheif-freeworld \
		playerctl brightnessctl
	sudo dnf swap ffmpeg-free ffmpeg --allowerasing
	sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
	sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo grubby --update-kernel=ALL --args="ipv6.disable=1"
#	sudo grubby --update-kernel=ALL --args="i915.force_probe=\!7d55"
#	sudo grubby --update-kernel=ALL --args="xe.force_probe=7d55"
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg
	sudo usermod -a -G input angaritaoa

.PHONY: debian
debian:
	sudo aptitude install \
		curl wget git coreutils tree p7zip xz-utils bash-completion vim foot mako-notifier waybar intel-media-va-driver-non-free \
		libva2 nvtop breeze-cursor-theme playerctl ffmpeg mesa-va-drivers gdm hyprland hyprland-qtutils hypridle hyprlock hyprpaper \
		hyprpicker

.PHONY: systemd
systemd:
#	ln -fns ${PWD}/systemd/swaybg.service ~/.config/systemd/user/swaybg.service
#	ln -fns ${PWD}/systemd/swayidle.service ~/.config/systemd/user/swayidle.service
#	systemctl --user daemon-reload
	systemctl --user enable --now ssh-agent.socket
#	systemctl --user add-wants niri.service mako.service
#	systemctl --user add-wants niri.service waybar.service
#	systemctl --user add-wants niri.service swaybg.service
#	systemctl --user add-wants niri.service swayidle.service

.PHONY: fonts
fonts:
	sudo cp -fR /mnt/archivos/config/fonts/Roboto /usr/share/fonts
	sudo cp -fR /mnt/archivos/config/fonts/JetBrainsMonoNerd /usr/share/fonts
	sudo cp -fR /mnt/archivos/config/fonts/Windows /usr/share/fonts
	sudo fc-cache -r

.PHONY: icons
icons:
	git clone git@github.com:vinceliuice/Tela-icon-theme.git
	Tela-icon-theme/install.sh
	rm -rf Tela-icon-theme

.PHONY: dotfiles
dotfiles:
	mkdir -p ~/.config/niri
	mkdir -p ~/.config/foot
	mkdir -p ~/.config/waybar
	mkdir -p ~/.config/fuzzel
	sudo ln -fns ${PWD}/fontconfig/local.conf /etc/fonts/local.conf
	ln -fns ${PWD}/bashrc ~/.bashrc
	ln -fns ${PWD}/gitconfig ~/.gitconfig
	ln -fns ${PWD}/profile ~/.profile
	ln -fns ${PWD}/niri/config.kdl ~/.config/niri/config.kdl
	ln -fns ${PWD}/foot/foot.ini ~/.config/foot/foot.ini
	ln -fns ${PWD}/waybar/config.jsonc ~/.config/waybar/config.jsonc
	ln -fns ${PWD}/waybar/style.css ~/.config/waybar/style.css
	ln -fns ${PWD}/fuzzel/fuzzel.ini ~/.config/fuzzel/fuzzel.ini

.PHONY: gnome
gnome:
	gsettings set org.gnome.desktop.interface clock-format '12h'
	gsettings set org.gnome.desktop.interface cursor-blink true
	gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
	gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
	gsettings set org.gnome.desktop.interface font-hinting 'full'
	gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
	gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
	gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
	gsettings set org.gnome.desktop.interface cursor-theme 'breeze_cursors'
	gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 12'
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
	gsettings set org.gnome.desktop.interface toolkit-accessibility false
	gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Roboto 11'
	gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'
	gsettings set org.gnome.desktop.interface enable-animations true
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
	gsettings set org.gnome.desktop.peripherals.mouse speed 0.0
	gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	gsettings set org.gnome.desktop.interface cursor-size 32
	gsettings set org.gnome.desktop.interface icon-theme 'Tela-dark'
	gsettings set org.gnome.desktop.wm.preferences audible-bell false

.PHONY: emacs
emacs:
	sudo dnf install --assumeyes \
		emacs git ripgrep fd-find ShellCheck tidy sqlite libtool cmake gcc g++ \
		clang make clang-tools-extra nodejs glslang
	rm -rf ~/.emacs.d
	ln -fns ${PWD}/doom.d ~/.doom.d
	git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
	source ~/.bashrc
	doom install
	doom sync
	doom doctor

#.PHONY: themes
#themes:
#	git clone git@github.com:vinceliuice/Layan-kde.git
#	git clone git@github.com:vinceliuice/Layan-gtk-theme.git
#	git clone git@github.com:vinceliuice/Tela-icon-theme.git
#	Layan-kde/install.sh
#	Layan-gtk-theme/install.sh
#	Tela-icon-theme/install.sh
#	rm -rf Layan-kde Layan-gtk-theme Tela-icon-theme

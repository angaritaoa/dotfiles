PWD=$(shell pwd)

.PHONY: pacstrap
pacstrap:
	pacstrap -K /mnt base linux linux-firmware-intel intel-ucode vim iwd xfsprogs

.PHONY: arch
arch:
	sudo pacman -S \
		curl wget git coreutils tree 7zip bash-completion vim niri foot mako waybar \
		swaybg swayidle swaylock intel-media-driver libva libva-utils nvtop adwaita-cursors \
		xcursor-vanilla-dmz playerctl ffmpeg mesa mesa-utils opencl-mesa gdm ttf-roboto \
		ttf-jetbrains-mono-nerd tela-circle-icon-theme-blue nautilus sushi dconf-editor \
		man-db man-pages-es texinfo tar less grep sed util-linux procps-ng file \
		vulkan-intel libvpl vpl-gpu-rt intel-gpu-tools fuzzel xdg-desktop-portal-gtk \
		xdg-desktop-portal-gnome xwayland-satellite xdg-user-dirs pipewirei pipewire-audio \
		pipewire-libcamera pipewire-alsa pipewire-pulse pipewire-v4l2 wireplumber \
		v4l2loopback-dkms v4l2loopback-utils linux-headers v4l-utils xdg-desktop-portal \
		xdg-desktop-portal-wlr grim flameshot
	echo "options i915 enable_guc=3" > /etc/modprobe.d/i915.conf
	mkinitcpio -P
	useradd -m -G log,wheel,proc,audio,disk,input,kvm,video -s /bin/bash angaritaoa
	passwd angaritaoa
	xdg-user-dirs-update
	sudo systemctl enable gdm.service

.PHONY: systemd
systemd:
	ln -fns ${PWD}/systemd/swaybg.service ~/.config/systemd/user/swaybg.service
	ln -fns ${PWD}/systemd/swayidle.service ~/.config/systemd/user/swayidle.service
	systemctl --user daemon-reload
	systemctl --user enable --now ssh-agent.socket
	systemctl --user add-wants niri.service mako.service
	systemctl --user add-wants niri.service waybar.service
	systemctl --user add-wants niri.service swaybg.service
	systemctl --user add-wants niri.service swayidle.service

.PHONY: fonts
fonts:
	sudo cp -fR /mnt/archivos/config/fonts/Windows /usr/share/fonts
	sudo fc-cache -r

.PHONY: dotfiles
dotfiles:
	mkdir -p ~/.config/{niri,foot,waybar}
	sudo ln -fns ${PWD}/fontconfig/local.conf /etc/fonts/local.conf
#	ln -fns ${PWD}/bashrc ~/.bashrc
	ln -fns ${PWD}/gitconfig ~/.gitconfig
	ln -fns ${PWD}/profile ~/.profile
	ln -fns ${PWD}/niri/config.kdl ~/.config/niri/config.kdl
	ln -fns ${PWD}/foot/foot.ini ~/.config/foot/foot.ini
	ln -fns ${PWD}/waybar/config.jsonc ~/.config/waybar/config.jsonc
	ln -fns ${PWD}/waybar/style.css ~/.config/waybar/style.css

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
	gsettings set org.gnome.desktop.interface cursor-theme 'Vanilla-DMZ'
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
	gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-blue-dark'
	gsettings set org.gnome.desktop.wm.preferences audible-bell false

.PHONY: emacs
emacs:
	sudo pacman -S \
		emacs-wayland git ripgrep fd shellcheck tidy sqlite libtool cmake gcc \
		clang make nodejs glslang
	rm -rf ~/.emacs.d
	ln -fns ${PWD}/doom.d ~/.doom.d
	git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
	source ~/.bashrc
	doom install
	doom sync
	doom doctor


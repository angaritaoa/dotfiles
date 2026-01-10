# ########################################################################################################
# colores                                                                                                #
# ########################################################################################################
GREEN               = \033[1;32m
BLUE                = \033[1;34m
YELLOW              = \033[1;33m
RED                 = \033[1;31m
CYAN                = \033[1;36m
RESET               = \033[1;0m

# ########################################################################################################
# variables                                                                                              #
# ########################################################################################################
SU                  = sudo
CP                  = cp -f
ECHO                = echo -e
OK                  = $(ECHO) "  [$(GREEN)OK$(RESET)]"
MKDIR               = mkdir -p
PWD                 = $(shell pwd)

# ########################################################################################################
# fontconfig                                                                                             #
# ########################################################################################################
USER_FONT_CONF      = fontconfig/local.conf
SYS_FONT_CONF       = /etc/fonts/local.conf

# ########################################################################################################
# bash                                                                                                   #
# ########################################################################################################
USER_BASH_RC        = bash/bashrc
SYS_BASH_RC         = ~/.bashrc
USER_PROFILE        = bash/profile
SYS_PROFILE         = ~/.profile

# ########################################################################################################
# git                                                                                                    #
# ########################################################################################################
SSH_DIR             = ~/.ssh
USER_GIT_CONF       = git/gitconfig
SYS_GIT_CONF        = ~/.gitconfig
USER_GIT_SSH        = /mnt/archivos/config/ssh/github
SYS_GIT_SSH         = ~/.ssh/github

# ########################################################################################################
# niri                                                                                                   #
# ########################################################################################################
NIRI_DIR            = ~/.config/niri
USER_NIRI_CONF      = niri/config.kdl
SYS_NIRI_CONF       = ~/.config/niri/config.kdl

# ########################################################################################################
# foot                                                                                                   #
# ########################################################################################################
FOOT_DIR            = ~/.config/foot
USER_FOOT_CONF      = foot/foot.ini
SYS_FOOT_CONF       = ~/.config/foot/foot.ini

# ########################################################################################################
# waybar                                                                                                 #
# ########################################################################################################
WAYBAR_DIR          = ~/.config/waybar
USER_WAYBAR_CONF    = waybar/config.jsonc
SYS_WAYBAR_CONF     = ~/.config/waybar/config.jsonc
USER_WAYBAR_CSS     = waybar/style.css
SYS_WAYBAR_CSS      = ~/.config/waybar/style.css

# ########################################################################################################
# swaylock                                                                                               #
# ########################################################################################################
SWAYLOCK_DIR        = ~/.config/swaylock
USER_SWAYLOCK_CONF  = swaylock/config
SYS_SWAYLOCK_CONF   = ~/.config/swaylock/config

# ########################################################################################################
# mako                                                                                                   #
# ########################################################################################################
MAKO_DIR            = ~/.config/mako
USER_MAKO_CONF      = mako/config
SYS_MAKO_CONF       = ~/.config/mako/config

# ########################################################################################################
# fuzzel                                                                                                 #
# ########################################################################################################
FUZZEL_DIR          = ~/.config/fuzzel
USER_FUZZEL_CONF    = fuzzel/fuzzel.ini
SYS_FUZZEL_CONF     = ~/.config/fuzzel/fuzzel.ini

# ########################################################################################################
# fuzzel                                                                                                 #
# ########################################################################################################
ROFI_DIR            = ~/.config/rofi
USER_ROFI_CONF      = rofi/config.rasi
SYS_ROFI_CONF       = ~/.config/rofi/config.rasi

# ########################################################################################################
# makefile                                                                                               #
# ########################################################################################################
.ONESHELL :

# ########################################################################################################
# fedora                                                                                                 #
# ########################################################################################################
.PHONY : fedora packages user systemd fonts images icons gnome gdm

fedora : packages user systemd fonts images icons gnome gdm

packages :
	@sudo dnf install --assumeyes \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(shell rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(shell rpm -E %fedora).noarch.rpm
	@sudo dnf upgrade --refresh --assumeyes
	@sudo dnf remove --assumeyes \
		zram-generator zram-generator-defaults
	@sudo dnf swap ffmpeg-free ffmpeg --allowerasing --assumeyes
	@sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld --assumeyes
	@sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin \
		--assumeyes
	@sudo dnf install --assumeyes \
		fedora-workstation-repositories curl wget git git-lfs coreutils tree p7zip xz bzip2 lzo lz4 lzma vlc \
		vlc-core bash-completion kernel-tools google-chrome-stable gnome-tweaks vim niri foot mako waybar \
		xwayland-satellite swaybg swayidle swaylock pipewire-v4l2 v4l2loopback intel-media-driver libva \
		libva-v4l2-request libva-utils nvtop breeze-cursor-theme libheif-freeworld playerctl brightnessctl \
		google-roboto-fonts google-roboto-mono-fonts jetbrains-mono-fonts adwaita-sans-fonts adwaita-mono-fonts \
		dconf-editor ripgrep bat fd-find drawing rofi

user :
	@sudo usermod -a -G input angaritaoa

systemd :
	@mkdir -p ~/.config/systemd/user
	@ln -fns $(PWD)/systemd/swaybg.service ~/.config/systemd/user/swaybg.service
	@ln -fns $(PWD)/systemd/swayidle.service ~/.config/systemd/user/swayidle.service
	@systemctl --user daemon-reload
	@systemctl --user enable --now ssh-agent.socket
	@systemctl --user add-wants niri.service mako.service
	@systemctl --user add-wants niri.service waybar.service
	@systemctl --user add-wants niri.service swaybg.service
	@systemctl --user add-wants niri.service swayidle.service

fonts :
	@sudo cp -fR /mnt/archivos/config/fonts/Windows /usr/share/fonts
	@sudo cp -fR /mnt/archivos/config/fonts/JetBrainsMonoNerd /usr/share/fonts
	@sudo cp -fR /mnt/archivos/config/fonts/RobotoMonoNerd /usr/share/fonts
	@sudo cp -fR /mnt/archivos/config/fonts/GeistMonoNerd /usr/share/fonts
	@sudo cp -fR /mnt/archivos/config/fonts/AdwaitaMono /usr/share/fonts
	@sudo cp -fR /mnt/archivos/config/fonts/NerdFontsSymbols /usr/share/fonts
	@sudo fc-cache -r

images :
	mkdir -p ~/.config/backgrounds
	cp -f /mnt/archivos/config/images/* ~/.config/backgrounds

icons :
	ssh-add /mnt/archivos/config/ssh/github
	git clone https://github.com/vinceliuice/Tela-icon-theme.git
	$(PWD)/Tela-icon-theme/install.sh
	rm -rf Tela-icon-theme

gnome :
	@gsettings set org.gnome.desktop.interface clock-format '12h'
	@gsettings set org.gnome.desktop.interface cursor-blink true
	@gsettings set org.gnome.desktop.interface document-font-name 'Adwaita Sans 10'
	@gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
	@gsettings set org.gnome.desktop.interface font-hinting 'full'
	@gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 10'
	@gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
	@gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
	@gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
	@gsettings set org.gnome.desktop.interface monospace-font-name 'Adwaita Mono 10'
	@gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
	@gsettings set org.gnome.desktop.interface toolkit-accessibility false
	@gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Adwaita Sans 10'
	@gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'
	@gsettings set org.gnome.desktop.interface enable-animations true
	@gsettings set org.gnome.desktop.interface clock-show-date true
	@gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
	@gsettings set org.gnome.desktop.peripherals.mouse speed 0.0
	@gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true
	@gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	@gsettings set org.gnome.desktop.interface cursor-size 32
	@gsettings set org.gnome.desktop.interface icon-theme 'Tela-dark'
	@gsettings set org.gnome.desktop.wm.preferences audible-bell false

gdm :
	sudo mkdir -p /etc/dconf/db/gdm.d
	sudo cp -f $(PWD)/gdm/scaling /etc/dconf/db/gdm.d
	sudo dconf update

# ########################################################################################################
# dotfiles                                                                                               #
# ########################################################################################################
.PHONY : dotfiles fontconfig bash git niri foot \
	waybar swaylock mako fuzzel rofi

dotfiles : fontconfig bash git niri foot waybar \
	swaylock mako fuzzel rofi

fontconfig : $(SYS_FONT_CONF)

$(SYS_FONT_CONF) : $(USER_FONT_CONF)
	@$(SU) $(CP) $(USER_FONT_CONF) $(SYS_FONT_CONF)
	@$(OK) "fontconfig"

$(USER_FONT_CONF) :

bash : $(SYS_BASH_RC) $(SYS_PROFILE)

$(SYS_BASH_RC) : $(USER_BASH_RC)
	@$(CP) $(USER_BASH_RC) $(SYS_BASH_RC)
	@$(OK) "bash: bashrc"

$(USER_BASH_RC) :

$(SYS_PROFILE) : $(USER_PROFILE)
	@$(CP) $(USER_PROFILE) $(SYS_PROFILE)
	@$(OK) "bash: profile"

$(USER_PROFILE) :

git: $(SYS_GIT_CONF) $(SYS_GIT_SSH)

$(SYS_GIT_CONF) : $(USER_GIT_CONF)
	@$(CP) $(USER_GIT_CONF) $(SYS_GIT_CONF)
	@$(OK) "git conf"

$(USER_GIT_CONF) :

$(SYS_GIT_SSH) : $(USER_GIT_SSH)
	@$(MKDIR) $(SSH_DIR)
	@$(CP) $(USER_GIT_SSH) $(SYS_GIT_SSH)
	@chmod 700 $(SSH_DIR)
	@chmod 600 $(SYS_GIT_SSH)
	@$(OK) "git ssh"

$(USER_GIT_SSH) :

niri : $(SYS_NIRI_CONF)

$(SYS_NIRI_CONF) : $(USER_NIRI_CONF)
	@$(MKDIR) $(NIRI_DIR)
	@$(CP) $(USER_NIRI_CONF) $(SYS_NIRI_CONF)
	@niri msg action load-config-file
	@$(OK) "niri"

$(USER_NIRI_CONF) :

foot : $(SYS_FOOT_CONF)

$(SYS_FOOT_CONF) : $(USER_FOOT_CONF)
	@$(MKDIR) $(FOOT_DIR)
	@$(CP) $(USER_FOOT_CONF) $(SYS_FOOT_CONF)
	@$(OK) "foot"

$(USER_FOOT_CONF) :

waybar : $(SYS_WAYBAR_CONF) $(SYS_WAYBAR_CSS)

$(SYS_WAYBAR_CONF) : $(USER_WAYBAR_CONF)
	@$(MKDIR) $(WAYBAR_DIR)
	@$(CP) $(USER_WAYBAR_CONF) $(SYS_WAYBAR_CONF)
	@systemctl --user restart waybar.service
	@$(OK) "waybar conf"

$(USER_WAYBAR_CONF) :

$(SYS_WAYBAR_CSS) : $(USER_WAYBAR_CSS)
	@$(MKDIR) $(WAYBAR_DIR)
	@$(CP) $(USER_WAYBAR_CSS) $(SYS_WAYBAR_CSS)
	@systemctl --user restart waybar.service
	@$(OK) "waybar css"

$(USER_WAYBAR_CSS) :

swaylock : $(SYS_SWAYLOCK_CONF)

$(SYS_SWAYLOCK_CONF) : $(USER_SWAYLOCK_CONF)
	@$(MKDIR) $(SWAYLOCK_DIR)
	@$(CP) $(USER_SWAYLOCK_CONF) $(SYS_SWAYLOCK_CONF)
	@$(OK) "swaylock"

$(USER_SWAYLOCK_CONF) :

mako : $(SYS_MAKO_CONF)

$(SYS_MAKO_CONF) : $(USER_MAKO_CONF)
	@$(MKDIR) $(MAKO_DIR)
	@$(CP) $(USER_MAKO_CONF) $(SYS_MAKO_CONF)
	@makoctl reload
	@$(OK) "mako"

$(USER_MAKO_CONF) :

fuzzel : $(SYS_FUZZEL_CONF)

$(SYS_FUZZEL_CONF) : $(USER_FUZZEL_CONF)
	@$(MKDIR) $(FUZZEL_DIR)
	@$(CP) $(USER_FUZZEL_CONF) $(SYS_FUZZEL_CONF)
	@$(OK) "fuzzel"

$(USER_FUZZEL_CONF) :

rofi : $(SYS_ROFI_CONF)

$(SYS_ROFI_CONF) : $(USER_ROFI_CONF)
	@$(MKDIR) $(ROFI_DIR)
	@$(CP) $(USER_ROFI_CONF) $(SYS_ROFI_CONF)
	@$(OK) "rofi"

$(USER_ROFI_CONF) :

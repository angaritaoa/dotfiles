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

# ########################################################################################################
# ssh                                                                                                    #
# ########################################################################################################
SSH_DIR             = ~/.ssh
USER_SSH_CONF       = ssh/config
SYS_SSH_CONF        = ~/.ssh/config

# ########################################################################################################
# git                                                                                                    #
# ########################################################################################################
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
# desktop                                                                                                #
# ########################################################################################################
DESKTOP_DIR         = ~/.local/share/applications
USER_POWEROFF_CONF  = desktop/poweroff.desktop
SYS_POWEROFF_CONF   = ~/.local/share/applications/poweroff.desktop
USER_REBOOT_CONF    = desktop/reboot.desktop
SYS_REBOOT_CONF     = ~/.local/share/applications/reboot.desktop
USER_NIRIQUIT_CONF  = desktop/niri.desktop
SYS_NIRIQUIT_CONF   = ~/.local/share/applications/niri.desktop

# ########################################################################################################
# environment                                                                                            #
# ########################################################################################################
ENV_DIR             = ~/.config/environment.d
USER_ENV_CONF       = systemd/user_env.conf
LOCAL_ENV_CONF      = ~/.config/environment.d/user_env.conf

# ########################################################################################################
# zed                                                                                                    #
# ########################################################################################################
ZED_DIR             = ~/.config/zed
ZED_THEME_DIR       = ~/.config/zed/themes
USER_ZED_CONF       = zed/settings.json
LOCAL_ZED_CONF      = ~/.config/zed/settings.json
USER_ZED_KEYMAP     = zed/keymap.json
LOCAL_ZED_KEYMAP    = ~/.config/zed/keymap.json
USER_ZED_THEME      = zed/themes/DoomOne.json
LOCAL_ZED_THEME     = ~/.config/zed/themes/DoomOne.json

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
	@sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
	@sudo dnf upgrade --refresh --assumeyes
	@sudo dnf remove --assumeyes \
		zram-generator zram-generator-defaults
	@sudo dnf swap ffmpeg-free ffmpeg --allowerasing --assumeyes
	@sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld --assumeyes
	@sudo sudo dnf swap mesa-vulkan-drivers mesa-vulkan-drivers-freeworld --allowerasing --assumeyes
	@sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin \
		--assumeyes
	@sudo dnf install --assumeyes \
		fedora-workstation-repositories curl wget git git-lfs coreutils tree p7zip xz bzip2 lzo lz4 lzma vlc \
		vlc-core bash-completion kernel-tools google-chrome-stable gnome-tweaks vim niri foot mako waybar \
		xwayland-satellite swaybg swayidle swaylock pipewire-v4l2 v4l2loopback intel-media-driver libva \
		libva-v4l2-request libva-utils nvtop breeze-cursor-theme libheif-freeworld playerctl brightnessctl \
		google-roboto-fonts google-roboto-mono-fonts jetbrains-mono-fonts adwaita-sans-fonts adwaita-mono-fonts \
		dconf-editor ripgrep bat fd-find drawing pipewire-plugin-vulkan vulkan-tools

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
	waybar swaylock mako fuzzel desktop env ssh zed

dotfiles : fontconfig bash git niri foot waybar \
	swaylock mako fuzzel desktop env ssh zed

fontconfig : $(SYS_FONT_CONF)

$(SYS_FONT_CONF) : $(USER_FONT_CONF)
	@$(SU) $(CP) $(USER_FONT_CONF) $(SYS_FONT_CONF)
	@$(OK) "fontconfig"

$(USER_FONT_CONF) :

bash : $(SYS_BASH_RC)

$(SYS_BASH_RC) : $(USER_BASH_RC)
	@$(CP) $(USER_BASH_RC) $(SYS_BASH_RC)
	@$(OK) "bash: bashrc"

$(USER_BASH_RC) :

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

desktop : $(SYS_POWEROFF_CONF) $(SYS_REBOOT_CONF) $(SYS_NIRIQUIT_CONF)

$(SYS_POWEROFF_CONF) : $(USER_POWEROFF_CONF)
	@$(MKDIR) $(DESKTOP_DIR)
	@$(CP) $(USER_POWEROFF_CONF) $(SYS_POWEROFF_CONF)
	@$(OK) "poweroff"

$(USER_POWEROFF_CONF) :

$(SYS_REBOOT_CONF) : $(USER_REBOOT_CONF)
	@$(MKDIR) $(DESKTOP_DIR)
	@$(CP) $(USER_REBOOT_CONF) $(SYS_REBOOT_CONF)
	@$(OK) "reboot"

$(USER_REBOOT_CONF) :

$(SYS_NIRIQUIT_CONF) : $(USER_NIRIQUIT_CONF)
	@$(MKDIR) $(DESKTOP_DIR)
	@$(CP) $(USER_NIRIQUIT_CONF) $(SYS_NIRIQUIT_CONF)
	@$(OK) "niriquit"

$(USER_NIRIQUIT_CONF) :

env : $(LOCAL_ENV_CONF)

$(LOCAL_ENV_CONF) : $(USER_ENV_CONF)
	@$(MKDIR) $(ENV_DIR)
	@$(CP) $(USER_ENV_CONF) $(LOCAL_ENV_CONF)
	@$(OK) "env"

$(USER_ENV_CONF) :

ssh: $(SYS_SSH_CONF)

$(SYS_SSH_CONF) : $(USER_SSH_CONF)
	@$(MKDIR) $(SSH_DIR)
	@$(CP) $(USER_SSH_CONF) $(SYS_SSH_CONF)
	@chmod 700 $(SSH_DIR)
	@chmod 600 $(SYS_SSH_CONF)
	@$(OK) "ssh"

$(USER_SSH_CONF) :

zed : $(LOCAL_ZED_CONF) $(LOCAL_ZED_KEYMAP) $(LOCAL_ZED_THEME)

$(LOCAL_ZED_CONF) : $(USER_ZED_CONF)
	@$(MKDIR) $(ZED_DIR)
	@$(CP) $(USER_ZED_CONF) $(LOCAL_ZED_CONF)
	@$(OK) "zed conf"

$(USER_ZED_CONF) :

$(LOCAL_ZED_KEYMAP) : $(USER_ZED_KEYMAP)
	@$(MKDIR) $(ZED_DIR)
	@$(CP) $(USER_ZED_KEYMAP) $(LOCAL_ZED_KEYMAP)
	@$(OK) "zed keymap"

$(USER_ZED_KEYMAP) :

$(LOCAL_ZED_THEME) : $(USER_ZED_THEME)
	@$(MKDIR) $(ZED_THEME_DIR)
	@$(CP) $(USER_ZED_THEME) $(LOCAL_ZED_THEME)
	@$(OK) "zed theme"

$(USER_ZED_THEME) :

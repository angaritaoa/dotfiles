# ########################################################################################################
# colores                                                                                               #
# ########################################################################################################
RESET   := \e[0m
BOLD    := \e[1m
BLACK   := \e[30m
RED     := \e[31m
GREEN   := \e[32m
YELLOW  := \e[33m
BLUE    := \e[34m
MAGENTA := \e[35m
CYAN    := \e[36m
WHITE   := \e[37m
GRAY    := \e[90m

# ########################################################################################################
# makefile                                                                                               #
# ########################################################################################################
.ONESHELL :
SILENT := >/dev/null 2>&1
OKRULE = @echo "[ $(GREEN)OK$(RESET) ] $(GRAY)$(notdir $@)$(RESET)"

# ########################################################################################################
# dotfiles                                                                                               #
# ########################################################################################################
RULESDOT := fontconfig bash kitty git env hyprland flameshot waybar aptitude
.PHONY : dotfiles $(RULESDOT)
dotfiles : $(RULESDOT)

# ########################################################################################################
# debian                                                                                                 #
# ########################################################################################################
RULESDEB := packages kernel user systemd fonts images gnome gdm vicinae
.PHONY : debian $(RULESDEB)
debian : $(RULESDEB)

packages :
	@sudo apt install -y aptitude $(SILENT)
	@sudo aptitude update $(SILENT)
	@sudo aptitude full-upgrade --assume-yes $(SILENT)
	@sudo aptitude install --assume-yes ffmpeg mesa-utils-bin mesa-vulkan-drivers curl git git-lfs \
        tree 7zip xz-utils bash-completion gnome-tweaks vim hyprland hyprland-guiutils foot waybar fuzzel \
        pipewire-v4l2 v4l2loopback-dkms v4l2loopback-utils intel-gpu-tools intel-media-va-driver-non-free \
        playerctl ripgrep fd-find papirus-icon-theme hyprpolkitagent rsync linux-headers-amd64 wl-clipboard \
        libinput-tools hyprpaper hypridle hyprlock hyprpolkitagent hyprshutdown flameshot mako-notifier \
        gradia $(SILENT)
	$(OKRULE)

kernel :
	@sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="video=DP-2:d i915.force_probe=!7d55 xe.force_probe=7d55 quiet"/' /etc/default/grub $(SILENT)
	@sudo update-grub $(SILENT)
	$(OKRULE)

user :
	@sudo usermod -a -G input angaritaoa $(SILENT)
	$(OKRULE)

systemd :
	@systemctl --user enable --now ssh-agent.socket $(SILENT)
	@systemctl --user enable --now hyprpolkitagent.service $(SILENT)
	$(OKRULE)

fonts :
	@sudo cp -fR /mnt/archivos/config/fonts/Windows /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/JetBrainsMonoNerd /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/JetBrainsMono /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/RobotoMonoNerd /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/GeistMonoNerd /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/AdwaitaMonoNerd /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/NerdFontsSymbols /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/Lilex /usr/share/fonts $(SILENT)
	@sudo fc-cache -r $(SILENT)
	$(OKRULE)

images :
	@mkdir -p ~/.config/backgrounds $(SILENT)
	@cp -f /mnt/archivos/config/images/* ~/.config/backgrounds $(SILENT)
	$(OKRULE)

gnome :
	@gsettings set org.gnome.desktop.interface clock-format '12h' $(SILENT)
	@gsettings set org.gnome.desktop.interface cursor-blink true $(SILENT)
	@gsettings set org.gnome.desktop.interface document-font-name 'Adwaita Sans 10' $(SILENT)
	@gsettings set org.gnome.desktop.interface font-antialiasing 'rgba' $(SILENT)
	@gsettings set org.gnome.desktop.interface font-hinting 'slight' $(SILENT)
	@gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 10' $(SILENT)
	@gsettings set org.gnome.desktop.interface font-rgba-order 'rgb' $(SILENT)
	@gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita' $(SILENT)
	@gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita' $(SILENT)
	@gsettings set org.gnome.desktop.interface monospace-font-name 'Lilex 9' $(SILENT)
	@gsettings set org.gnome.desktop.interface text-scaling-factor 1.5 $(SILENT)
	@gsettings set org.gnome.desktop.interface toolkit-accessibility false $(SILENT)
	@gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Adwaita Sans 10' $(SILENT)
	@gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close' $(SILENT)
	@gsettings set org.gnome.desktop.interface enable-animations true $(SILENT)
	@gsettings set org.gnome.desktop.interface clock-show-date true $(SILENT)
	@gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat' $(SILENT)
	@gsettings set org.gnome.desktop.peripherals.mouse speed 0.0 $(SILENT)
	@gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true $(SILENT)
	@gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' $(SILENT)
	@gsettings set org.gnome.desktop.interface cursor-size 32 $(SILENT)
	@gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' $(SILENT)
	@gsettings set org.gnome.desktop.wm.preferences audible-bell false $(SILENT)
	$(OKRULE)

gdm :
	@sudo mkdir -p /etc/dconf/db/gdm.d $(SILENT)
	@sudo mkdir -p /etc/dconf/profile $(SILENT)
	@sudo cp -f $(shell pwd)/gdm/scaling /etc/dconf/db/gdm.d $(SILENT)
	@sudo cp -f $(shell pwd)/gdm/gdm /etc/dconf/profile $(SILENT)
	@sudo dconf update $(SILENT)
	$(OKRULE)

vicinae :
	@curl -fsSL https://vicinae.com/install | bash -s -- --prefix ~/.local $(SILENT)
	$(OKRULE)

# ########################################################################################################
# fontconfig                                                                                             #
# ########################################################################################################
USER_FONT_CONF     := fontconfig/local.conf
SYS_FONT_CONF      := /etc/fonts/local.conf
fontconfig : $(SYS_FONT_CONF)

$(SYS_FONT_CONF) : $(USER_FONT_CONF)
	@sudo cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# bash                                                                                                   #
# ########################################################################################################
USER_BASH_RC       := bash/bashrc
SYS_BASH_RC        := ~/.bashrc
bash : $(SYS_BASH_RC)

$(SYS_BASH_RC) : $(USER_BASH_RC)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# kitty                                                                                                  #
# ########################################################################################################
USER_KITTY_CONF := kitty/kitty.conf
SYS_KITTY_CONF  := ~/.config/kitty/kitty.conf
kitty : $(SYS_KITTY_CONF)

$(SYS_KITTY_CONF) : $(USER_KITTY_CONF)
	@mkdir -p $(dir $@) $(SILENT)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# git                                                                                                    #
# ########################################################################################################
USER_GIT_CONF := git/gitconfig
SYS_GIT_CONF  := ~/.gitconfig
USER_GIT_SSH  := /mnt/archivos/config/ssh/github
SYS_GIT_SSH   := ~/.ssh/github
USER_SSH_CONF := ssh/config
SYS_SSH_CONF  := ~/.ssh/config
git : $(SYS_GIT_CONF) $(SYS_GIT_SSH) $(SYS_SSH_CONF)

$(SYS_GIT_CONF) : $(USER_GIT_CONF)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

$(SYS_GIT_SSH) : $(USER_GIT_SSH)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

$(SYS_SSH_CONF) : $(USER_SSH_CONF)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# env                                                                                                    #
# ########################################################################################################
USER_ENV_CONF := systemd/user_env.conf
SYS_ENV_CONF  := ~/.config/environment.d/user_env.conf
env : $(SYS_ENV_CONF)

$(SYS_ENV_CONF) : $(USER_ENV_CONF)
	@mkdir -p $(dir $@) $(SILENT)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# hyprland                                                                                               #
# ########################################################################################################
SRC_HYPR_DIR := hyprland
DES_HYPR_DIR := ~/.config/hypr
SRC_HYPR_ALL := $(wildcard $(SRC_HYPR_DIR)/*)
DES_HYPR_ALL := $(patsubst $(SRC_HYPR_DIR)/%,$(DES_HYPR_DIR)/%,$(SRC_HYPR_ALL))
hyprland : $(DES_HYPR_ALL)

$(DES_HYPR_DIR)/% : $(SRC_HYPR_DIR)/%
	@mkdir -p $(dir $@) $(SILENT)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# flameshot                                                                                              #
# ########################################################################################################
USER_FLAMESHOT_CONF = flameshot/flameshot.ini
SYS_FLAMESHOT_CONF = ~/.config/flameshot/flameshot.ini
flameshot : $(SYS_FLAMESHOT_CONF)

$(SYS_FLAMESHOT_CONF) : $(USER_FLAMESHOT_CONF)
	@mkdir -p $(dir $@) $(SILENT)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# hyprland                                                                                               #
# ########################################################################################################
SRC_WAYBAR_DIR := waybar
DES_WAYBAR_DIR := ~/.config/waybar
SRC_WAYBAR_ALL := $(wildcard $(SRC_WAYBAR_DIR)/*)
DES_WAYBAR_ALL := $(patsubst $(SRC_WAYBAR_DIR)/%,$(DES_WAYBAR_DIR)/%,$(SRC_WAYBAR_ALL))
waybar : $(DES_WAYBAR_ALL)

$(DES_WAYBAR_DIR)/% : $(SRC_WAYBAR_DIR)/%
	@mkdir -p $(dir $@) $(SILENT)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# aptitude                                                                                               #
# ########################################################################################################
USR_APT_CONF = aptitude/apt.conf
SYS_APT_CONF = /etc/apt/apt.conf
aptitude : $(SYS_APT_CONF)

$(SYS_APT_CONF) : $(USR_APT_CONF)
	@sudo cp -f $< $@ $(SILENT)
	$(OKRULE)

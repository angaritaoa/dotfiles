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
RULESDOT := fontconfig bash profile env git flameshot nvim aptitude
.PHONY : dotfiles $(RULESDOT)
dotfiles : $(RULESDOT)

# ########################################################################################################
# debian                                                                                                 #
# ########################################################################################################
RULESDEB := packages kernel user systemd fonts gnome gdm nautilus terminal
.PHONY : debian $(RULESDEB)
debian : $(RULESDEB)

packages :
	@sudo apt install -y aptitude $(SILENT)
	@sudo aptitude update $(SILENT)
	@sudo aptitude full-upgrade --assume-yes $(SILENT)
	@sudo aptitude install --assume-yes ffmpeg mesa-utils-bin mesa-vulkan-drivers git git-lfs \
        tree 7zip xz-utils bash-completion vim intel-gpu-tools intel-media-va-driver-non-free \
        ripgrep fd-find rsync linux-headers-amd64 libinput-tools fonts-adwaita-sans inotify-tools \
        xdg-user-dirs gnome-tweaks breeze-cursor-theme dconf-editor neovim flameshot blackbox-terminal \
	blackbox-themes libva-wayland2 vainfo papirus-icon-theme $(SILENT)
	$(OKRULE)

kernel :
	@sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="video=DP-2:d i915.force_probe=!7d55 xe.force_probe=7d55 xe.enable_psr=0 quiet"/' /etc/default/grub $(SILENT)
	@sudo update-grub $(SILENT)
	$(OKRULE)

user :
	@sudo usermod -a -G input angaritaoa $(SILENT)
	@xdg-user-dirs-update $(SILENT)
	$(OKRULE)

systemd :
	@systemctl --user enable --now ssh-agent.socket $(SILENT)
	$(OKRULE)

fonts :
	@sudo cp -fR /mnt/archivos/config/fonts/JetBrainsMono /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/NerdFontsSymbols /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/Lilex /usr/share/fonts $(SILENT)
	@sudo fc-cache -r $(SILENT)
	$(OKRULE)

gnome :
	@gsettings set org.gnome.desktop.interface clock-format '12h'
	@gsettings set org.gnome.desktop.interface cursor-blink true
	@gsettings set org.gnome.desktop.interface document-font-name 'Adwaita Sans 10'
	@gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
	@gsettings set org.gnome.desktop.interface font-hinting 'slight'
	@gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 10'
	@gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'
	@gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
	@gsettings set org.gnome.desktop.interface cursor-theme 'Breeze_Light'
	@gsettings set org.gnome.desktop.interface monospace-font-name 'Lilex 10'
	@gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
	@gsettings set org.gnome.desktop.interface toolkit-accessibility false
	@gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Adwaita Sans 10'
	@gsettings set org.gnome.desktop.wm.preferences button-layout 'menu:minimize,maximize,close'
	@gsettings set org.gnome.desktop.interface enable-animations true
	@gsettings set org.gnome.desktop.interface clock-show-date true
	@gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
	@gsettings set org.gnome.desktop.peripherals.mouse speed 0.0
	@gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true
	@gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	@gsettings set org.gnome.desktop.interface cursor-size 32
	@gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-blue'
	@gsettings set org.gnome.desktop.wm.preferences audible-bell false
	@gsettings set org.gnome.shell last-selected-power-profile 'performance'
	@gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Software.desktop']"
	@gsettings set org.gnome.desktop.input-sources mru-sources "[('xkb', 'us')]"
	@gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+altgr-intl')]"
	@gsettings set org.gnome.desktop.calendar week-start-day 'monday'
	@gsettings set org.gnome.desktop.interface clock-show-weekday true
	@gsettings set org.gnome.desktop.calendar show-weekdate true
	$(OKRULE)

gdm :
	@sudo mkdir -p /etc/dconf/db/gdm.d $(SILENT)
	@sudo mkdir -p /etc/dconf/profile $(SILENT)
	@sudo cp -f $(shell pwd)/gdm/scaling /etc/dconf/db/gdm.d $(SILENT)
	@sudo cp -f $(shell pwd)/gdm/gdm /etc/dconf/profile $(SILENT)
	@sudo dconf update $(SILENT)
	$(OKRULE)

nautilus :
	@gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
	@gsettings set org.gnome.nautilus.preferences click-policy 'single'
	$(OKRULE)

terminal :
	@gsettings set com.raggesilver.BlackBox context-aware-header-bar false
	@gsettings set com.raggesilver.BlackBox cursor-blink-mode 0
	@gsettings set com.raggesilver.BlackBox fill-tabs false
	@gsettings set com.raggesilver.BlackBox font 'Lilex 11'
	@gsettings set com.raggesilver.BlackBox notify-process-completion false
	@gsettings set com.raggesilver.BlackBox remember-window-size true
	@gsettings set com.raggesilver.BlackBox show-headerbar true
	@gsettings set com.raggesilver.BlackBox show-menu-button false
	@gsettings set com.raggesilver.BlackBox terminal-bell false
	@gsettings set com.raggesilver.BlackBox terminal-padding "(8, 8, 8, 8)"
	$(OKRULE)

## ghostty: https://siemprelisto.cl/tecnologias/ghostty/02-configuracion-basica/

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
# profile                                                                                                #
# ########################################################################################################
USR_ENV_RC       := bash/profile
SYS_ENV_RC       := ~/.profile
profile : $(SYS_ENV_RC)

$(SYS_ENV_RC) : $(USR_ENV_RC)
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
	@mkdir -p ~/.ssh $(SILENT)
	@cp -f $< $@ $(SILENT)
	@chmod 700 ~/.ssh $(SILENT)
	@chmod 600 $@ $(SILENT)
	$(OKRULE)

$(SYS_SSH_CONF) : $(USER_SSH_CONF)
	@mkdir -p ~/.ssh $(SILENT)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# neovim                                                                                                 #
# ########################################################################################################
USR_NVIM_LUA      := nvim/init.lua
SYS_NVIM_LUA      := ~/.config/nvim/init.lua
nvim : $(SYS_NVIM_LUA)

$(SYS_NVIM_LUA) : $(USR_NVIM_LUA)
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
# aptitude                                                                                               #
# ########################################################################################################
USR_APT_CONF = aptitude/apt.conf
SYS_APT_CONF = /etc/apt/apt.conf
aptitude : $(SYS_APT_CONF)

$(SYS_APT_CONF) : $(USR_APT_CONF)
	@sudo cp -f $< $@ $(SILENT)
	$(OKRULE)

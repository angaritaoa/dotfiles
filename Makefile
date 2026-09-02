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
OKRULE = @printf "[ $(GREEN)OK$(RESET) ] $(GRAY)$(notdir $@)$(RESET)\n"

# ########################################################################################################
# dotfiles                                                                                               #
# ########################################################################################################
RULESDOT := fontconfig bash profile env git flameshot nvim pacman ghostty
.PHONY : dotfiles $(RULESDOT)
dotfiles : $(RULESDOT)

# ########################################################################################################
# linux                                                                                                  #
# ########################################################################################################
RULESLIN := packages kernel user systemd fonts gnome gdm nautilus
.PHONY : linux $(RULESLIN)
linux : $(RULESLIN)

packages :
	@sudo pacman -Syu ffmpeg mesa mesa-utils git git-lfs tree 7zip bash-completion intel-npu-driver \
		libva-intel-driver libva-utils intel-gpu-tools ripgrep fd rsync libinput-tools \
		adwaita-fonts inotify-tools gnome-tweaks breeze-cursors dconf neovim flameshot ghostty \
		papirus-icon-theme vivaldi vivaldi-ffmpeg-codecs obsidian ttf-jetbrains-mono \
		ttf-nerd-fonts-symbols-mono
	$(OKRULE)

kernel :
	@sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="video=DP-2:d i915.force_probe=7d55 i915.enable_psr=0 xe.force_probe=!7d55 xe.enable_psr=0 quiet"/' /etc/default/grub $(SILENT)
	@sudo grub-mkconfig -o /boot/grub/grub.cfg $(SILENT)
	$(OKRULE)

user :
	@sudo usermod -a -G input angaritaoa $(SILENT)
	$(OKRULE)

systemd :
	@systemctl --user enable --now ssh-agent.socket $(SILENT)
	$(OKRULE)

fonts :
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
	@gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
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
#	@chsh -s /usr/bin/bash
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
# ghostty                                                                                                #
# ########################################################################################################
USER_GHOSTTY_CONF = ghostty/config.ghostty
SYS_GHOSTTY_CONF = ~/.config/ghostty/config.ghostty
ghostty : $(SYS_GHOSTTY_CONF)

$(SYS_GHOSTTY_CONF) : $(USER_GHOSTTY_CONF)
	@mkdir -p $(dir $@) $(SILENT)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)


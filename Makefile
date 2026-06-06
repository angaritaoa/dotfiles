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
RULESDOT := fontconfig bash git env aptitude plasma
.PHONY : dotfiles $(RULESDOT)
dotfiles : $(RULESDOT)

# ########################################################################################################
# debian                                                                                                 #
# ########################################################################################################
RULESDEB := packages kernel user systemd fonts themes icons
.PHONY : debian $(RULESDEB)
debian : $(RULESDEB)

packages :
	@sudo apt install -y aptitude $(SILENT)
	@sudo aptitude update $(SILENT)
	@sudo aptitude full-upgrade --assume-yes $(SILENT)
	@sudo aptitude install --assume-yes ffmpeg mesa-utils-bin mesa-vulkan-drivers git git-lfs \
        tree 7zip xz-utils bash-completion vim intel-gpu-tools intel-media-va-driver-non-free \
        ripgrep fd-find rsync linux-headers-amd64 libinput-tools fonts-adwaita-sans inotify-tools \
        qt-style-kvantum qt-style-kvantum-l10n qt-style-kvantum-themes tesseract-ocr-spa \
        xdg-user-dirs $(SILENT)
	$(OKRULE)

kernel :
	@sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="video=DP-2:d i915.force_probe=!7d55 xe.force_probe=7d55 quiet"/' /etc/default/grub $(SILENT)
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
	@sudo cp -fR /mnt/archivos/config/fonts/Windows /usr/share/fonts $(SILENT)
	@sudo cp -fR /mnt/archivos/config/fonts/Lilex /usr/share/fonts $(SILENT)
	@sudo fc-cache -r $(SILENT)
	$(OKRULE)

themes :
	@ssh-add /mnt/archivos/config/ssh/github $(SILENT)
	@git clone https://github.com/vinceliuice/Layan-kde.git $(SILENT)
	@$(shell pwd)/Layan-kde/install.sh $(SILENT)
	@rm -rf Layan-kde
	$(OKRULE)

icons :
	@ssh-add /mnt/archivos/config/ssh/github $(SILENT)
	@git clone https://github.com/vinceliuice/Tela-icon-theme.git $(SILENT)
	@$(shell pwd)/Tela-icon-theme/install.sh $(SILENT)
	@rm -rf Tela-icon-theme $(SILENT)
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
# aptitude                                                                                               #
# ########################################################################################################
USR_APT_CONF = aptitude/apt.conf
SYS_APT_CONF = /etc/apt/apt.conf
aptitude : $(SYS_APT_CONF)

$(SYS_APT_CONF) : $(USR_APT_CONF)
	@sudo cp -f $< $@ $(SILENT)
	$(OKRULE)

# ########################################################################################################
# plasma                                                                                                 #
# ########################################################################################################

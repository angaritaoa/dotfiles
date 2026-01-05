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
# dotfiles                                                                                               #
# ########################################################################################################
.ONESHELL :

.PHONY: dotfiles fontconfig bash git niri foot \
	waybar swaylock

dotfiles : fontconfig bash git niri foot waybar \
	swaylock

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
	@$(OK) "waybar conf"

$(USER_WAYBAR_CONF) :

$(SYS_WAYBAR_CSS) : $(USER_WAYBAR_CSS)
	@$(MKDIR) $(WAYBAR_DIR)
	@$(CP) $(USER_WAYBAR_CSS) $(SYS_WAYBAR_CSS)
	@$(OK) "waybar css"

$(USER_WAYBAR_CSS) :

swaylock : $(SYS_SWAYLOCK_CONF)

$(SYS_SWAYLOCK_CONF) : $(USER_SWAYLOCK_CONF)
	@$(MKDIR) $(SWAYLOCK_DIR)
	@$(CP) $(USER_SWAYLOCK_CONF) $(SYS_SWAYLOCK_CONF)
	@$(OK) "swaylock"

$(USER_SWAYLOCK_CONF) :

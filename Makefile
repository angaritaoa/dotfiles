# ########################################################################################################
# Colores                                                                                                #
# ########################################################################################################                                                                                               #
GREEN               = \033[1;32m
BLUE                = \033[1;34m
YELLOW              = \033[1;33m
RED                 = \033[1;31m
CYAN                = \033[1;36m
RESET               = \033[1;0m

# ########################################################################################################
# Variables                                                                                              #
# ########################################################################################################                                                                                               #
SU                  = sudo
CP                  = cp -f
ECHO                = echo -e
OK                  = $(ECHO) "  [$(GREEN)OK$(RESET)]"

# ########################################################################################################
# Fontconfig                                                                                             #
# ########################################################################################################                                                                                               #
USER_FONT_CONF      = fontconfig/local.conf
SYS_FONT_CONF       = /etc/fonts/local.conf

# ########################################################################################################
# Bash                                                                                                   #
# ########################################################################################################                                                                                               #
USER_BASH_RC        = bash/bashrc
SYS_BASH_RC         = ~/.bashrc
USER_PROFILE        = bash/profile
SYS_PROFILE         = ~/.profile

# ########################################################################################################
# Git                                                                                                    #
# ########################################################################################################                                                                                               #
USER_GIT_CONF       = git/gitconfig
SYS_GIT_CONF        = ~/.gitconfig

# ########################################################################################################
# Niri                                                                                                   #
# ########################################################################################################                                                                                               #
NIRI_DIR            = ~/.config/niri
USER_NIRI_CONF      = niri/config.kdl
SYS_NIRI_CONF       = ~/.config/niri/config.kdl

# ########################################################################################################
# Foot                                                                                                   #
# ########################################################################################################                                                                                               #
FOOT_DIR            = ~/.config/foot
USER_FOOT_CONF      = foot/foot.ini
SYS_FOOT_CONF       = ~/.config/foot/foot.ini

# ########################################################################################################
# Waybar                                                                                                 #
# ########################################################################################################                                                                                               #
WAYBAR_DIR          = ~/.config/waybar
USER_WAYBAR_CONF    = waybar/config.jsonc
SYS_WAYBAR_CONF     = ~/.config/waybar/config.jsonc
USER_WAYBAR_CSS     = waybar/style.css
SYS_WAYBAR_CSS      = ~/.config/waybar/style.css

# ########################################################################################################
# PHONY                                                                                                  #
# ########################################################################################################                                                                                               #
.PHONY: dotfiles fontconfig bash git niri foot \
	waybar

# ########################################################################################################
# dotfiles                                                                                               #
# ########################################################################################################                                                                                               #
dotfiles : fontconfig bash git niri foot waybar

fontconfig : $(SYS_FONT_CONF)

$(SYS_FONT_CONF) : $(USER_FONT_CONF)
	@$(SU) $(CP) $(USER_FONT_CONF) $(SYS_FONT_CONF)
	@$(OK) "Fontconfig"

$(USER_FONT_CONF) :

bash : $(SYS_BASH_RC) $(SYS_PROFILE)

$(SYS_BASH_RC) : $(USER_BASH_RC)
	@$(CP) $(USER_BASH_RC) $(SYS_BASH_RC)
	@$(OK) "Bash: bashrc"

$(USER_BASH_RC) :

$(SYS_PROFILE) : $(USER_PROFILE)
	@$(CP) $(USER_PROFILE) $(SYS_PROFILE)
	@$(OK) "Bash: profile"

$(USER_PROFILE) :

git: $(SYS_GIT_CONF)

$(SYS_GIT_CONF) : $(USER_GIT_CONF)
	@$(CP) $(USER_GIT_CONF) $(SYS_GIT_CONF)
	@$(OK) "Git"

$(USER_GIT_CONF) :

niri : $(SYS_NIRI_CONF)

$(SYS_NIRI_CONF) : $(USER_NIRI_CONF)
	@mkdir -p $(NIRI_DIR)
	@$(CP) $(USER_NIRI_CONF) $(SYS_NIRI_CONF)
	niri msg action load-config-file
	@$(OK) "Niri"

$(USER_NIRI_CONF) :

foot : $(SYS_FOOT_CONF)

$(SYS_FOOT_CONF) : $(USER_FOOT_CONF)
	@mkdir -p $(FOOT_DIR)
	@$(CP) $(USER_FOOT_CONF) $(SYS_FOOT_CONF)
	@$(OK) "Foot"

$(USER_FOOT_CONF) :

waybar : $(SYS_WAYBAR_CONF) $(SYS_WAYBAR_CSS)

$(SYS_WAYBAR_CONF) : $(USER_WAYBAR_CONF)
	@mkdir -p $(WAYBAR_DIR)
	@$(CP) $(USER_WAYBAR_CONF) $(SYS_WAYBAR_CONF)
	@$(OK) "Waybar CONF"

$(USER_WAYBAR_CONF) :

$(SYS_WAYBAR_CSS) : $(USER_WAYBAR_CSS)
	@mkdir -p $(WAYBAR_DIR)
	@$(CP) $(USER_WAYBAR_CSS) $(SYS_WAYBAR_CSS)
	@$(OK) "Waybar CSS"

$(USER_WAYBAR_CSS) :


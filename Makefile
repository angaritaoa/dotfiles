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
RULESDOT := zsh profile env git
.PHONY : dotfiles $(RULESDOT)
dotfiles : $(RULESDOT)

# ########################################################################################################
# zsh                                                                                                    #
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
# ghostty                                                                                                #
# ########################################################################################################
USER_GHOSTTY_CONF = ghostty/config.ghostty
SYS_GHOSTTY_CONF = ~/.config/ghostty/config.ghostty
ghostty : $(SYS_GHOSTTY_CONF)

$(SYS_GHOSTTY_CONF) : $(USER_GHOSTTY_CONF)
	@mkdir -p $(dir $@) $(SILENT)
	@cp -f $< $@ $(SILENT)
	$(OKRULE)


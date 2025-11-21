# #####################################################################################
#       __       _______   __        ______
#      /""\     /"     "| /""\      /    " \
#     /    \   (: ______)/    \    // ____  \   Copyright (c) 2020-2023 Andres Angarita
#    /' /\  \   \/    | /' /\  \  /  /    ) :)  https://github.com/angaritaoa
#   //  __'  \  // ___)//  __'  \(: (____/ //   Email: afao@icloud.com
#  /   /  \\  \(:  (  /   /  \\  \\        /
# (___/    \___)\__/ (___/    \___)\"_____/
#
# Mi configuración personalizada de Zsh. Para documentar comandos, alias y funciones
# #####################################################################################

# #####################################################################################
# Colores
# #####################################################################################
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
RESET=$(tput sgr0)
BOLD=$(tput bold)
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 15)

# #####################################################################################
# Variables de entorno generales
# #####################################################################################
# export PS1="%n@%m␣%1d ⌦ "
#export PS1="⌦ "
export EDITOR="emacsclient -t -a ''"              # $EDITOR use Emacs in terminal
export VISUAL="emacsclient -c -a emacs"           # $VISUAL use Emacs in GUI mode
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# #####################################################################################
# Configuración de rutas de directorios para busqueda de binarios
# #####################################################################################
[ -d ~/.emacs.d/bin ] && export PATH=~/.emacs.d/bin:$PATH
[ -d ~/.local/bin   ] && export PATH=~/.local/bin:$PATH
[ -d ~/.flutter/bin ] && export PATH=~/.flutter/bin:$PATH

# #####################################################################################
# Alias generales
# #####################################################################################
alias ..='cd ..'
alias ...='cd ../..'
#alias cda='cd /mnt/archivos'
#alias cdp='cd /mnt/archivos/projects'
alias grep='grep -ni --color=auto'
alias egrep='egrep -ni --color=auto'
alias fgrep='fgrep -ni --color=auto'
alias diff='diff --color=auto'
alias df='df -Th'
alias du='du -sh *'
alias free='free -ht'
alias src='source ~/.zshrc'

# #####################################################################################
# Cambiando ls por exa. Instalar el paquete: $ sudo dnf install exa
# #####################################################################################
#if [[ -x "$(command -v exa)" ]]; then
#   alias lc='exa -lU  --sort=created  --time-style=long-iso --color=always --group-directories-first'
#   alias lm='exa -lm  --sort=modified --time-style=long-iso --color=always --group-directories-first'
#   alias ls='exa -lm  --sort=size     --time-style=long-iso --color=always --group-directories-first'
#   alias la='exa -lma --sort=modified --time-style=long-iso --color=always --group-directories-first'
#   alias lt='exa -lmT --sort=name     --time-style=long-iso --color=always --group-directories-first'
#fi

alias lm='gls -ltrh  --color=always --time-style=long-iso --group-directories-first'
alias lc='gls -ltrh  --color=always --time-style=long-iso --group-directories-first --time=creation'
alias ls='gls -lSrh  --color=always --time-style=long-iso --group-directories-first'
alias la='gls -ltrha --color=always --time-style=long-iso --group-directories-first'
alias lt='tree --dirsfirst'

# #####################################################################################
# Alias para los comandos de git
# #####################################################################################
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch -av'
alias gc='git commit -m'
alias gl='git log --graph --pretty="format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset"'
alias gll='git log --pretty="format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset"'
alias gp='git push'
alias gf='git fetch'
alias gs='git status'


# Load Angular CLI autocompletion.
# source <(ng completion script)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GitHub
ssh-add ~/.ssh/github


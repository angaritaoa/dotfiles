# #####################################################################################
#       __       _______   __        ______
#      /""\     /"     "| /""\      /    " \
#     /    \   (: ______)/    \    // ____  \   Copyright (c) 2020-2025 Andres Angarita
#    /' /\  \   \/    | /' /\  \  /  /    ) :)  https://github.com/angaritaoa
#   //  __'  \  // ___)//  __'  \(: (____/ //   Email: angaritaoa@gmail.com
#  /   /  \\  \(:  (  /   /  \\  \\        /
# (___/    \___)\__/ (___/    \___)\"_____/
#
# Mi configuración personalizada de Bash. Para documentar comandos, alias y funciones
# #####################################################################################

# #####################################################################################
# Source global definitions
# #####################################################################################
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# #####################################################################################
# Colores
# #####################################################################################
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
export PS1='⌦ '
export EDITOR="emacsclient -t -a ''"              # $EDITOR use Emacs in terminal
export VISUAL="emacsclient -c -a emacs"           # $VISUAL use Emacs in GUI mode

# #####################################################################################
# Configuración de rutas de directorios para busqueda de binarios
# #####################################################################################
[ -d ~/.emacs.d/bin ] && export PATH=~/.emacs.d/bin:$PATH
[ -d ~/.local/bin   ] && export PATH=~/.local/bin:$PATH
[ -d ~/.flutter/bin ] && export PATH=~/.flutter/bin:$PATH

# #####################################################################################
# Para acceder al portapapeles del sistema operativo
# Instalar el paquete: $ sudo dnf install vim-X11
# #####################################################################################
if [ -x "$(command -v vimx)" ]; then
   alias vim='vimx'
   alias vi='vimx'
fi

# #####################################################################################
# Alias generales
# #####################################################################################
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep -ni --color=auto'
alias egrep='egrep -ni --color=auto'
alias fgrep='fgrep -ni --color=auto'
alias diff='diff --color=auto'
alias df='df -Th'
alias du='du -sh *'
alias free='free -ht'
alias src='source ~/.bashrc'

# #####################################################################################
# Cambiando ls por exa. Instalar el paquete: $ sudo dnf install exa
# #####################################################################################
#if [[ -x "$(command -v exa)" ]]; then
#   alias ls='exa -l   --sort=modified --time-style=long-iso --color=always --group-directories-first'
#   alias ll='exa -l   --sort=size     --time-style=long-iso --color=always --group-directories-first'
#   alias la='exa -la  --sort=modified --time-style=long-iso --color=always --group-directories-first'
#   alias lt='exa -lT  --sort=name     --time-style=long-iso --color=always --group-directories-first'
#fi

alias lm='ls -ltrh  --color=always --time-style=long-iso --group-directories-first'
alias lc='ls -ltrh  --color=always --time-style=long-iso --group-directories-first --time=creation'
alias ls='ls -lSrh  --color=always --time-style=long-iso --group-directories-first'
alias la='ls -ltrha --color=always --time-style=long-iso --group-directories-first'
alias lt='tree --dirsfirst'

# #####################################################################################
# Alias para los comandos de git
# #####################################################################################
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch -av'
alias gc='git commit -m'
alias gp='git push'
alias gf='git fetch'
alias gs='git status'

# GitHub
ssh-add ~/.ssh/github > /dev/null 2>&1

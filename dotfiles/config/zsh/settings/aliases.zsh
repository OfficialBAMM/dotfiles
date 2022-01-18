#!/usr/bin/zsh
alias ll='ls -lAh'

alias cs='cd ~/sites/'

alias mkx='chmod +x'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias debug="set -o nounset; set -o xtrace"

alias dh='dirs -v'
alias du='du -kh'
alias df='df -kTh'

alias vim='nvim'
alias v='nvim'
alias sv='sudo nvim'

alias gf='git fetch'
alias gc='git clone'
alias gs='git stash'
alias gb='git branch'
alias gm='git merge'
alias gch='git checkout'
alias gcm='git commit -m "'
alias glg='git log --stat'
alias gp='git push'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gd='git difftool'

alias pls='pacman -Ql'        # list files
alias pup='sudo pacman -Syyu' # update
alias pin='sudo pacman -S'    # install
alias pun='sudo pacman -Rs'   # remove
alias pcc='sudo pacman -Scc'  # clear cache
alias prm='sudo pacman -Rnsc' # really remove, configs and all

alias pkg='makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc'
alias spkg='makepkg --printsrcinfo > .SRCINFO && makepkg -fsrc --sign'
alias mk='make && make clean'
alias smk='sudo make clean install && make clean'
alias ssmk='sudo make clean install && make clean && rm -iv config.h'

alias rcp='rsync -v --progress'
alias rmv='rcp --remove-source-files'

alias calc='python -qi -c "from math import *"'
alias brok='sudo find . -type l -! -exec test -e {} \; -print'
alias timer='time read -p "Press enter to stop"'

# shellcheck disable=2142
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

alias y='yarn '
alias yd='yarn dev'
alias yi='yarn install'
alias yg='yarn generate'


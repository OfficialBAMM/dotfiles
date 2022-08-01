#!/bin/zsh
source ~/.config/zsh/zsh-plugins/zsh-snap/znap.zsh

# catch non-zsh and non-interactive shells
[[ $- == *i* && $ZSH_VERSION ]] && SHELL=/usr/bin/zsh || return 0

# add ~/bin to the path if not already, the -U flag means 'unique'
typeset -U path=($HOME/bin "${path[@]:#}")

# used internally by zsh for loading themes and completions
typeset -U fpath=("$ZDOTDIR/"{completion,themes} $fpath)

# initialize the prompt
autoload -U promptinit && promptinit

# source shell configuration files
for f in "$ZDOTDIR"/{settings,plugins}/*?.zsh; do
    . "$f" 2>/dev/null
done

# setup LS_COLORS
eval "$(dircolors -b)"

znap source marlonrichert/zsh-autocomplete

# load the prompt last
znap prompt simpl

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

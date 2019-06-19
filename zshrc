# This file is created automatically by dotfiles-installer script.
# Please don't make any changes here
# You can edit files in $ZSH_CUSTOM folders instead.
# We have provided you general.zsh, alias,zsh, looks.zsh, plugs.zsh in that folder for you to customize

# Using oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

# Termite SSH error workaround
if [[ "$TERM" == "xterm-termite" ]]; then
    export TERM=xterm-256color
fi

# Only check compinit's cache once a day
autoload -Uz compinit
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Added by COC Vim, include Node JS path
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Added by FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# This file is created automatically by dotfiles-installer script.
# Please don't make any changes here
# You can edit files in $HOME/.zsh folder instead.
# We have provided you general.zsh, alias,zsh, looks.zsh, plugs.zsh in that folder for you to customize
# To add your your own zplugin plugins, edit the file $HOME/.zshrc.bundles instead

# Load $HOME/.zshrc.before if exists
if [ -e "$HOME/.zshrc.before" ]; then
    source $HOME/.zshrc.before
fi

## Added by Zplugin's installer
source '/home/budiman/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

# Load oh-my-zsh's library
zplugin ice svn pick'/dev/null' multisrc'*.zsh'
zplugin snippet OMZ::lib

# Plugins
zplugin ice svn
zplugin snippet OMZ::plugins/vi-mode

zplugin ice wait atinit"zpcompinit; zpcdreplay" lucid
zplugin light zdharma/fast-syntax-highlighting

zplugin ice svn
zplugin snippet OMZ::plugins/history-substring-search

zplugin ice wait atload"_zsh_autosuggest_start" lucid
zplugin light zsh-users/zsh-autosuggestions

zplugin ice svn
zplugin snippet OMZ::plugins/tmux

# Theme
zplugin light romkatv/powerlevel10k

# Program
zplugin ice from"gh-r" as"program"
zplugin light junegunn/fzf-bin

zplugin ice svn pick"/dev/null" multisrc"{completion,key-bindings}.zsh"
zplugin snippet "https://github.com/junegunn/fzf/trunk/shell"

# Load custom plugins if exists
if [ -e "$HOME/.zshrc.bundles" ]; then
    source $HOME/.zshrc.bundles
fi

# Load $HOME/.zshrc.local if exists
if [ -e "$HOME/.zshrc.local" ]; then
    source $HOME/.zshrc.local
fi

# Load config files
for custom in $HOME/.zsh/*.zsh; do
    source "$custom"
done

# Added by COC Vim, include Node JS path
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Base16 Shell Colorscheme
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

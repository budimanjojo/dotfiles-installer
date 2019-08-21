# This file is created automatically by dotfiles-installer script.
# Please don't make any changes here
# You can edit files in $HOME/.zsh folder instead.
# We have provided you general.zsh, alias,zsh, looks.zsh, plugs.zsh in that folder for you to customize
# To add your your own antigen plugins, edit the file $HOME/.zshrc.bundles instead

# Load $HOME/.zshrc.before if exists
if [ -e "$HOME/.zshrc.before" ]; then
    source $HOME/.zshrc.before
fi

# Load antigen
source $HOME/.antigen/antigen.zsh

# Load oh-my-zsh's library
antigen use oh-my-zsh

# Plugins
antigen bundle vi mode
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle tmux

# Load custom plugins if exists
if [ -e "$HOME/.zshrc.bundles" ]; then
    source $HOME/.zshrc.bundles
fi

# Theme
antigen theme romkatv/powerlevel10k

# Done with antigen
antigen apply

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

# Added by FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Base16 Shell Colorscheme
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

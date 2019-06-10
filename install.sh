#!/bin/bash

# This script will install and configure ZSH, NEOVIM and Terminal colorscheme for you
# For Zsh, this script will add Powerlevel10k and Zsh-autosuggestions
# For Vim, this script will add Vim-easy-align, Vim-colorschemes, Base16-vim, Vim-airline, Nerdtree, Tcomment, Vim-fugitive, Emmet-vim, Ale, Coc.nvim,
# Vim-snippets, Fzf
# For Coc nvim, this script will add coc.json, coc-snippets, coc-pairs, coc-highlight, coc-tsserver, coc-tslint, coc-html, coc-css, coc-phpls, coc-stylelint,
# coc,vimlsp, coc-yaml
# For Terminal colorschemes, this script will add Base16-google-dark in your
# Xresources (for URXVT) and setup Gnome Terminal colors (if gnome-terminal is installed)

set -u

install_zsh=
install_vim=
install_xr=
source_dir="$(dirname $(readlink -f $0))"

colorme() {
    if [ -t 1 ]; then
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        BOLD=$(printf '\033[1m')
        RESET=$(printf '\033[m')
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        RESET=""
    fi
}
colorme

help() {
    printf "$BLUE"
    cat << EOF
usage: $0 [OPTIONS]

    --help                  Show this message
    --vim                   Include Vimrc with its plugins
    --zsh                   Include Zshrc with its plugins
    --color                 Include colorscheme for terminals
    --all                   Include Zshrc and Vimrc with their plugins
EOF
printf "$RESET"
}

success() {
    set +u
    printf "$YELLOW"
    cat << 'EOF'

                     ___  ___| |_ _   _ _ __
                    / __|/ _ \ __| | | | '_ \
                    \__ \  __/ |_| |_| | |_) |
                    |___/\___|\__|\__,_| .__/
                                       |_|
                 / _(_)_ __ (_)___| |__   ___  __| |
                | |_| | '_ \| / __| '_ \ / _ \/ _` |
                |  _| | | | | \__ \ | | |  __/ (_| |
                |_| |_|_| |_|_|___/_| |_|\___|\__,_|

EOF
    if [ ! -z "$summary_zsh" ]; then
        echo "   ${BOLD}Your Zsh setup is done. You can now run zsh or restart your"
        echo "               ${BOLD}terminal to try your new shell!"
    fi
    if [ ! -z "$summary_vim" ]; then
        echo "              ${BOLD}Your Vim setup is done. Enjoy it!"
    fi
    if [ ! -z "$summary_xr" ]; then
        echo "  ${BOLD}You have successfully configured your terminal colorschemes."
        echo "             ${BOLD}Restart you terminal and try it out!"
    fi
    printf "$RESET"
}

for opt in "$@"; do
    case $opt in
        --help)
            help
            exit 0
            ;;
        --vim)
            install_vim=1
            ;;
        --zsh)
            install_zsh=1
            ;;
        --color)
            install_xr=1
            ;;
        --all)
            install_vim=1
            install_zsh=1
            install_xr=1
            ;;
        *)
            error "unknown option: $opt"
            help
            exit 1
            ;;
    esac
done

log() {
    echo "${GREEN}$@${RESET}" 1>&2
}

error() {
    echo "${RED}Error: $@${RESET}" 1>&2
}
ask() {
  while true; do
    read -p "$1 ([y]/n) " -r
    REPLY=${REPLY:-"y"}
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      return 1
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
      return 0
    else
      log "Type y or n to continue."
    fi
  done
}

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

backup_file() {
    log "Backing up $1."
    mv "$1" "$1"-"$(date +%y-%m-%d_%H-%M-%S)"
    echo "${BLUE}$1 backed up as "$1"-"$(date +%y-%m-%d_%H-%M-%S)"${RESET}"
}

change_shell() {
    set +u
    if [ "$(basename "$SHELL")" = "zsh" ]; then
        return
    fi
    if ! command_exists chsh; then
        error "Chsh is not installed. Could not set your default shell to Zsh, please do it manually."
        return
    fi
    log "Switching Shell to ZSH..."
    if [ -f /etc/shells ]; then
        shells_file=/etc/shells
    elif [ -f /usr/share/defaults/etc/shells ]; then
        shells_file=/usr/share/defaults/etc/shells
    else
        error "Could not find /etc/shells file. Could not set your default shell to Zsh, please do it manually."
        return
    fi
    if ! zsh=$(which zsh) || ! grep -qx "$zsh" "$shells_file"; then
        if ! zsh=$(grep '^/.*/zsh$' "$shells_file" | tail -1) || [ ! -f "$zsh" ]; then
            error "No zsh binary found or not present in '$shells_file'. Could not set your default shell to Zsh, please do it manually."
            return
        fi
    fi
    if ! chsh -s "$zsh"; then
        error "chsh command unsuccessful. Change your default shell manually."
    else
        export SHELL="$zsh"
        log "Shell successfully changed to zsh."
    fi
}

setup_zsh() {
    if ! command_exists zsh; then
        error "Zsh is not installed. Please install zsh first."
        exit 1
    fi
    if ! command_exists ag; then
        error "Ag is not installed. Please install ag first"
        exit 1
    fi
    # to be done
    old_zshrc="$HOME/.zshrc"
    if [ -f "$old_zshrc" ]; then
        backup_file $old_zshrc
    fi
    log "Installing Oh-my-zsh"
    if ! command_exists git; then
        error "Git is not installed. Please install git first."
        exit 1
    fi
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        git clone --depth=1 --branch master https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" || {
            error "Git clone of oh-my-zsh repo failed, check your connection or try again later."
            exit 1
        }
    fi
   ZSH_CUSTOM="${ZSH_CUSTOM:-"$HOME/.oh-my-zsh/custom"}"
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        log "Installing Zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || {
            error "Git clone of zsh-autosuggestions repo failed, check your connection or try again later."
            exit 1
        }
    fi
    if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
        log "Installing Powerlevel10k"
        git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" || {
            error "Git clone of zsh-autosuggestions repo failed, check your connection or try again later."
            exit 1
        }
    fi
    log "Linking new .zshrc file"
    ln -sf "$source_dir/zshrc" "$old_zshrc"
    change_shell
}

setup_vim() {
    if ! command_exists vim nvim; then
        error "Vim or Neovim is not installed. Please install Vim or Neovim first."
        exit 1
    fi
    if ! command_exists node; then
        error "Nodejs is not installed. Please install Nodejs first."
        exit 1
    fi
    if command_exists vim; then
        old_vimrc="$HOME/.vimrc"
    fi
    if command_exists nvim; then
        if [ ! -z "$XDG_CONFIG_HOME" ]; then
            old_nvimrc="$XDG_CONFIG_HOME/nvim/init.vim"
        else
            old_nvimrc="$HOME/.config/nvim/init.vim"
        fi
    fi
    if [ -f "$old_vimrc" ]; then
        backup_file $old_vimrc
    fi
    if [ -f "$old_nvimrc" ]; then
        backup_file $old_nvimrc
    fi
    old_vimdir="$HOME/.vim"
    if [ -d "$old_vimdir" ]; then
        backup_file $old_vimdir
    fi
    log "Installing Vim-plug Plugin Manager"
    if ! command_exists curl; then
        error "Curl is not installed. Please install curl first."
        exit 1
    fi
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || {
        error "Failed to download and install vim-plug, check your connection or try again later."
        exit 1
    }
    yarn_dir="$HOME/.yarn"
    if [ -d "$yarn_dir" ]; then
        backup_file $yarn_dir
    fi
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
    log "Linking new .vimrc file"
    if command_exists nvim; then
        log "Linking new .nvimrc file"
        ln -sf "$source_dir/nvim/init.vim" "$old_nvimrc"
    fi
    ln -s "$source_dir/vimrc" "$old_vimrc"
    log "Installing Plugins"
    vim +PlugInstall +qall
    log "Installing COC vim"
    vim -c ":CocInstall -sync coc-json coc-snippets coc-pairs coc-highlight coc-tsserver coc-tslint coc-html coc-css coc-phpls coc-stylelint coc-vimlsp coc-yaml" -c ":qall"
}

setup_xr() {
    if [ -f $HOME/.Xresources ]; then
        if ! command_exists xrdb; then
            error "Xrdb is not installed. Please install xrdb first."
            exit 1
        fi
        ln -sf "$source_dir/Xresources" "HOME/.Xresources-base16."
        line='#include ".Xresources-base16"'
        log "$line" >> "$HOME/.Xresources"
        xrdb -merge "$HOME/Xresources-base16"
        log "Base16 Google Dark colorscheme is now loaded for URXVT or XTERM."
    else
        error "You don't have .Xresources file in $HOME. Skipping Xresources colorscheme setup."
    fi
    if command_exists gnome-terminal; then
        log "Setting up Gnome Terminal color scheme."
        if ! command_exists git; then
            error "Git is not installed. Please install git first."
            exit 1
        fi
        git clone https://github.com/aaron-williamson/base16-gnome-terminal.git "$HOME/base16-gnome-terminal" && "$HOME/base16-gnome-terminal/color-scripts/base16-google-dark-256.sh" || {
            error "Git clone of base16-gnome-terminal repo failed, check your connection or try again later."
            exit 1
        }
        log "Gnome terminal colorscheme installed, in your Gnome terminal Preferences, select Base16 Google Dark as the default profile."
        log "Cleaning up unused dir..."
        rm -rf "$HOME/base16-gnome-terminal"
    else
        error "You don't have Gnome terminal installed. Skipping Gnome terminal colorscheme setup."
    fi
}

if [ -z "$install_zsh" ]; then
    ask "Do you want to install Oh-My-Zsh with its plugins?"
    install_zsh=$?
fi

if [ -z "$install_vim" ]; then
    ask "Do you want to setup Vim with its plugins?"
    install_vim=$?
fi

if [ -z "$install_xr" ]; then
    ask "Do you want to setup terminal colors?"
    install_xr=$?
fi

# Setup oh-my-zsh
if [ "$install_zsh" -eq 1 ]; then
    log "Setting up Zsh..."
    setup_zsh
    summary_zsh=1
fi

# Setup vim
if [ "$install_vim" -eq 1 ]; then
    log "Setting up Vim or Neovim..."
    setup_vim
    summary_vim=1
fi

# Setup Xresources
if [ "$install_xr" -eq 1 ]; then
    log "Setting up Colorscheme..."
    setup_xr
    summary_xr=1
fi

success

les-installer
This repository contains my install script to configure my dotfiles. So I can just run the install script in my computer and I should get the unified looks in my terminals across machines. Please note that this is just my own personal dotfiles. You can use your own zshrc and vimrc by replacing yours with mine and run the install script.
In the future, maybe I will make this customizable for custom changes, but that's when I'm free and not guaranteed. I may not even look at this README again after setting up all my machines.
## Screenshots
Zsh prompt
![screenshot-2019-06-12_01-05-09](https://user-images.githubusercontent.com/13085918/59295937-0acec800-8caf-11e9-94ed-c88c5703e963.png)
Vim
![screenshot-2019-06-12_01-07-25](https://user-images.githubusercontent.com/13085918/59295949-0dc9b880-8caf-11e9-8617-e4310db78f84.png)
I use Base16-Google-Dark for everything. So you will have the same looks in your Zsh and Vim (You also need to install the Base16-Google-Dark colorscheme for your terminal too if you're not using Gnome-terminal/URxvt/Xterm)
## Dependencies
You need to have these packages installed in your system if you want to set up:
**For Zsh:**
```
zsh
git
silversearcher/ag
chsh
```
**For Vim:**
```
vim/nvim
git
curl
nodejs
```
**For Terminal colorscheme:**
```
gnome-terminal/urxvt/xterm (Choose one or all of them)
xrdb (for URxvt/Xterm)
git (for Gnome terminal)
```
## Fonts
Powerlevel10K and Vim-airline requires powerline fonts to work. We suggest [Nerd-fonts](https://github.com/ryanoasis/nerd-fonts) because that is what we are using. The font in the screenshot above is using UbuntuMono Nerd Font Regular.
## Installation
Install list of packages needed depending on what you want to setup, if you want to install everything, then this is the command you need:

**Arch Linux and Derivatives**  
`sudo pacman -S zsh neovim rxvt-unicode gnome-terminal git nodejs the_silver_searcher curl`

**Ubuntu and Derivatives**  
`sudo apt install zsh neovim rxvt-unicode-256color gnome-terminal git nodejs silversearcher-ag curl`

After that, simply git clone this repository and run the install script. It will ask you what do you want to install. If you want to install everything without confirmation, pass the `--all` argument in the command like this:
```
git clone https://github.com/budimanjojo/dotfiles-installer.git ~/.dotfiles-installer && ~/.dotfiles-installer/install.sh --all
```
## What Are Included
**Zsh**  
This script will install [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and add these plugins:
- [Powerlevel10K](https://github.com/romkatv/powerlevel10k) as the theme
- [Zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) for the fish like autosuggestions
- [Zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) for the fish like syntax highlighting

**Vim**  
This script will install [Vim-plug](https://github.com/junegunn/vim-plug) and add these plugins:
- [Vim-easy-align](https://github.com/junegunn/vim-easy-align)
- [Vim-colorshcemes](https://github.com/flazz/vim-colorschemes)
- [Base16-vim](https://github.com/chriskempson/base16-vim)
- [Vim-airline](https://github.com/vim-airline/vim-airline)
- [Vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
- [Nerdtree](https://github.com/scrooloose/nerdtree)
- [Nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin)
- [Tcomment](https://github.com/tomtom/tcomment_vim)
- [Vim-fugitive](https://github.com/tpope/vim-fugitive)
- [Ale](https://github.com/w0rp/ale)
- [Emmet-vim](https://github.com/mattn/emmet-vim)
- [Coc.nvim](https://github.com/neoclide/coc.nvim)
- [Vim-snippets](https://github.com/honza/vim-snippets)
- [Fzf.vim](https://github.com/junegunn/fzf.vim)

Coc.nvim will have these extensions inside:
- [coc-json](https://github.com/neoclide/coc-json)
- [coc-snippets](https://github.com/neoclide/coc-snippets)
- [coc-pairs](https://github.com/neoclide/coc-pairs)
- [coc-highlight](https://github.com/neoclide/coc-highlight)
- [coc-tsserver](https://github.com/neoclide/coc-tsserver)
- [coc-tslint](https://github.com/neoclide/coc-tslint)
- [coc-html](https://github.com/neoclide/coc-html)
- [coc-css](https://github.com/neoclide/coc-css)
- [coc-phpls](https://github.com/marlonfan/coc-phpls)
- [coc-stylelint](https://github.com/neoclide/coc-stylelint)
- [coc-vimlsp](https://github.com/iamcco/coc-vimlsp)
- [coc-yaml](https://github.com/neoclide/coc-yaml)

**Note:** You need Vim version >=8.0 or Neovim version >=0.3.1 in order to use Coc.nvim

**Colorscheme**  
For Gnome Terminal setup, we use [Base16-gnome-terminal](https://github.com/chriskempson/base16-gnome-terminal) to set it up.
## Updating
**Zsh**  
Oh-my-zsh will ask you for update confirmation every 13 days. To update Zsh-autosuggestions, Zsh-syntax-highlighting and Powerlevel10k, simply do a git pull to each folder in `$ZSH_CUSTOM/plugins` and `$ZSH_CUSTOM/themes`.

**Vim**  
To update Vim plugins, simply do `:PlugUpdate` in your vim. For Coc extensions, you don't have to do anything. It will update by itself everyday.

## Customization
**ZSH**

In normal oh-my-zsh install, you can customize your `~/.zshrc` and your `$ZSH_CUSTOM` folder, but this install script needs to make small changes for FZF and COC Vim to work. So, please don't edit your ~/.zshrc manually, but edit the files inside `$ZSH_CUSTOM` instead. This install script will put in 4 files for you to customize:
- `$ZSH_CUSTOM/general.zsh` contains your own general settings for oh-my-zsh
- `$ZSH_CUSTOM/alias.zsh` contains your own aliases for oh-my-zsh
- `$ZSH_CUSTOM/looks.zsh` contains oh-my-zsh theme and its settings
- `$ZSH_CUSTOM/plugs.zsh` contains oh-my-zsh plugins and its settings

**Vim**

For Vimrc, currently it is not possible to customize without forking this repo yet. But it is in our planning list to provide a better way to customize your custom config file.
## To do
- [ ] Better way to use custom configs
- [ ] Use separate files instead of one vimrc
- [x] Better way to handle custom Powerlevel9k settings
- [ ] Include Tmux config

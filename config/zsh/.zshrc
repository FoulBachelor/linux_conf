# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.

# STUBBE CUSTOM CONFIG DIRECTORIES
STUBBE_DIRECTORY="$HOME/.stubbe"
ZSH_STUBBE_DIRECTORY="$STUBBE_DIRECTORY/zsh"
ALIAS_STUBBE_DIRECTORY="$STUBBE_DIRECTORY/aliases"
EXPORT_STUBBE_DIRECTORY="$STUBBE_DIRECTORY/exports"
BUILDS_STUBBE_DIRECTORY="$STUBBE_DIRECTORY/builds"
VIM_STUBBE_DIRECTORY="$STUBBE_DIRECTORY/vim"
TMUX_STUBBE_DIRECTORY="$STUBBE_DIRECTORY/tmux"

if [[ ! -d "$STUBBE_DIRECTORY" ]]; then
  mkdir -p $HOME/.stubbe
fi
if [[ ! -d "$ZSH_STUBBE_DIRECTORY" ]]; then
  mkdir -p $STUBBE_DIRECTORY/zsh
fi
if [[ ! -d "$ALIAS_STUBBE_DIRECTORY" ]]; then
  mkdir -p $STUBBE_DIRECTORY/aliases
fi
if [[ ! -d "$EXPORT_STUBBE_DIRECTORY" ]]; then
  mkdir -p $STUBBE_DIRECTORY/exports
fi
if [[ ! -d "$BUILDS_STUBBE_DIRECTORY" ]]; then
  mkdir -p $STUBBE_DIRECTORY/builds
fi
if [[ ! -d "$VIM_STUBBE_DIRECTORY" ]]; then
  mkdir -p $STUBBE_DIRECTORY/vim
fi
if [[ ! -d "$TMUX_STUBBE_DIRECTORY" ]]; then
  mkdir -p $STUBBE_DIRECTORY/tmux
fi
# STUBBE CUSTOM CONFIG DIRECTORIES

# Source Exports
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
if [[ -d "$HOME/.config/composer" ]]; then
  export PATH=$PATH:$HOME/.config/composer/vendor/bin
fi
# Source Export

# ZSH Globals
HYPHEN_INSENSITIVE="false"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
VIM_MODE_NO_DEFAULT_BINDINGS=true
# ZSH Globals

# Z-STYLE Globals
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1
# Z-STYLE Globals

# USER Preferences
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
  export TERM='xterm'
else
  export EDITOR='nvim'
fi
# USER Preferences

# ZSH Plugins
if [[ ! -d "$ZSH_STUBBE_DIRECTORY/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_STUBBE_DIRECTORY/zsh-syntax-highlighting
fi
source $ZSH_STUBBE_DIRECTORY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ ! -d "$ZSH_STUBBE_DIRECTORY/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_STUBBE_DIRECTORY/zsh-autosuggestions
fi
source $ZSH_STUBBE_DIRECTORY/zsh-autosuggestions/zsh-autosuggestions.zsh
if [[ ! -d "$ZSH_STUBBE_DIRECTORY/zsh-autopair"  ]]; then
  git clone https://github.com/hlissner/zsh-autopair $ZSH_STUBBE_DIRECTORY/zsh-autopair
fi
source $ZSH_STUBBE_DIRECTORY/zsh-autopair/autopair.zsh
# ZSH Plugins

# USER Keybinds for Terminal
bindkey -v
bindkey -s '§' '$'
bindkey -s "^L" 'ls -a^M'
bindkey -s "^T" 'tmux_init^M'
# USER Keybinds for Terminal

# USER Alias && Function imports
source $HOME/.aliasrc
# USER Alias && Function imports

# Source Theme Config
if [[ ! -d "$ZSH_STUBBE_DIRECTORY/zsh-theme" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_STUBBE_DIRECTORY/zsh-theme
fi
source $ZSH_STUBBE_DIRECTORY/zsh-theme/powerlevel10k.zsh-theme
# Source Theme Config

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/flutter/bin:$PATH
export PATH="$HOME/Library/Android/sdk:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$HOME/Library/Android/sdk:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
alias nv="nvim"
alias lg="lazygit"
alias sozsh="source ~/.zshrc"
alias cl="clear"
alias pas="php artisan serve"
alias ns="npm start"
alias ni="npm install"
alias nip="npm install --package-lock-only"
alias nb="npm run build"
alias nbs="npm run build-nosentry"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Homebrew path
OS="$(uname -s)"
HAS_BREW=1
if [[ "$OS" == "Darwin" ]]; then
  BREW_BIN_PATH="/opt/homebrew/bin/brew"
  BREW_OPT_PATH="/opt/homebrew/opt"
elif [[ "$OS" == "Linux" ]]; then
  BREW_BIN_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
  BREW_OPT_PATH="/home/linuxbrew/.linuxbrew/opt/"
else
  HAS_BREW = 0
fi

if [[ "$HAS_BREW" -eq 1 ]]; then
  eval "$($BREW_BIN_PATH shellenv)"
  export NVM_DIR="$HOME/.nvm"
    [ -s "$BREW_OPT_PATH/nvm/nvm.sh" ] && \. "$BREW_OPT_PATH/nvm/nvm.sh"  # This loads nvm
    [ -s "$BREW_OPT_PATH/nvm/etc/bash_completion.d/nvm" ] && \. "$BREW_OPT_PATH/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  export PATH="$BREW_OPT_PATH/php@7.4/bin:$PATH"
  export PATH="$BREW_OPT_PATH/php@7.4/sbin:$PATH"
  if [ -d "$BREW_OPT_PATH/ruby/bin" ]; then
    export PATH=/opt/homebrew/opt/ruby/bin:$PATH
    export PATH=`gem environment gemdir`/bin:$PATH
  fi

  # Completions
  eval "$(zoxide init zsh)"
  eval "$(buf completion zsh)"
  [ -s "/home/rizal/.bun/_bun" ] && source "/home/rizal/.bun/_bun"
fi

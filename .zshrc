eval "$(/opt/homebrew/bin/brew shellenv)"

################################################################################################################################
#                                                           Antigen                                                            #
################################################################################################################################

source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  git
  git-flow
  git-extras
  https://gist.github.com/ohcibi/986fe0876b1cf746d1e8
  zsh-users/zsh-autosuggestions
  docker
  nvm
  rails
  ruby
  man
  mix
  heroku
EOBUNDLES
antigen theme agnoster
antigen apply

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

DEFAULT_USER="lukas"

################################################################################################################################
#                                                          NVM Setup                                                           #
################################################################################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

################################################################################################################################
#                                                Aliases and Environment Setup                                                 #
################################################################################################################################

export PIP_TARGET=$HOME/.pip

source $HOME/.configrc/.aliases.sh

gbp() {
    echo "Do you really want to commit to this branch [y/n]?"
    git rev-parse --abbrev-ref HEAD
    read des
    if [ "$des" = "y" ]; then
      ggpush
    else
      >&2 echo "[ABORTED]"
    fi
}

function vimf() {
  vim $(find * -type f | fzf) $@
}

function fco() {
  gco $(gb | command xargs -n 1 | grep -v "*" | fzf) $@
}

function last_release_tag() {
  git tag | sort -nr | egrep '\d+\.\d+\.\d+' | head -n1 | tr -d '\n'
}

export PATH="$(brew --prefix)/opt/imagemagick@6/bin:$PATH:/Users/lukas/Library/Android/sdk/tools/bin"
export GPG_TTY=$(tty) # Diese globale Variable ist wichtig, dass das GPG signing von git commits funktioniert

# eval $(thefuck --alias)
# eval "$(gulp --completion=zsh)"
export GOPATH=/Users/lukas/go
export JAVA_HOME=$(brew --prefix)/opt/openjdk@11
export PATH="$JAVA_HOME/bin:$(brew --prefix)/opt/bison/bin:$PATH:$HOME/flutter/bin:$HOME/.composer/vendor/bin:$HOME/.poetry/bin:$GOPATH/bin:$HOME/.rbenv/bin:$HOME/oracle/instantclient_20_3:$HOME/.pub-cache/bin:$HOME/.configrc/custom-scripts"
export ANDROID_HOME=/Users/lukas/Library/Android/sdk
export GROOVY_HOME=$(brew --prefix)/opt/groovy/libexec
export BISON_PATH=$(brew --prefix)/opt/bison/bin/bison
export LC_ALL=en_US.UTF-8
export EDITOR=vim
export OCI_DIR=~/oracle/instantclient_19_3
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/lib
export CPATH=$CPATH:/opt/homebrew/include
export HISTSIZE=70000

# Do not write duplicates to history file
setopt hist_ignore_all_dups

# Igonre commands with preceeding space
setopt hist_ignore_space

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.tiny-care-terminalrc

eval "$(rbenv init -)"

lsall() { echo; ls -lah; echo }
zle -N lsall
bindkey '^[l' 'lsall'

_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

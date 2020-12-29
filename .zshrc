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
eval "$(rbenv init -)"
eval "$(pyenv init -)"
DEFAULT_USER="lukas"

[[ -s /Users/lukas/.rsvm/rsvm.sh ]] && . /Users/lukas/.rsvm/rsvm.sh

source $HOME/.configrc/.aliases.sh

function vimf() {
  vim $(find * -type f | fzf) $@
}

function fco() {
  gco $(gb | command xargs -n 1 | grep -v "*" | fzf) $@
}

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export LC_ALL=en_US.UTF-8
export EDITOR=vim
export GPG_TTY=$(tty) # Diese globale Variable ist wichtig, dass das GPG signing von git commits funktioniert
export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/.composer/vendor/bin:$JAVA_HOME/bin:$GOPATH/bin:$HOME/.configrc/custom-scripts"
export JAVA_HOME=/Library/Java/Home
export ANDROID_HOME="$HOME/Library/Android/sdk"
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export BISON_PATH=/usr/local/opt/bison/bin/bison
export PIP_TARGET="$HOME/.pip"
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

eval $(thefuck --alias)
eval "$(gulp --completion=zsh)"

_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.tiny-care-terminalrc

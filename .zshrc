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
EOBUNDLES
antigen theme agnoster
antigen apply

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
eval "$(rbenv init -)"
eval "$(pyenv init -)"
DEFAULT_USER="lukas"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -s /Users/lukas/.rsvm/rsvm.sh ]] && . /Users/lukas/.rsvm/rsvm.sh

export PIP_TARGET=/Users/lukas/.pip

source /Users/lukas/.configrc/.aliases.sh

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export GPG_TTY=$(tty) # Diese globale Variable ist wichtig, dass das GPG signing von git commits funktioniert

eval $(thefuck --alias)
eval "$(gulp --completion=zsh)"
REACT_EDITOR=atom
export GOPATH=/Users/lukas/go
export PATH="$PATH:$HOME/.composer/vendor/bin:$JAVA_HOME/bin:$GOPATH/bin:$HOME/.configrc/custom-scripts"
export JAVA_HOME=/Library/Java/Home
export ANDROID_HOME=/Users/lukas/Library/Android/sdk
export GROOVY_HOME=/usr/local/opt/groovy/libexec

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.tiny-care-terminalrc

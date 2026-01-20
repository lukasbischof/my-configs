eval "$(/opt/homebrew/bin/brew shellenv)"

################################################################################################################################
#                                                           Antigen                                                            #
################################################################################################################################

source /Users/lukas/.configrc/antigen.zsh
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  git
  git-flow
  git-extras
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-interactive-cd
  rake
  man
  mix
  heroku
EOBUNDLES
antigen theme agnoster
antigen apply

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
DEFAULT_USER="lukas"

################################################################################################################################
#                                                Aliases and Environment Setup                                                 #
################################################################################################################################

# # asdf setup
# export ASDF_DATA_DIR="$HOME/.asdf"
# export PATH="$ASDF_DATA_DIR/shims:$PATH"
# fpath=(${ASDF_DIR}/completions $fpath)
# autoload -Uz compinit && compinit
# . ~/.asdf/plugins/java/set-java-home.zsh

# Mise setup
eval "$(mise activate zsh)"

autoload -Uz zcalc

export PIP_TARGET=/Users/lukas/.pip

export PATH="$(brew --prefix)/opt/imagemagick@6/bin:$PATH:/Users/lukas/Library/Android/sdk/tools/bin"
export GPG_TTY=$(tty) # Diese globale Variable ist wichtig, dass das GPG signing von git commits funktioniert

# export JAVA_HOME=$(brew --prefix)/opt/openjdk
export PATH="$(brew --prefix)/opt/bison/bin:$PATH:$HOME/flutter/bin:$HOME/.composer/vendor/bin:$HOME/.poetry/bin:$HOME/oracle/instantclient_20_3:$HOME/.pub-cache/bin:$HOME/.local/bin:$HOME/Library/Application Support/Coursier/bin:$HOME/.configrc/custom-scripts"
export ANDROID_HOME=$HOME/Library/Android/sdk
export FLUTTER_ROOT="$(mise where flutter)"
export GROOVY_HOME=$(brew --prefix)/opt/groovy/libexec
export BISON_PATH=$(brew --prefix)/opt/bison/bin/bison
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export OCI_DIR=~/oracle/instantclient_19_3
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/lib
export CPATH=$CPATH:/opt/homebrew/include
export HISTSIZE=90000

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

source $HOME/.configrc/aliases.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/op/plugins.sh

################################################################################################################################
#                                                         Completions                                                          #
################################################################################################################################

source <(kompose completion zsh)
HEROKU_AC_ZSH_SETUP_PATH=/Users/lukas/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
source <(docker completion zsh)
# source <(nctl completions -c zsh)
source <(op completion zsh)
source <(sem completion zsh)

# lsall() { echo; ls -lah; echo }
# zle -N lsall
# bindkey '^[l' 'lsall'
#
# _zsh_cli_fg() { fg; }
# zle -N _zsh_cli_fg
# bindkey '^Z' _zsh_cli_fg

################################################################################################################################
#                                                         Custom Scripts                                                       #
################################################################################################################################

delete-merged-branches() {
  branches=$(git branch --format '%(refname:short)' | grep -Fxv "$(gh pr list --state open --json headRefName --jq '.[].headRefName')" | grep -Ev '^(master|main|develop)$' | grep -v "$(git_current_branch)")

  echo "Branches that will be deleted:"
  echo -e "\033[1;31m$branches\033[0m"

  printf "Do you want to delete these branches? (y/n): "
  read -k 1 answer
  echo

  if [ "$answer" = "y" ]; then
    git branch -D $(xargs <<<"$branches")
  fi
}

edit-project() { nvim }

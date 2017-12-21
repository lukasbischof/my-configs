source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle git-flow
antigen bundle git-extras
antigen bundle https://gist.github.com/ohcibi/986fe0876b1cf746d1e8

antigen theme agnoster
# antigen theme bhilburn/powerlevel9k powerlevel9k

antigen apply


[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
eval "$(rbenv init -)"
DEFAULT_USER="lukas"

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

export PIP_TARGET=/Users/lukas/.pip

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

updated_gpg() {
  new_version="$(brew list --versions gpg | cut -f2 -d" ")"
  echo "Your current gpg program is $(git config gpg.program)"
  echo "It will get updated to /usr/local/Cellar/gnupg/$new_version/bin/gpg"
  echo -n "Is that ok? [y/n]: "
  read des

  if [ $des = "y" ]; then
    git config --global gpg.program "/usr/local/Cellar/gnupg/$new_version/bin/gpg"
    echo "$(git config gpg.program)"
  else
    >&2 echo "[ABORTED]"
  fi
}

alias mine='open -a RubyMine'
alias lock="open -a ScreenSaverEngine"
alias lsla="ls -laGhO"
alias gtr="cd ~/r/"
alias a="atom ."
alias r="cd ~/r"
alias pause="spotify pause"
alias play="spotify play"
alias nxt="spotify next"
alias prev="spotify prev"
alias ppwd="pwd -P"
alias clock="cli-clock"
alias rc="rails console"
alias rcs="rails console --sandbox"
alias rd="rails db"
alias rdm="rails db:migrate"
alias rdms="rails db:migrate:status"
alias rdreseed="bbe rake db:drop; bbe rake db:create; bbe rake db:migrate; bbe rake db:seed"
alias rr="rails routes"
alias rs="rails server"
alias rspc="bin/bundle exec rspec"
alias v="vim"
alias spfy="spotify"
alias findext="find . -type f -name"
alias bbe="bin/bundle exec"
alias cnsl="rails console"
alias mach_update="renuo upgrade-laptop; gem update; npm i -g npm; npm update; npm upgrade; brew cu -a;"
alias psql_start="pg_ctl -D /usr/local/var/postgres start"
alias psql_stop="pg_ctl -D /usr/local/var/postgres stop"
alias svgtopng="/Users/lukas/p/scripts/svgtopng.sh"
alias s="bbe rspec"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export GPG_TTY=$(tty) # Diese globale Variable ist wichtig, dass das GPG signing von git commits funktioniert


eval $(thefuck --alias)
eval "$(gulp --completion=zsh)"

alias lock="open -a ScreenSaverEngine"
alias lsla="ls -laGhO"
alias ppwd="pwd -P"
alias rcs="rails console --sandbox"
alias rdm="rails db:migrate"
alias rdms="rails db:migrate:status"
alias rdreseed="bbe rake db:drop db:create db:migrate db:seed"
alias rspc="bin/bundle exec rspec"
alias t="tmux"
alias findext="find . -type f -name"
alias bbe="bin/bundle exec"
alias cnsl="rails console"
alias psql_start="pg_ctl -D /usr/local/var/postgres start"
alias psql_stop="pg_ctl -D /usr/local/var/postgres stop"
alias react-native-container="/Users/lukas/p/scripts/react-native-container.sh"
alias s="bbe rspec"
alias run="bin/run"
alias webstorm="open -a /Users/lukas/Applications/JetBrains\ Toolbox/WebStorm.app ."
alias plistbuddy="/usr/libexec/PlistBuddy"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias emulator="$ANDROID_HOME/emulator/emulator"
alias dc="docker-compose"
alias gsw="git switch"
alias gffs="git flow feature start"

gswi () {
  gsw "$(gb | command xargs -n 1 | grep -v '*' | fzf)"
}

gbf () {
  git branch | command xargs -n 1 | grep -v "*" | grep -v "$(git_current_branch)" | fzf
}

vimf() {
  vim $(find ${1:-*} -type f -not -path "node_modules/*" -not -path "tmp/*" -not -path "coverage/*" -not -path "public/packs/*" -not -path "public/packs-test/*" -not -path "public/assets/*" | fzf --preview "bat --color=always --style=numbers --line-range=:500 {}")
}

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

fco() { gco $(gb | command xargs -n 1 | grep -v "*" | fzf) $@ }

last_release_tag() {
  git tag | sort -rV | egrep '\d+\.\d+\.\d+' | head -n1 | tr -d '\n'
}

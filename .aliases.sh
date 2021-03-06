alias lock="open -a ScreenSaverEngine"
alias lsla="ls -laGhO"
alias r="rails"
alias pause="spotify pause"
alias play="spotify play"
alias nxt="spotify next"
alias prev="spotify prev"
alias ppwd="pwd -P"
alias clock="cli-clock"
alias rcs="rails console --sandbox"
alias rdm="rails db:migrate"
alias rdms="rails db:migrate:status"
alias rdreseed="bbe rake db:drop db:create db:migrate db:seed"
alias rspc="bin/bundle exec rspec"
alias v="vim"
alias t="tmux"
alias spfy="spotify"
alias findext="find . -type f -name"
alias bbe="bin/bundle exec"
alias psql_start="pg_ctl -D /usr/local/var/postgres start"
alias psql_stop="pg_ctl -D /usr/local/var/postgres stop"
alias run="bin/run"
alias webstorm="open -a /Users/lukas/Applications/JetBrains\ Toolbox/WebStorm.app ."
alias plistbuddy="/usr/libexec/PlistBuddy"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias emulator="~/Library/Android/sdk/tools/emulator @Nexus_5X_API_26_x86"
alias rnri="react-native run-ios --simulator=\"iPhone 8\""
alias rnra="react-native run-android"
alias dc="docker-compose"
alias unit-tests="bundle exec rspec --exclude-pattern \"**/{system,screenshots,features}/**/*_spec.rb\""

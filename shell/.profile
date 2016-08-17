# Aliases
alias catc="pygmentize -g"

# source common environment settings
source ~/.env

# Source machine specific environment in
test -f ~/.env.local && source ~/.env.local

if ! [ -n "${DOTFILES+set}" ] ; then
  export DOTFILES=~/dotfiles
fi

export PATH=$PATH:$DOTFILES/bin/bin

# Include rvm if existent
if [ -f "$HOME/.rvm/scripts/rvm" ] ; then
  source "$HOME/.rvm/scripts/rvm"
fi


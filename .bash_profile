export DOTFILES=${HOME}/dotfiles
PATH="/usr/local/bin:$PATH"
PATH="$HOME/local/bin:$PATH"

if which sw_vers >/dev/null 2>&1 && sw_vers | grep 'ProductName:\s\+Mac OS X' >/dev/null 2>&1; then
  source ~/.profile mac
fi
source ~/.profile windows
if shopt -q login_shell; then
  if [ -f ~/.bashrc ]; then
    source ~/.bashrc
  fi
fi
export PATH


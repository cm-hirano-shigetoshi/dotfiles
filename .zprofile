if which sw_vers >/dev/null 2>&1 && sw_vers | grep 'ProductName:\s\+Mac OS X' >/dev/null 2>&1; then
    source ~/.profile mac
fi
source ~/.profile windows
export PATH


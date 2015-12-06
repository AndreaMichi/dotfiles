# --------------- PATH Definitions and loading default files ------------------
GENERAL_PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin"
SICSTUS_PATH="/usr/local/sicstus4.2.3/bin"
HASKELL_PATH="$HOME/Library/Haskell/bin"
RBENV_PATH="$HOME/.rbenv/bin"
LATEX_PATH="/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin"

export GOPATH="$HOME/Projects/golang"
export PATH="$GOPATH/bin:$HASKELL_PATH:$RBENV_PATH:$SICSTUS_PATH:$LATEX_PATG:$GENERAL_PATH"

export JAVA_HOME=`/usr/libexec/java_home`
export XDG_CONFIG_HOME="$HOME/.config"

source ~/.aliases

# --------------- Languages configurations ------------------------------------

# Python (Virtualenv and PIP). 'lsvirtualenv', 'workon NAME'
source "/usr/local/bin/virtualenvwrapper.sh"
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true

# Ruby Configuration (RBEVN). Use 'rbenv versions' for summary
eval "$(rbenv init -)"

# Javascript (Node.js and NVM). Use 'nvm ls' for summary
[ -s "/Users/andreamichi/.nvm/nvm.sh" ] && . "/Users/andreamichi/.nvm/nvm.sh"

# --------------- Miscelanneous Configurations --------------------------------


# Always exclude ctags generated files from GREP
export GREP_OPTIONS="--exclude=tags"
export EDITOR="vim"

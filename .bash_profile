#Git autocompletion
source ~/.git-completion.bash

#Show git branch in prompt
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac
PS1="${TITLEBAR}\
$BLUE[$RED\u@\h:\W$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\$ "
PS2='> '
PS4='+ '
}
proml

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PYTHONPATH=""
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:/usr/lib/node_modules/jasmine-node/bin:${PATH}"
export PATH
SCALA_HOME="/System/Library/Scala/scala-2.9.0.1"
PATH=$SCALA_HOME/bin:$PATH
export PATH

GOOGLE_APP_ENGINE="/usr/local/google_appengine"
export GOOGLE_APP_ENGINE


NODE_PATH="/usr/lib/node_modules:${NODE_PATH}"
export NODE_PATH

if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi
	
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_OPTIONS='-G'
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -al'	
alias cdbo='cd ~/Documents/Shopkeep/repos/backoffice'
alias cdipad='cd ~/Documents/Shopkeep/repos/ipad-register'

MYSQL_BIN="/usr/local/mysql/bin"
PATH=$PATH:$MYSQL_BIN

##
# Your previous /Users/Luis/.bash_profile file was backed up as /Users/Luis/.bash_profile.macports-saved_2011-11-03_at_18:49:18
##

# MacPorts Installer addition on 2011-11-03_at_18:49:18: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


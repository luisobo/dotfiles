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
$RED\W$GREEN\$(parse_git_branch) \
$GREEN\$ "
PS2='> '
PS4='+ '
}
proml


if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/.profile

alias ll="ls -alh"
alias xc="open *.xcworkspace"
alias be="bundle exec"
alias dc="docker-compose"
alias dm="docker-machine"

function ssbt {
 echo "sbt -shell "$@" shell"
  sbt -shell "$@" shell
}

export PATH="$PATH:$HOME/bin"

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/luis/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"

complete -C aws_completer aws

export EDITOR="subl -w"

source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

#!/bin/sh
# shellcheck disable=SC2155

# Colourful manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Set to avoid `env` output from changing console colour
export LESS_TERMEND=$'\E[0m'

# Setup paths
remove_from_path() {
  [ -d "$1" ] || return
  # Doesn't work for first item in the PATH but I don't care.
  export PATH=${PATH//:$1/}
}

add_to_path_start() {
  [ -d "$1" ] || return
  remove_from_path "$1"
  export PATH="$1:$PATH"
}

add_to_path_end() {
  [ -d "$1" ] || return
  remove_from_path "$1"
  export PATH="$PATH:$1"
}

force_add_to_path_start() {
  remove_from_path "$1"
  export PATH="$1:$PATH"
}

quiet_which() {
  command -v "$1" >/dev/null
}

add_to_path_end "/sbin"
add_to_path_end "$HOME/.dotfiles/bin"
add_to_path_start "/usr/local/bin"
add_to_path_start "/usr/local/sbin"

# Aliases
alias mkdir="mkdir -vp"
alias cp="cp -irv"
alias rake="noglob rake"
alias be="noglob bundle exec"

alias ll="ls -al"

export GREP_OPTIONS="--color=auto"
export CLICOLOR=1

# Set up editor
export EDITOR="code --wait"
export GIT_EDITOR="vi"

# Look in ./bin but do it last to avoid weird `which` results.
force_add_to_path_start "bin"

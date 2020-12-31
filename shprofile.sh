# 077 would be more secure, but 022 is more useful.
umask 022

# Save more history
export HISTSIZE="100000"
export SAVEHIST="100000"

# Fix systems missing $USER
[ -z "$USER" ] && export USER="$(whoami)"

# Count CPUs for Make jobs
export CPUCOUNT="$(sysctl -n hw.ncpu)"

if [ "$CPUCOUNT" -gt 1 ]
then
  export MAKEFLAGS="-j$CPUCOUNT"
  export BUNDLE_JOBS="$CPUCOUNT"
fi

# Enable Terminal.app folder icons
[ "$TERM_PROGRAM" = "Apple_Terminal" ] && export TERMINALAPP=1
if [ $TERMINALAPP ]
then
  set_terminal_app_pwd() {
    # Tell Terminal.app about each directory change.
    printf '\e]7;%s\a' "$(echo "file://$HOST$PWD" | sed -e 's/ /%20/g')"
  }
fi
[ -s ~/.lastpwd ] && [ "$PWD" = "$HOME" ] && \
  builtin cd "$(cat ~/.lastpwd)" 2>/dev/null
[ $TERMINALAPP ] && set_terminal_app_pwd

# Load secrets
[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

# Some post-secret aliases
export HOMEBREW_GITHUB_TOKEN="$GITHUB_TOKEN"
export HUBOT_GITHUB_TOKEN="$GITHUB_TOKEN"
export OCTOKIT_ACCESS_TOKEN="$GITHUB_TOKEN"

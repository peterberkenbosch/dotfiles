# check if this is a login shell
[ "$0" = "-zsh" ] && export LOGIN_ZSH=1

# run zprofile if this is not a login shell
[ -n "$LOGIN_ZSH" ] && source ~/.zprofile

# load shared shell configuration
source ~/.shrc

# History file
export HISTFILE=~/.zsh_history

# Don't show duplicate history entires
setopt hist_find_no_dups

# Remove unnecessary blanks from history
setopt hist_reduce_blanks

# Share history between instances
setopt share_history

# Don't hang up background jobs
setopt no_hup

. $(brew --prefix asdf)/asdf.sh

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Olaf Conradi <olaf@conradi.org>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Custom aliases
alias dvtm='dtach -A /tmp/dvtm-session-$USER -r winch dvtm'

# Don't autocorrect these commands
alias sudo='nocorrect sudo'
alias mkdir='nocorrect mkdir'

# On systems that don't have w installed, alias it to who command
if (( ! $+commands[w] )); then
  alias w='who -b -l -p -r -T -u'
fi

# History substring search keybindings
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Enable navigation using Home and End key
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

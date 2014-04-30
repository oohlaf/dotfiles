# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Custom aliases
alias dvtm='dtach -A /tmp/dvtm-session-$USER -r winch dvtm'

# Don't autocorrect these commands
alias sudo='nocorrect sudo'
alias mkdir='nocorrect mkdir'

# History substring search keybindings
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Customize to your needs...
export MAIL=olaf@conradi.org
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games

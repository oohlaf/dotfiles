#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Olaf Conradi <olaf@conradi.org>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
# Olaf: Commented out as I want to use prezto for interactive shells only
# if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprofile"
# fi

# Email address to use on this system
export MAIL=$DotSecrets: mail$

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Add zsh location on Synology NAS
if [[ -x /.syno ]]; then
  path=(
    /var/packages/zsh-static/target/bin
    $path
  )
fi

path=(
  ~/bin
  /usr/local/{bin,sbin}
  $path
)

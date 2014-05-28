export MAIL=$DotSecrets: mail$

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path
path=(~/bin /usr/local/{bin,sbin} $path)

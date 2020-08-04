My dotfiles repository
======================

This repository contains my collection of various dotfiles. They are stripped
from sensitive information like usernames and passwords using
[DotSecrets](https://github.com/oohlaf/dotsecrets).

[DotSecrets](https://github.com/oohlaf/dotsecrets) is a dotfiles manager I
wrote which allows you to strip information based on regular expressions and
replace it with a special tag. This is done transparantly using Git filters.

When the repository is cloned, a choice can be made to symlink all the
dotfiles into `$HOME` or by topic (toplevel directory).


Installation on a new machine
-----------------------------

1. Start with a fresh checkout:

```
$ git clone --recurse-submodules git@github.com:oohlaf/dotfiles.git
```

2. Transfer my secrets file from another machine and copy it to
`~\.config/dotsecrets/dotsecrets.yaml` and make sure the file permissions are
restricted:

```
$ chmod 0600 ~/.config/dotsecrets/dotsecrets.yaml
```

3. Initialize the dotfiles working directory:

```
$ dotsecrets init
```

4. Symlink the relevant dotfiles to `$HOME` either by topic or all:

```
$ dotsecrets stow <topic>
$ dotsecrets stow --all
```


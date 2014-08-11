The contents of this directory are encrypted using [git-crypt](https://www.agwa.name/projects/git-crypt/), version 0.3.

This can be installed with brew:

    brew install git-crypt

Then you can decrypt as follows:

    cd <root of repository>
    git-crypt init /path/to/keyfile

Where `/path/to/keyfile` is the keyfile originally used to encrypt these contents, as created with `git-crypt keygen`:

    mkdir -p /path/to
    git-crypt keygen /path/to/keyfile

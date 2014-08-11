---
layout: page
alias: /journal/index.html
---

The contents of this journal are private. Files are encrypted using [git-crypt](https://www.agwa.name/projects/git-crypt/), version 0.3.

Install `git-crypt` using `brew`:

    brew install git-crypt

Then decrypt the repository contents as follows:

    cd <root of repository>
    git-crypt init /path/to/keyfile

Where `/path/to/keyfile` is the keyfile originally used to encrypt these contents, as created with `git-crypt keygen`:

    mkdir -p /path/to
    git-crypt keygen /path/to/keyfile

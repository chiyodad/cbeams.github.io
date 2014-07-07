#!/bin/bash
#
# Convenience script for adding a new entry to the _stream collection.
#
#  - Assumes /tmp dir exists and is writable.
#  - Assumes all files in _stream are named <number>.md.
#  - Assumes $EDITOR is a blocking command (`vi` is OK, `mate` isn't)
#  - Commits new file but does not push.
#  - Does not clean up temp files.
#
# Recommendation: create a symlink to this file from somewhere on your $PATH.
#

# prompt the user to write something
tmpfile=/tmp/$RANDOM.txt
$EDITOR $tmpfile

# abort if the user didn't write anything
let size=$(wc -c $tmpfile | perl -p -i -e 's/ +//' | cut -d" " -f1)
if [ $size -le 1 ]; then
    echo Aborting due to empty message.
    exit 1
fi

# determine the next ID to be assigned
let last_id=$(ls -1 _stream/ | cut -d'.' -f1 | sort -sn | tail -1)
let next_id=last_id+1

# create the new file with necessary headers
destfile=_stream/$next_id.md
cat > $destfile <<EOF
---
layout: page
title: $next_id
date: $(date "+%Y-%m-%d %H:%M:%S %z")
---
EOF

# copy the user-created message to the body of the new file
cat $tmpfile >> $destfile

git add $destfile
git commit -m"Add $destfile" --only $destfile

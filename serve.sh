#!/bin/bash

HOOKPORT=12345
SERVEPORT=80

while true; do
    echo starting jekyll on port $SERVEPORT...
    jekyll serve --port $SERVEPORT &
    JEKYLLPID=$!
    echo jekyll started with pid $JEKYLLPID.
    echo listening for webhook notifications on port $HOOKPORT.
    nc -l $HOOKPORT
    echo got webhook request. updating git repo...
    git pull
    echo git repo updated. killing jekyll.
    kill -9 $!
done

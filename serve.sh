#!/bin/bash

HOOKPORT=12345
SERVEPORT=4000

cd $(dirname $0)

echo updating git repo...
/usr/local/bin/git pull

while true; do
    echo starting jekyll on port $SERVEPORT...
    jekyll serve --port $SERVEPORT &
    JEKYLLPID=$!
    echo jekyll started with pid $JEKYLLPID.
    echo listening for webhook notifications on port $HOOKPORT.
    echo -e "HTTP/1.1 202 Accepted\r\nContent-Type: text/html\r\n\r\n" | nc -l $HOOKPORT
    echo got webhook request. updating git repo...
    /usr/local/bin/git pull
    echo git repo updated. killing jekyll.
    kill -9 $!
done

FROM debian:latest
MAINTAINER Chris Beams <chris@beams.io>
RUN apt-get update && apt-get install -y git ruby rubygems ruby1.9.1-dev
RUN gem install jekyll execjs therubyracer
RUN git clone --branch docker https://github.com/cbeams/chris.beams.io.git

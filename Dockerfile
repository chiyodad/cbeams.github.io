FROM ubuntu:latest
MAINTAINER Chris Beams <chris@beams.io>
RUN apt-get update
RUN apt-get install -y make
RUN apt-get install -y g++
RUN apt-get install -y git
RUN apt-get install -y ruby1.9.1-dev
RUN gem install jekyll
RUN gem install execjs therubyracer
RUN git clone https://github.com/cbeams/chris.beams.io.git

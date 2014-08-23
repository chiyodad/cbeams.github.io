---
layout: post
title: Dockerizing Jekyll on OS X
date: Sat Aug 23 23:50:23 +0200 2014
timestamp: 19009968
---

_This site is now being served from within a Docker container. Here's what I did to make it happen._

> _**NOTE:** This post is not yet finished. If you're reading this, I'm still working on it right now. I published it as-is to meet a [self-imposed deadline](/posts/practice)._

As I've mentioned before, this site is [hosted from home](/posts/indiehost) and [generated using Jekyll](/posts/epoch). The machine it's being hosted on is a Mac Mini, and the actual jekyll process is [managed by a LaunchDaemon](https://github.com/cbeams/chris.beams.io/commit/5f614e68a63694b2c846f4c788dc4b8499aa196c), mainly to ensure that everything comes back up cleanly after a reboot.

This arrangement works pretty well, but I wanted to port it to Docker for several reasons:

1. It's fragile, in that it depends on specific facilities of the underlying OS. And LaunchDaemons suck to work with.
2. I actually plan to move this server away from OS X and to GNU/Linux anyway. This will be easier if the site is already containerized.
3. For reasons explained in my [last post](/posts/docker), I want to experiment with a few ideas around peer-to-peer container hosting. This site is a perfect testing ground.

The move to Docker was more of a hassle than I thought it would be. It took the better part of two days, all told. Here are the steps I took. I'm still new to Docker, so I'm sure there are better ways to do certain things. Suggestions welcome.


## Install boot2docker

Docker is based on Linux containers, which means that running Docker on any OS other than Linux is going to require a workaround.

On OS X, [boot2docker](http://boot2docker.io/) is that workaround. It installs VirtualBox and everything else you need to run a Linux virtual machine that will act as your Docker daemon. boot2docker now has a pretty polished installation experience (much appreciated), but the presence of the virtual machine just cannot be made transparent. This isn't boot2docker's fault, it's just a fact of any LXC-based solution: if you're using Docker, you should really be using Linux. Otherwise things are going to be unnecessarily painful. You've been warned.

Incidentally, [boot2docker 1.2.0](https://github.com/boot2docker/boot2docker/releases/tag/v1.2.0) was released just a few hours prior to my writing this post. I can confirm that it works as advertised. Follow the instructions at <http://docs.docker.com/installation/mac/>.


## Create an image

The next step is to create a Docker image containing everything necessary to run this site. If you're unfamiliar, check out the [relevant section](http://docs.docker.com/userguide/dockerimages/) of the Docker user guide.

To do this, I put together [the following _Dockerfile_](https://github.com/cbeams/chris.beams.io/blob/master/Dockerfile):

```sh
FROM debian:latest
MAINTAINER Chris Beams <chris@beams.io>

RUN apt-get update

# required to build certain native gem extensions depended on by
# jekyll
RUN apt-get install -y make

# required to build 'therubyracer' native gem extension
RUN apt-get install -y g++

# required to clone the site and keep it up to date
RUN apt-get install -y git

# required to listen on $HOOKPORT for update notifications requests
# from GitHub
RUN apt-get install -y netcat

# The -dev version of Ruby 1.9.1 is necessary to avoid
# "cannot load such file -- mkmf (LoadError)" error when installing
# Jekyll.
# See http://askubuntu.com/questions/305884/how-to-install-jekyll
RUN apt-get install -y ruby1.9.1-dev

# Python 3 is installed by default, but this creates a conflict with
@ the Pygments highlighting library. The solution is to install
# Python 2.7 and ensure it is available on the $PATH as `python2`.
RUN apt-get install -y python2.7
RUN ln -s /usr/bin/python2.7 /usr/bin/python2

# install the latest jekyll version (2.3.0 at time of writing)
RUN gem install jekyll

# required to avoid ExecJS::RuntimeUnavailable errors when running
# jekyll. See https://github.com/jekyll/jekyll/issues/2327
RUN gem install execjs therubyracer

# clone the site itself
RUN git clone https://github.com/cbeams/chris.beams.io.git
```

As you can see, the file is full of special instructions and tweaks necessary to get Jekyll to work properly. Getting all this right was the largest time sink.

I developed the Dockerfile iteratively by making a change and running the following commands:

    $ docker build --tag="cbeams/chris.beams.io:v2" .
    $ docker run -p 4000:4000 -p 12345:12345 -d cbeams/chris.beams.io:v2 chris.beams.io/serve.sh

As errors cropped up, I would make a change to the Dockerfile, rebuild and re-run. For convenience, I did all of this locally on my (Mac) laptop as opposed to doing it on the server.


## Share the image

Once I got the image perfected, I pushed it to [a repository](https://registry.hub.docker.com/u/cbeams/chris.beams.io/) under my (free) account at [Docker Hub](https://hub.docker.com/). Docker Hub feels in many ways like GitHub, but hosting images rather than code. Again, you can [read up on it](http://docs.docker.com/userguide/dockerrepos/) in the user guide if this is new to you.

    $ docker push cbeams/chris.beams.io

My image ended up being around 250 MB, so pushing it from my modest connection at home was a rather slow process. Fortunately, I didn't need to do so frequently.


## Pull the image

_TODO: finish writing. Everything after this sentence is a work in progress._

...

## Forward all the ports

Forwarding port from 

This is tricky. Do a screenshot.

VBoxManage modifyvm "boot2docker-vm" --natpf1 "jekyll,tcp,,4000,,4000"


## Run everything on boot

In some ways the hardest part.

For the moment, I've added /Applications/boot2docker to the startup items for the main user on this box.

But I still must manually execute the docker command.

docker run -p 4000:4000 -p 12345:12345 -d cbeams/chris.beams.io:v2 chris.beams.io/serve.sh

I'll clean this up later.


## Summary

It was actually quite a bit of trouble getting all this set up. A good deal of that was because of the trouble with VirtualBox, port forwarding, and Jekyll.

I'm looking forward to ...


## Next steps

Research monitoring resource consumption... attaching "meters" to a container. If this is possible, then I'll move on to prototyping a bitcoin micropayment channel solution.

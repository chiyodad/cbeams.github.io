---
layout: post
title: How to Create a Bitcoin Vanity Address
date: Sun Aug 24 23:59:24 +0200 2014
timestamp: 19011417
---

_Assuming you've got Docker installed, here's a simple way to generate bitcoin vanity addresses using `vanitygen`._

Usually bitcoin addresses are a pretty inscruitable series of letters and numbers, e.g.:

    1KTWiBYEQMKBZvF5MZQXYRBbfiAoLJHab6 

So-called bitcoin "vanity addresses" make this situation slightly better by leading with a more recognizable string of text, usually associated somehow with it's owner. For example, I just created the following.

    1BeamsTXoQ4rXzogaqsLR8Cgd8sf98oGGb

The process for doing this is computationally intensive, requiring the generation of hundreds of thousands or millions of address keypairs before randomly encountering one with the desired prefix.

[vanitygen](https://github.com/samr7/vanitygen) is a tool that makes quick work of this key crunching, but when I first tried to use it a few weeks ago, I had a hard time building it on OS X, and eventually just gave up.

Today, I thought I'd try again, but this time, try building vanitygen in a Docker container. This turned out to be really easy, and I've published the result as a new Docker image at <https://hub.docker.com/u/cbeams/vanitygen>.

If you're unfamiliar with Docker, you might want to take a look at my last [two](/posts/docker) [posts](/posts/dockerize-this), in which I provide a bit more introduction and background.

Assuming you already have Docker installed, this new image makes generating vanity addresses literally as simple as a single command. I created the `1Beams` address above as follows:

    $ docker run cbeams/vanitygen:v1 vanitygen 1Beams

This ran for approximately 20 minutes before it found a match (Note that I originally tried with `1cbeams`, but the extra letter increases the difficulty of a match exponentially; it would have taken many days or even weeks to find a match on my hardware!)

It completed with the following output:

    $ docker run cbeams/vanitygen vanitygen 1Beams
    Difficulty: 259627881
    Pattern: 1Beams
    Address: 1BeamsTXoQ4rXzogaqsLR8Cgd8sf98oGGb
    Privkey: 5**************************************************

The next step is importing the private key into your wallet. I use [MultiBit](https://multibit.org), and fortunately, they've published a [document explaining exactly how to do this](https://multibit.org/help_importASingleKey.html).

> **Note**: See the [description](https://registry.hub.docker.com/u/cbeams/vanitygen/) for this repository at Docker Hub for more information about security and how to verify that this image doesn't contain some private-key stealing malware.



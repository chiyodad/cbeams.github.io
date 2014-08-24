---
layout: post
title: How to Create a Bitcoin Vanity Address
date: Sun Aug 24 23:59:24 +0200 2014
timestamp: 19011417
---

_Assuming you've got Docker installed, here's a simple way to generate bitcoin vanity addresses using `vanitygen`._

Bitcoin addresses are pretty inscruitable, just a long series of letters and numbers:

    1KTWiBYEQMKBZvF5MZQXYRBbfiAoLJHab6 

So-called _vanity addresses_ make this situation slightly better by leading with a more recognizable string of text, usually associated somehow with the owner of the address. For example, I just created [this one](https://blockchain.info/address/1BeamsTXoQ4rXzogaqsLR8Cgd8sf98oGGb):

    1BeamsTXoQ4rXzogaqsLR8Cgd8sf98oGGb

The process for creating a vanity address is computationally intensive, often requiring the generation of hundreds of thousands or millions of address keypairs before randomly encountering one with the desired prefix.

[vanitygen](https://github.com/samr7/vanitygen) is a tool that makes quick work of this key crunching, but when I first tried to use it a few weeks ago, I had a hard time building it on OS X, and eventually just gave up.

Today, I thought I'd try again, but this time in the cleanroom of a Docker container. This turned out to be really easy, and I've published the resulting image at <https://hub.docker.com/u/cbeams/vanitygen>.

> _**Note:** If you're unfamiliar with Docker, you might want to take a look at my last [two](/posts/docker) [posts](/posts/dockerize-this), in which I provide a bit more introduction and background._

Assuming you already have Docker installed, this new image makes generating vanity addresses as simple as a single command. I created the address above as follows:

    $ docker run cbeams/vanitygen:v1 vanitygen 1Beams

This ran for approximately 20 minutes before it found a match (I originally tried with `1cbeams`, but the extra letter increases the difficulty of a match exponentially; it would have taken many days or even weeks to find a match!)

It completed with the following output:

    $ docker run cbeams/vanitygen vanitygen 1Beams
    Difficulty: 259627881
    Pattern: 1Beams
    Address: 1BeamsTXoQ4rXzogaqsLR8Cgd8sf98oGGb
    Privkey: 5**************************************************

The next step is importing the private key into your wallet. I use [MultiBit](https://multibit.org), and fortunately, they've published a [document explaining exactly how to do this](https://multibit.org/help_importASingleKey.html).

> **Note**: See the [description](https://registry.hub.docker.com/u/cbeams/vanitygen/) for this repository at Docker Hub for more information about security and how to verify that this image doesn't contain private-key stealing malware.

I've published my new `1Beams` address on my profiles at [Keybase](http://keybase.io/cbeams) and [Onename](https://onename.io/cbeams), but keep in mind that tying oneself to a single address is a bad idea from a privacy perspective (see my earlier [personal bitcoin address services](/posts/address) post for an idea on an alternative approach). Vanity addresses may be a reasonable solution for receiving tips or other small amounts, but if you're accepting larger sums or otherwise want to increase privacy (for both you and the sender), do create a new address for every transaction.

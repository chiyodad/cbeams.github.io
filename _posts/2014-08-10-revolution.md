---
layout: post
title: The Revolution Will Not Be Centralized
date: Sun Aug 10 19:12:22 +0200 2014
timestamp: 18990970
---

_I'll be giving [this talk](https://2014.event.springone2gx.com/schedule/sessions/the_revolution_will_not_be_centralized.html) next month in Dallas at the ninth annual [SpringOne](http://2014.event.springone2gx.com) conference. Here's the abstract and a bit about my motivation._

_*Update*, March 19th, 2015: Presentation [video](https://www.youtube.com/watch?v=kGsEJR8kAOM) and [slides](http://www.slideshare.net/SpringCentral/the-revolution-will-not-be-centralizedhow-to-build-a-blockchain-using-spring-to-develop-a-bitcoinlike-virtual-currency) are now available._

> Massive government-run data dragnets. Advertising-based "free" cloud services working against the best interests of their users. Giant, unreadable end user license agreements. It seems that everywhere we turn, the walls are closing in on individual privacy and autonomy.
>
> The situation is complex. Out of confusion and frustration, many users have already given up. Common refrains are "privacy is dead" and "I've got nothing to hide".
>
> But revolution is in the air.
>
> The internet and the web are decentralized by design. Protocols like DNS, SMTP and HTTP assume a network of peers, but during the last 15 years—our adolescence with these technologies—we have inadvertently centralized much of the internet's infrastructure. This hasn't been for nefarious purposes; it's been done out of convenience. Having a GMail account is simply much easier than running your own mail server; storing everything in the cloud is easier than maintaining your own backups. As an unintended consequence, we've made surveillance much easier and made invasive ad-based business models the norm.
>
> A growing number of technologists are working to re-decentralize the net in surprising and profound ways. Free software and innovative peer-to-peer networks play an important role in this effort, but what may prove to be the most important tool is a new one: cryptocurrency. With bitcoin, we now have a natively digital money; a cash for the web; a currency and payment network as decentralized and flexible as the rest of the internet was designed to be.
>
> At a glance, bitcoin may look like just another payment option, a fad, or a speculative bubble. On closer inspection, one begins to see that it can enable new business models by facilitating previously impossible economic incentives between peers. Once one grasps the fundamentals of cryptocurrency, one sees that its long-term implications and possibilities are as broad and deep as the internet itself.
>
> And just like the internet, bitcoin is not a panacea. It is rife with its own problems and faces its own existential threats. In this talk, Chris Beams will share his findings from over two years of research into bitcoin and related technologies: the promise and the peril; how bitcoin may be able to help create the first sustainable business models for the development of free software; how privacy may rise from the dead yet; and why the revolution will not be centralized.

I've been planning to give this talk for a few months now, but its content was originally going to be somewhat different than what you see above. Here's the original title and abstract:

> HOW TO BUILD A BLOCKCHAIN: USING SPRING TO DEVELOP A BITCOIN-LIKE VIRTUAL CURRENCY
> 
> Have you ever wondered how Bitcoin works? Beyond the price swings and sensational news events, Bitcoin offers important and practical advances in the field of distributed computing. At the heart of it all is the notion of a blockchain—a fully decentralized database that is built, validated and secured by the nodes in Bitcoin's peer-to-peer network.
> 
> This session will explore what makes Bitcoin and its blockchain tick, and will then look at possible uses of this technology in domains beyond finance. To make concrete sense of it all, we'll demonstrate a proof of concept system built from the ground up on JDK 8 and using the latest Spring technology to perform all the necessary functions of a Bitcoin-like system.

I'm sure the talk in its original form would still be interesting and valuable. But the more I worked on its content—and especially as I worked on the code—the more I realized I was operating at too low a level.

The [blockchain technology](https://bitcoin.org/en/developer-guide#block-chain) pioneered by Bitcoin is indeed extremely important, but I came to the conclusion that re-implementing a simplified version of it using Spring wouldn't necessarily be the best way to share what I've learned over the last couple years. Primarily because what I've learned is so much broader than technology alone, I realized this talk would best be delivered without code.

Bitcoin and related technologies are still young, but evolving at breakneck speed. Millions in venture capital are being poured into the space as I write. Governments are fumbling awkwardly in attempts to control it. Because the hype and FUD that result from these activities can be so damaging, I believe it's important that as many technologists as possible get a solid grasp of the fundamentals now. As this technology approaches the mainstream, it's crucial to have an educated group of professionals that know what it's for, what to do with it, and how to protect it.

My goal for this talk is that it contribute in some way, however small, to that process of education. Indeed I hope it will further my own; no doubt many SpringOne attendees will already be aware of these topics with their own ideas to contribute. I'm looking forward to Q&amp;A.

The talk's abstract leads with privacy, surveillance and our rights in the digital world. For many, this may sound like a topic generally orthogonal to Bitcoin and crypto-finance. On the contrary, I've come to see them as quite closely related. For reasons I'll detail in the talk (and possibly in additional blog posts leading up to it), I believe that Bitcoin and its emerging ecosystem may provide us with the technical means and the economic incentives to work together—directly and securely—as peers, avoiding altogether in many cases the need to trust third parties. And obscuring many of our activities from prying eyes in the process.

At 90 minutes, talks at SpringOne are longer than most conferences. I'm glad of it; these topics are nuanced and deserve to be discussed in depth. And in case you're attending and worried that without code this talk will be too high-level and hand-wavy, don't. There'll be plenty of geekery still. Because so much of what's to be discussed is new, it's simply a requirement to go into a certain amount of technical depth before being able to explore higher-order implications.

Many readers will have recognized the talk's title as a play on Gil Scott-Heron's [The Revolution Will Not Be Televised](http://lit.genius.com/Gil-scott-heron-the-revolution-will-not-be-televised-annotated). This is more than a convenient reference. The kind of revolution Scott-Heron was talking about is one that happens only with your direct participation:

> You will not be able to stay home, brother <br>
> You will not be able to plug in, turn on and cop out <br>
> You will not be able to lose yourself on skag and <br>
> Skip out for beer during commercials <br>
> Because the revolution will not be televised <br>

And we find ourselves in a similar situation. Appeals to governments, banks and internet giants to handle our money and privacy with care have not, will not, and cannot work. Our revolution will not be centralized, because those centralized organizations have no incentive to support it. A revolution in privacy and finance will be—must be—decentralized in nature. We now have the technology—though some of it still nascent—to make this happen. What we need now is education, great design, a lot of code, and most of all—participation.

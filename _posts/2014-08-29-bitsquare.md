---
layout: post
title: "Eliminating Bitcoin's Weakest Link"
date: Fri Aug 29 04:32:32 +0200 2014
timestamp: 19017450
---

_I'll be spending some of my time contributing to Bitsquare—a new peer-to-peer bitcoin exchange. Here's what it's all about and why I'm excited to participate._

<a data-flickr-embed="true" data-header="false" data-footer="false" data-context="false"  href="https://www.flickr.com/photos/lodd/5484861699/in/photolist-9mFmi2-7xTewa-5ujdkF-6z7p6Y-64VEpu-5mT2jw-pTWbc7-i8ekwq-5s9Zqv-55psD7-5hoeJf-ksN5hc-mgoNy-6uR4aC-k4Qbsk-ht2R4T-uSiHPT-9C2NNj-7BMDyX-87TrmK-7u2YrJ-d3Nkrh-omx5YS-bp4Usj-aJpyRx-8aLHN-6yngpx-n7SiWH-bAcK4M-ts1kX-oaZqfQ-sVDUhV-9wvTEV-2hSaTN-5V1ie1-9zm75H-8kLFkx-oac2qw-obDNxr-86kvLx-ovLVRx-ovjq2K-o9nkPT-otgWaN-opNYdw-omXbeM-obLbHg-ob39bi-obPKAB-oqKsiR" title="No chain is stronger then it&#x27;s weakest link"><img src="https://farm6.staticflickr.com/5100/5484861699_ca107f695f_b.jpg" width="1024" height="566" alt="No chain is stronger then it&#x27;s weakest link"></a><script async src="//embedr.flickr.com/assets/client-code.js" charset="utf-8"></script>


[Exchanges](https://en.wikipedia.org/wiki/Bitcoin_exchange#List_of_Bitcoin_Exchanges) play a critical role in the bitcoin ecosystem. Without them, it would be nearly impossible to buy or sell bitcoins for euros or dollars. Bitcoin would be a market without liquidity; bitcoin would be worthless. We need exchanges.

Unfortunately, exchanges also represent bitcoin's weakest link. [Mt. Gox](https://en.wikipedia.org/wiki/Mt._Gox) may have been the [collapse heard round the world](http://www.wired.com/2014/03/bitcoin-exchange/), but it was just one of [the many thefts and hackings of exchanges](https://bitcointalk.org/index.php?topic=576337) that continue unabated today.

This bad behavior is not surprising. Exchanges hold millions of dollars worth of customers' bitcoins, and the temptation to abscond with them is simply too great. Whether theft is initiated from inside the company or out doesn't matter; so long as people transact through third parties, the beatings will continue.

Try to prevent this bad behavior by [regulating exchanges](http://www.forbes.com/sites/realspin/2014/08/13/the-great-bitcoin-divide/) and you'll [pave a path to hell](http://letstalkbitcoin.com/the-future-of-bitcoin-exchanges/). But remove the opportunity for bad behavior by _eliminating_ exchanges and you're on the road to virtue. Bitcoin itself is decentralized. Exchanges are not—and that's the problem Bitsquare aims to solve.

<a href="http://bitsquare.io"><img src="http://i.imgur.com/z1DCj5Y.png" width="25%" align="left" style="margin: .5rem 1rem .5rem"/></a>
[Bitsquare](http://bitsquare.io) is a peer-to-peer exchange—a fully decentralized way to buy and sell bitcoin—and it's the first of its kind. Users run the Bitsquare client on their personal computer, where they can create and accept offers to buy or sell bitcoin with others. Before any funds are exchanged, the buyer and seller agree on an arbitrator who will resolve any disputes. The bitcoin being traded, along with a 10% collateral of bitcoin from each user is transferred to a [multi-signature bitcoin address](http://bitcoinmagazine.com/11108/multisig-future-bitcoin/) that serves as escrow. 

The arbitration and escrow aspects of this system are extremely important, because while one half of the funds being traded are bitcoin, and therefore easy to transfer quickly and securely, the other half are dollars, euros, or another type of fiat money, and must be transferred from one user's bank account to the other. That process takes time and cannot be controlled or verified by the Bitsquare program, so must be backed up by arbitration.

Let's look at an example.

Assume Alice agrees to buy one bitcoin (1 BTC) from Bob at the price of 500 USD. They both agree to use Charlie as an arbitrator. In order for Bob to place the offer, he puts up a 10% collateral, which in this case is 0.1 BTC. In order for Alice to accept Bob's offer, she too must put up a collateral of 0.1 BTC. When Alice accepts the offer, Bitsquare automatically transfers Bob's original 1 BTC as well as the 0.2 BTC collateral to the escrow address.

As part of the order process, Bob shares his bank account information with Alice such that she can transfer the $500 payment from her bank to his. Let's assume she's honest and initiates the transfer as expected; both Bob and Alice now wait—possibly for several days—for the bank transfer to complete. When it does, Bob indicates within the Bitsquare UI that he has recieved the payment. At this point, Bitsquare releases the funds from escrow by using both Alice and Bob's signatures to sign a transaction that transfers the 1 BTC to Alice. At the same time, the 0.1 BTC collateral payments are also returned to Bob and Alice.

But what if Alice had been dishonest, or for any other reason had failed to transfer the $500 to Bob's account? In this case, Bob asks Charlie to step in. Charlie contacts Alice and conducts an investigation. If he finds that Alice did not send the money to Bob (Alice was lying), Charlie and Bob sign a transaction that transfers Bob's 1 BTC and his half of the collateral back to his own account, while Alice's half of the collateral is transferred to Charlie as compensation for his services. If the investigation shows that Alice did in fact send the money (Bob was lying), then Charlie and Alice sign a transaction that transfers the 1 BTC to her and Charlie recieves Bob's half of the collateral instead.

At this point you probably have a dozen questions. What if Bob and Charlie conspire against Alice? How can Charlie possibly prove that Alice did or did not send the money? What if Alice does send the money, but then tells her bank to issue a chargeback later? These and many other scenarios are carefully addressed in Bitsquare's [risk analysis document](https://docs.google.com/document/d/1EFLINUOmtY1Lu2VE9GZLHKEcqLvnnPfzlu0AMyGwDN8/edit#heading=h.ce6eg5itaras). As I've gotten familiar with Bitsquare, I've been impressed at the thoughtful and elegant solutions that have been devised for many of these problems. Not everything has been worked out yet, and such a system will never be perfect. Nevertheless, there remains ample reason to believe that this system is feasible and worth building.

Bitsquare has not seen its first release yet, but as shown in the video below, tremendous progress has been made since its inception in March of this year:

<iframe width="640" height="390" src="//www.youtube.com/embed/upENHwHzqZM" frameborder="0" allowfullscreen></iframe><br/>

To date, Bitsquare has been almost entirely a one-man effort.  [Manfred Karrer](https://plus.google.com/106046176723553419722/posts) is Bitsquare's founder, and until recently its sole developer. It is remarkable how much he's been able to accomplish in just five months.

Over the last few weeks a small team has been rallying around the project, and I'm glad to be a part of it. At the moment, I'm assisting with a bit of housekeeping—build system work and the like—but am looking forward to digging in more deeply in the days to come.

<small>
_Photo Credit:_ [jopsy_daisy](https://www.flickr.com/photos/jopsydaisy/)
</small>




---
layout: post
title: Why I Host From Home
date: Mon Aug 11 23:50:24 +0200 2014
timestamp: 18992688
---

_I serve this site as well as my email and other services from a machine in my living room—the ultimate kind of indie hosting. This is why._

**Because I can.** This site is mostly text. It requires a trivial amount of bandwith to serve. For example, the [last post I wrote](/posts/revolution/) is roughly 10KB of HTML. Add the [two](/css/style.css) [stylesheets](/css/darcula.css) on that page and we have another 10.

Every viewing of that post, then, amounts to three requests and ~20KB served. I've got a cheap, unlimited and reasonably reliable ~500KB/s upstream connection. That means I can handle ~25 page views per second before I'm I/O bound. This site is new; it's lucky to get 100 page views _per day_. Somehow I think I'll be okay.

Nothing has been optimized. Were traffic to rise, I could [compress](https://en.wikipedia.org/wiki/HTTP_compression), [cache](https://en.wikipedia.org/wiki/Content_delivery_network), or [minify](https://en.wikipedia.org/wiki/Minification_programming). I haven't done any of these yet because I find the simplicity liberating. Why add any complexity until called for? Should a single reader [complain about speed](mailto:chris@beams.io), consider my mind changed. Otherwise, [optimization can wait](https://en.wikipedia.org/wiki/Program_optimization#When_to_optimize).

If there were a huge and unhandleable traffic spike, that would be OK. There's nothing life-saving or time-sensitive on this site. I won't lose money if I can't serve all requests right away; there's no advertising here and I'm not selling anything.

Should such surges become regular, well, that would be a wonderful problem. One easy way to address it would be to cache everything on the site via CDN, [including its HTML](http://blog.cloudflare.com/introducing-pagerules-advanced-caching). Remarkably, this can be done [free of charge](https://www.cloudflare.com/plans) at CloudFlare, where I already manage my DNS. A second simple solution would be to increase my upstream bandwidth. I could also move to third-party hosting; it might be well-justified by then.

My point is that I think we generally underestimate the viability of hosting a personal website and other services from home. This post is answering the question why I do it, but also posing the question why more others don't.

**Because it doesn't matter if it goes down.** My power will go out occasionally. My ISP might have an outage. I'll need to reboot my server from time to time. The site _will_ go down now and then, and has plenty of times already. So what? I don't need [five nines](https://en.wikipedia.org/wiki/High_availability#Percentage_calculation); with my current traffic I scarcely need two. And in any case, a smart CDN can help here too. Services like CloudFlare's [_always online_](https://www.cloudflare.com/always-online) cache a full copy of your site and fail over to it when you go down.

The same goes for email. SMTP is wonderfully robust in retrying message delivery if a recipient server is down<sup><a name="ref-smtp" href="#fn-smtp">1</a></sup>. Clients will typically  retry for several days before giving up completely. My server was recently down for more than a day while I was out of town. I had sent myself a number of emails during the outage. When the server came back online, I was delighted to see all my own messages, as well as a number sent by others, arriving in intervals as each client and [MTA](https://en.wikipedia.org/wiki/Message_transfer_agent) dutifully retried. I was all caught up within an hour.

**Because it's way more fun.** When I publish a post, I usually do so sitting on my couch or at my dining room table. In either case I'm not more than a few meters from the machine that will serve it. It's the same machine I use as a media center. And after I push the commit and tweet the link, there is something crazily cool about [watching people visit the site](http://vimeo.com/34909373) as I switch gears, relax and watch an episode of, say, the original [UK House of Cards](https://en.wikipedia.org/wiki/House_of_Cards_(UK_TV_series))—_playing from the very same machine on which people are now reading what I just wrote._ There is something satisfying, even _human_, about knowing that folks are pulling content right from my living room. It's like being paid a visit, digitally, by a friend. And since you're reading this right now, I have good reason to say to you: thanks for stopping by!

----

## Footnotes

<small>
<a href="#ref-smtp" name="fn-smtp">1</a>: See [RFC 2821](http://www.ietf.org/rfc/rfc2821.txt), section _4.5.4.1: Sending Strategy_
</small>

----

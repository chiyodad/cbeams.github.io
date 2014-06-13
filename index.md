---
layout: page
title: Chris Beams
---

I'm an independent software developer. I helped build [Spring](http://spring.io"), and am now focused on Bitcoin-related technology. I'm `cbeams` on [Twitter](http://twitter.com/cbeams), [GitHub](http://github.com/cbeams) and [Freenode](http://webchat.freenode.net), and you can email me at [chris@beams.io](mailto:chris@beams.io). My [PGP](http://www.bitcoinnotbombs.com/beginners-guide-to-pgp/) key is [here](/pgp.txt).

I occasionally write. Here are the last few [posts](/posts):

<ul>
  {% for post in site.posts limit:3 %}
  <li><a href="{{ post.url }}">{{ post.title }}</li>
  {% endfor %}
</ul>

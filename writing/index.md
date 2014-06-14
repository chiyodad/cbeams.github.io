---
layout: page
title: Posts
---

<ul>
  {% for post in site.posts %}
  <li><a href="{{ post.url }}">{{ post.title }}</li>
  {% endfor %}
</ul>

---
layout: page
title: Writing
---

<ul>
  {% for post in site.posts %}
  <li><a href="{{ post.url }}">{{ post.title }}</li>
  {% endfor %}
</ul>

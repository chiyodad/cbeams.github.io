---
layout: page
title: Writing
---

Things I write down, in various forms. See also the [stream](/stream).

## [/thoughts](/thoughts) <small>([RSS]({{ site.feedurl }}/thoughts))</small>
_Short form, Twitter-ish._
{% for post in site.categories.thoughts %}
 - [{{ post.title }}]({{ post.url }})
{% endfor %}

## [/articles](/articles) <small>([RSS]({{ site.feedurl }}/articles))</small>
_Longer essays and reviews._
{% for post in site.categories.articles %}
 - [{{ post.title }}]({{ post.url }})
{% endfor %}

## [/projects](/projects)/logs
_Status updates on projects I'm working on, written mostly for my benefit._
{% for post in site.categories.projects %}
 - [`{{ post.categories | join | remove: 'projects ' }}`]({{ post.dir }}) [{{ post.title }}]({{ post.url }})
{% endfor %}

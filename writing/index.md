---
layout: page
title: Writing
timestamp: 18908500
---

Things I write down, in various forms. [Subscribe to everything via RSS]({{ site.feedurl }}/atom.xml).

## [/notes](/notes) <small>([RSS]({{ site.feedurl }}/notes/atom.xml))</small>
_Short form, Twitter-ish._
{% for post in site.categories.notes %}
 - [{{ post.title }}]({{ post.url }})
{% endfor %}

## [/articles](/articles) <small>([RSS]({{ site.feedurl }}/articles/atom.xml))</small>
_Longer essays and reviews._
{% for post in site.categories.articles %}
 - [{{ post.title }}]({{ post.url }})
{% endfor %}

## [/projects](/projects)
_Status updates on projects I'm working on._
{% for post in site.categories.projects %}
 - [`{{ post.categories | join | remove: 'projects ' }}`]({{ post.dir }}) [{{ post.title }}]({{ post.url }})
{% endfor %}

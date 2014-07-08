---
layout: page
title: Projects
---

Things I'm up to.

## Current
{% for project in site.data.projects %}
{% if project.active == true %}
 - [{{ project.name }}]({{ project.path }})
{% endif %}
{% endfor %}

## Past
{% for project in site.data.projects %}
{% if project.active == false %}
 - [{{ project.name }}]({{ project.path }})
{% endif %}
{% endfor %}


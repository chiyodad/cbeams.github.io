---
layout: page
title: Projects
---

Things I'm up to.

{% for project in site.data.projects %}
{% if project.active == true %}
 - [{{ project.name }}]({{ project.path }})
{% endif %}
{% endfor %}

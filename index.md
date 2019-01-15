---
layout: home
title: Home
nav_order: 1
---

# Ethereum Classic Improvement Proposals

This is a line of intro text.

# Updates

{% for post in site.posts limit: 5 %}
<div class="row">
	<div class="small-12 columns">
        {{ post.date | date: '%B %d, %Y' }}
		<a href="{{ post.url }}"><h3>{{ post.title }}</h3></a>
	  	{{ post.excerpt }}
	</div>
</div>
{% endfor %}

# Latest ECIP Drafts

<ul>
{% assign eciplist = site.ecips | sort: "created" | reverse | limit: 5 %}
{% for ecip in eciplist %}
  <li>
    ECIP-{{ ecip.ecip }}: <a href="{{ ecip.url }}">{{ ecip.title }}</a>
  </li>
{% endfor %}
</ul>
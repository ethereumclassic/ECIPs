---
layout: page
permalink: /ecips/
title: "ECIPs"
nav_order: 3
---

This is the homepage for ECIPs that will loop through ECIPs.

---
{% comment %}<!-- Some JavaScript to make this sortable would be good -->{% endcomment %}
<table>
<tr>
  <th>ECIP #</th>
  <th>Title</th>
  <th>Author(s)</th>
  <th>Status</th>
  <th>Type</th>
  <th>Created</th>
</tr>
{% assign eciplist = site.ecips | sort: "ecip" %}
{% for ecip in eciplist %}
  <tr>
    <td><a href="{{ ecip.url }}">{{ ecip.ecip }}</a></td>
    <td>{{ ecip.title }}</td>
    <td>{{ ecip.author }}</td>
    <td>{{ ecip.status }}</td>
    <td>{{ ecip.type }}</td>
    <td>{{ ecip.created }}</td>
  </tr>
{% endfor %}
</table>


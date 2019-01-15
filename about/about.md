---
layout: page
title: About
permalink: /about/
nav_order: 2
has_children: true
---

This site is generated from the Ethereum Classic Improvement Proposal (ECIPs) GitHub repo [ethereumclassic/ECIPs](https://github.com/ethereumclassic/ECIPs).

# ECIP Metadata

The metadata associated with each ECIP is as follows. See the [template](/about/ecip-template/) page for the Markdown layout format.

1. TOC
{:toc}

## ECIP

ECIP number

## Title

ECIP title

## Author
list of authors' real names and optionally, email address

## Discussions-To

Link to a place where discussion or progress takes place. Can default to Github Issue

## Status

Draft | Active | Accepted | Deferred | Rejected | Withdrawn | Final | Superseded

<ul>
{% for status in site.data.status %}
  <li>{{ status.label }}: {{ status.description }}</li>
{% endfor %}
</ul>

Available as [status.json](/feeds/status.json)

## Type

Standards Track | Informational | Process

## Created

Date created on, in ISO 8601 (yyyy-mm-dd) format

## Replaces

ECIP number

## Superseded-By

ECIP number

## Resolution

url


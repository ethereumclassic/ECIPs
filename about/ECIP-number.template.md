---
layout: page
parent: About
permalink: /about/ecip-template/
title: Template
---

The [About](/about) page has more details on the metadata.

```
{% raw %}
---
layout: ecip
ecip: <ECIP number>
title: <ECIP title>
author: <list of authors' real names and optionally, email addrs>
discussions-To: <link to github issue or other public discussion forum>
status: <Draft | Active | Accepted | Deferred | Rejected | Withdrawn | Final | Superseded>
type: <Standards Track | Informational | Process>
created: <date created on, in ISO 8601 (yyyy-mm-dd) format>
replaces: <ECIP number>
superseded-by: <ECIP number>
resolution: <url>
---

### Abstract

### Motivation

### Specification

### Rationale

### Implementation
{% endraw %}
```


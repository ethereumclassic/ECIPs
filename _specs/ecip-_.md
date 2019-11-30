---
ecip: 1077
title: The Meta Meta ECIP: Processes for Meta ECIPs
author: Mr. Meows D. Bits
discussions-to: TBD
status: WIP
type: Meta
created: 2019-11-29T14:17:42-05:00
resolution: TBD
---

### Abstract

Forking Meta ECIPs (defined as Meta ECIPs _intended_ to specify any Standards-Core track ECIP and an activation block number) should contain only placeholder information
for ECIP-sets and block activation numbers. Placeholders for ECIP-sets and block numbers should be filled via distinct change sets before moving from `Draft` to `Last Call` status.

Changesets (eg Pull Requests) editing placeholder ECIP-set and block number information should do so with neither in isolation; PRs modifying only ECIP-set, or only block number,
are disallowed.

### Motivation

Allowing fully-formed alternative and "competing" ECIPs is logistically and practically difficult to use. Currently, our most prominently used collaboration tool, Github, does
not provide an accessible UI for comparing arbitrary documents or review separate arbitrary documents as a conceptual set.

Github does, however, provide an accessible user interface for Pull Requests (propsed change sets) against a single document.

Forking Meta ECIPs represent a single idea: The next hardfork. This is a pragramtic and common sense approach to managing blockchain protocol maintenance and upgrades. Thus, it makes
sense to use accessible and conceptually-unifying procedures for this challenge.

Incomplete proposals (changesets) are inoperable; they are not ready for review, discussion, nor implementation.

Unique proposals save time and redundant complexity.

Related to and derivative of:

- https://github.com/ethereumclassic/ECIPs/issues/217
- https://github.com/ethereumclassic/ECIPs/issues/215
- https://github.com/ethereumclassic/ECIPs/issues/175
- https://github.com/ethereumclassic/ECIPs/issues/131
- https://github.com/ethereumclassic/ECIPs/issues/177
- https://github.com/ethereumclassic/ECIPs/issues/135
- https://github.com/ethereumclassic/ECIPs/pull/218
- https://github.com/ethereumclassic/ECIPs/pull/212
- https://github.com/ethereumclassic/ECIPs/pull/207
- https://github.com/ethereumclassic/ECIPs/pull/214
- https://github.com/ethereumclassic/ECIPs/pull/199
- https://github.com/ethereumclassic/ECIPs/pull/196

### Specification

A Forking Meta ECIP is defined as a Meta ECIP specifying any (`n >= 1`) Standards-Core track ECIP or ECIP-set. A Forking Meta ECIP should be conceptally complete and unique (_next hardfork_ suffices for uniqueness, since there can only be one).

_Complete_ is defined as being fully and totally definitive; not lacking anything.

_Unique_ means not the same as another thing; in this case, not precisely duplicating any existing ECIP.

This proposal specifies that all Forking Meta ECIPs in `Draft` state or earlier should contain NO information about ECIP-sets or block activation numbers (all `TBD`). Proposed specifications to fill these placeholders should be made in the form of distinct and separate propsed change sets (eg Github Pull Requests) to the Forking Meta ECIP document. The changesets are required to be UNIQUE and COMPLETE.

### Rationale

The sole purpose of a Forking Meta ECIP is to join a block number with a set of `n >= 1` ECIPs containing protocol-facing changes. The document says "_These_ features will activate at _this_ moment."

0. "Shell" format Forking Meta ECIPs represent a clear, albeit abstract, idea: The blockchain's next hard fork.

1. __Demanding fully-formed Forking Meta ECIP Changeset proposal forces authors, editors, and reviewers to evaluate and document ECIP-set behavior and enables concrete discussion of feature sets as complete wholes.__ A Forking Meta ECIP Changeset may represent a plurality of features, and so in order to be an _operable_ specification it should not represent an ambiguous set. Sets of ECIPs can have interoperative dependencies and outcomes; this causes a conceptual permutation and combination challenge when attempting to design a set of ECIPs for simultaneous inclusion. 

2. __Forking Meta ECIP Changesets without block numbers lack operability.__ Activation numbers _are specifications_ and should not be treated as a second class or at-convenience citizens. Implementation timelines are importantly related variables to their adjacent ECIP-sets (large set ostensibly require long timelines, hotfix sets require short ones.) We cannot reason about them in isolation.

3. __Concrete things are easier to build language and reasoning around.__ Nuances of interoperations are documented and included in concrete proposals, leaving less theoretical abstract reasoning to manage, which is relevant in the context of group _and_ individual decision making. "Competing" Forking Meta ECIP Changeset alternatives become explicit and standardized, yielding conceptual and communicable clarity in review processes and decision-making processes.

### Implementation

A Forking Meta ECIP may only achieve `Last Call` status once a Changeset has been accepted and all other alternative marked as `Deferred`, `Withdrawn`, or `Rejected`.

This proposed procedure makes only marginal and changes, demanding only that what was taken as implication, subtext, or context before now be made explicit. Rather than reviewing actual-or-theoretical proposed changesets to an ECIP (which sadly, have historically usually been theoretical), this forces proposed Forking Meta ECIP alternative outcomes to assume a fully qualified and standardized formats before becoming eligible for consideration. 

### Copyright/Licensing

MIT.

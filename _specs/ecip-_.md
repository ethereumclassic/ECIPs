---
ecip: TBD
title: The Meta Meta ECIP: Processes for Meta ECIPs
author: Mr. Meows D. Bits
discussions-to: TBD
status: WIP
type: Meta
created: 2019-11-29T14:17:42-05:00
resolution: TBD
---

### Abstract

Forking Meta ECIPs (defined as Meta ECIPs specifying any Standards-Core track ECIP) should be complete and unique.

### Motivation

Incomplete proposals are inoperable; they are not ready for implementation.

Definite proposals are inoperable; they are not ready for implementation.

Unique proposals saves me time because I don't have to read the same thing twice.

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

A hard fork specification is documented as a Meta ECIP, and usually represents a collection of adjacent ECIPs. The sole purpose of a Forking Meta ECIP is to join a block number with this set of `n >= 1` ECIPs containing protocol-facing changes. The document says "_These_ features will activate at _this_ moment."

This proposal specifies that all Forking Meta ECIPs should be COMPLETE and UNIQUE; essentially disallowing `Draft` status Forking Meta ECIPs and and/or meaningful revisions (set ECIPs, block number). A valid Forking Meta ECIP must contain a full and complete set of to-be included ECIPs, and a definitive block number. 

_Complete_ is defined as being fully and totally definitive; not lacking anything.

_Unique_ means not the same as another thing; in this case, not precisely duplicating any existing ECIP.

### Rationale

0. Forking Meta ECIPs are themselves ECIPs, and their job is to define, with certainty and clarity, technical specifications. Forking Meta ECIPs that essentially leave either field `Block number` and/or field `ECIP set` blank are functionally useless; they say only: "Will have some fork at some time." An analogue of blankness to non-Forking-Meta ECIPs would essentially say "TODO: put my next awesome feature specification here." Fill-in-the-blank ECIPs are not in good form.

1. A Forking Meta ECIP may represent a plurality of features, and so in order to be an _operable_ specification it should not represent an ambiguous set. Sets of ECIPs can have interoperative dependencies and outcomes; this causes a conceptual permutation and combination challenge when attempting to design a set of ECIPs for simulateous inclusion. Demanding fully-formed Forking Meta ECIP proposals forces authors to evaluate and document ECIP-set behavior and enables concrete discussion of feature sets as complete wholes.

2. Forking Meta ECIPs without block numbers lack operability. Activation numbers _are specifications_ and should not be treated as a second class or at-convenience citizens. Implementation timelines are importantly related variables to their adjacent ECIP-sets (large set ostensibly require long timelines, hotfix sets require short ones.) We cannot reason about them in independence.

3. Concrete ECIPs are easier to reason about. Nuances of interoperations are documented and included in concrete proposals, leaving less theoretical abstract reasoning to manage, which is relevant in the context of group _and_ individual decision making.

### Implementation

A Forking Meta ECIP may not be in `Draft` status. It may not undergo any meaningful changes once receiving `Last Call` status (its next status beyond `WIP`).

### Copyright/Licensing

MIT.

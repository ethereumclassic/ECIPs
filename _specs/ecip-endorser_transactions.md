---
ecip: 1105
title: Endorser Transactions
lang: en
author: Isaac (@meowsbits)
discussions-to: https://github.com/ethereumclassic/ECIPs/issues/423
status: Draft
type: Informational
created: 2020-09-04
---

## Simple Summary

Describes a practice enabling chain discretion based on endorsements by verifiable identities.

## Abstract

Provide a way for node operators to prefer an arbitrary chain segment, and to use that preference to thwart bad guys.

## Motivation

A low hash rate has caused Ethereum Classic's consensus algorithms to yield inconvenient and undesirable finality rates.

This proposal describes a method for collective chain discretion which is currently achievable, avoiding any required modifications to existing consensus protocol.

## Specification

Transactions are included in chain state which signal an identity-verifiable endorsement.

Such transactions can be observed and acted upon in case of chain identification and discretion challenges.

### Endorser Transactions

Transactions are made by an endorsing entity including information in the `data` field referencing the block hash (or some other unique characteristic) of some endorsed ancestor block.

The construction of this value could be of the form `0xff<block hash>`.

### Endorsement Observation

A node registers some list of trustee entities from whom they wish to acknowledge endorsements.
These entities are encoded as transaction author identities (sender address, `from`).

Transactions with a `data` field value matching the general pattern described above are filtered from the set of on-chain transactions.
This set of filtered transactions are filtered again for positive matches against the local list of trustee authors.

Chain segments with positive matches for trustee endorsements are preferred in case of chain discretion challenges.

## Rationale

The identity of an endorser transaction authorship is verifiable because transaction validity depends on valid signing.

## Backwards Compatibility

There are no known backward compatibility issues.

## Security Considerations

### Costs of Implementation

For miners acting as endorsers, the cost of including an endorsement transaction is equal to the opportunity cost of a replacing the transaction authored by anyone else.
If block space competition is incomplete (an unfilled block), the transaction is free (aside from the nominal cost of CPU processing to generate the transaction).

In the general case, the cost of creating an endorsing transaction is equal to cost of that transaction in gas fees.

The cost of observation of such transactions is expected to be programmatically nominal.

### Trustee Sociology and Incentives

It is expected that "followers" subscribing to endorsements should limit their set of trustees to a minimum, subscribing only to the most trustworthy and staked entities; risk of betrayal by any one of an observer's trustees should be met with commensurate risk management.

It should be expected that trustee lists would be kept private for any given observing node.

In practice, a handful of sufficiently large miners should be expected to comprise the universal set of distinct trustees.

### Discretion Challenges

Discretion challenges can be generally understood as any case where a node's view of blockchain state warrants their suspicion.
The programmatic or analogue execution of such deliberation is subjective, and not discussed in this document.

### Is this Proof-of-Authority?

No. Proof of Authority networks use identity authorization as a condition of block production. The endorsement transactions pattern offers a way for node operators to have a _choice of trustee_ when their node is faced with tough decisions.

The cases in which these decisions would occur have been such that a pure proof-of-work consensus is at odds with social benefit. This approach intends to provide a tool whereby node operators can express and observe an aspect of the social and economic context, at the behest of the node operator.

### How is this different than other "Checkpoint" solutions?

This solution does not offer any canonical checkpoint, nor any means of establishing one. Most checkpointing solutions do this.

This solution does not rely on any single oracle or oracles, whereas most checkpointing solutions look to core developers, adjacent networks, or hardcoded values for sources of truth. Instead, this solution offers an existing way for node operators to express and observe chain preference. The ultimate impact of the feature on the network remains strictly in the hands of the operators.

## Copyright/Licensing

Copyright and related rights waived via
[CC0](https://creativecommons.org/publicdomain/zero/1.0/).

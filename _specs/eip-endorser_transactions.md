---
ecip: TBD
title: Endorser Transactions
lang: en
author: Isaac <b5c6@protonmail.com>
discussions-to: TODO
status: Draft
type: Standards Track
category: ECBP
created: 2020-09-04
license: Apache-2
---


## Abstract

Provide a way for node operators to prefer an arbitrary chain segment, and to use that preference to thwart bad guys.

## Motivation

A low hashrate has caused Ethereum Classic's consensus algorithms to yield inconvenient and undesirable finality rates.

The motivation of this proposal is to achieve a solution that alleviates a slow finality curve, while creatively managing the effects of tampering with existing "hard" consensus protocols.

## Specification

A. Provide a feature -- either as `geth` options (as exemplified below), or via a standalone program -- facilitating the creation of intermittent transactions to the (subjectively) canonical blockchain, recording an entity's endorsement of it.

B. Provide a feature in `geth` facilitating the reference of these transations as parameters for use in chain segment acceptance arbitration given a reorg of some size.

### Example

_This example, for the sake of descriptive simplicity, details the installation of the proposed features as built-in to `geth`. It is, however, more likely that the feature would be best implemented by a dedicated endorsement-transaction program that would run adjacent to some `geth`; retrieving chain data from it, signing transactions with an arbitrary signing program (eg `clef` or `jade-signer`), and subsequently sending signed transactions to `geth` for chain inclusion._

Provide a flag `--endorsing.signers=<0xaddressA>,<0xaddressB>` that is empty (deactivated) by default.

Provide a flag `--endorsing.threshold=<number>` that is 0 (deactivated) by default.

If either of these flag values is empty, node behavior is defaulty; ie. both flags must be set with non-zero values for behavior to be modified.

Provide a flag `--endorsing.signer=<0xsignerAddress>` that is empty (deactivated) by default. If set, this value is used to sign transactions that may be relied on for determining chain preference. Although operators may use any key for this value, they would be encouraged to use a key which IS NOT their etherbase for practical security reasons.

Provide a flag `--endorsing.signerpass=</path/to/passfile.txt>` that is empty (disabled) by default. This value will be used to unlock the key required for signing.

Provide a flag `--endorsing.txinterval=<number>` that is empty (disabled) by default. If set, this value will be used to determine the frequency endorsing transactions should be sent.

If any of these flag values is empty, node behavior is defaulty; ie. both flags must be set with non-zero values for behavior to be modified.

If these values are configured, the node will sign and send a transaction signed by their `endorsing.signer` key at the specified interval.

The transactions should take the form:

```
from: <endorsing.signer>
to: <endorsing.signer>
data: 0x<paddedBlockNumber><blockHash>
```

_The specification here is not (yet) firm. The important part is that some impossible-to-forge but easily-verifiable characteristics of the endorsed chain are included and publicly observable._

Nodes would not need to normally validate endorsements against their chain view, doing so only in the event of a large reorg (ie. deeper than `endorsing.threshold`).

In the event of a sufficiently large reorg, proposed blocks may be validated to have been endorsed (asserted) by signers by iterating through the transactions in the proposed (new) segment, filtering on `tx.from == tx.to && endorsing.signers.contains(tx.from)`, and, if a matching transaction is found, verifying the included (parsed) reference data against the incoming proposed segment. If the segment is found to contain the asserted characteristics, the segment would be accepted. In case no truthy value is found, the segment is either rejected or passed on for further arbitration.


#### Generic

Reorganization depth may be determined concretely or stochastically.

In the concrete case, it may be measured as a distance from a node's current head. In the stochastic case, it may be determined _ala_ PERMAPOINTING.

#### Specific (Proposed)

For reorganizations of depth greater than `endorsing.threshold`, nodes having this configuration activated require chain segments to contain _at least one_ block signed by _any_ of the given `endorsing.signers`.

In the case of Ethereum Classic, especially miners on the network would be encouraged to use these flags. Further, they would be encouraged to keep the value they choose for `endorsing.threshold` private, and to choose a hard-to-guess value that they feel reflects their desired risk/finality profile.

## Rationale

This idea intends to make existing, but chain-view-tacit, social and economic relationships available for observation and use on chain. Its implementation would not require a hard fork; it only uses existing features of the Ethereum Classic chain in as-yet unconventional ways.

This proposal allows node operators to make their own decisions about the role of trust _relative to themselves_ on the PoW chain, avoiding reliance on developers or other authority entities to make decisions about endorsements or canonical-status on behalf of the network.

Node operators are incentivized to aggressively limit their endorsement-delegation, thereby limiting their exposure to betrayal (relative to the majority).

Node operators would be encouraged to limit their endorsement-delegation to themselves and to only those they deem absolutely and necessary trustworthy.

Mining node operators are incentivized to implement endorsements, since it provides a way for them to
- prefer chains on which they have mined over those they have not
- prefer chains they believe _will_ be mined, over those they consider less likely (or socially/economically desirable) to become canonical

Further, for miners, the endorsement transactions -- aside from additional technical overhead -- can be made for free.

### FAQ

##### Is this Proof of Authority?

No. Proof of Authority networks use entity (or identity...) authorization as a condition of block production. Endorsed transactions offers a way for node operators to have a _choice of authority_ when their node is faced with tough decisions.

The cases in which these decisions would occur have been such that a pure proof-of-work consensus is at odds with social consensus. This approach intends to provide a tool whereby node operators can express and observe an aspect of the social and economic context, at the behest of the node operator.

This solution leaves as much of the "human arbitration" as possible in the hands of node operators as sovereign, democratic actors. 

##### How is this different than other "Checkpoint" solutions?

This solution does not offer any canonical checkpoint, nor any means of establishing one. Most checkpointing solutions do this.

This solution does not rely on any single oracle or oracles, whereas most checkpointing solutions look to core developers, adjacent networks, or hardcoded values for sources of truth. Instead, this solution offers a tool that _allows_ node operators to express and observe chain preference. The ultimate impact of the feature on the network remains strictly in the hands of the operators.

## Copyright/Licensing

Copyright 2020 Isaac A. \<b5c6@protonmail.com\>

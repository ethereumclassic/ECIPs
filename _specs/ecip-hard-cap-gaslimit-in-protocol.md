---
lang: en
ecip: Unassigned
title: Hard-cap gas-limit in protocol
author: Bob Summerwill (@bobsummerwill)
status: Draft
type: Standards Track
category: Core
created: 2020-01-17
license: Apache-2.0
discussions-to: https://github.com/ethereumclassic/ECIPs/issues/174
---

## Abstract

A proposal to place a hard cap on the gaslimit for the ETC mainnet as an in-protocol
consensus rule. From the block that this ECIP was activated, gaslimit would follow a
curve defined in this proposal rather than being subject to miner voting.

## Rationale

There is nothing more important to the ETC network than security and decentralization.
Both of those desired characteristics have already been heavily compromised in ETC
because of the malincentives which ETC inherited from ETH in the form of the miner
gaslimit voting mechanism.

The gaslimit has been raised for the ETH mainnet first to 8M and then to 10M gas,
despite it being obvious that the client implementations cannot adequately cope with
the state trie growth that such a high gaslimit has created.  ETH has been
"overclocked" and smoke is coming out of the engine.  This long crisis was one of the
primary motivations for the ETH 1.x initiative which started around DEVCON4 in Prague
in October 2018.  The crisis on ETH is still ongoing and still unresolved and is
affecting ETC too as well now.

The miner gaslimit voting is one-sided.  There are no checks-and-balances.  There is no voice
for the end-users who care about the long-term health of the network.  There is only
a single "control knob" and the miners have control of that "control knob".  They are
incentivized to vote the limit up to infinity, because fees rise if they do so.
Like over use of credit cards, the bill comes much later as a consequence of growth of the state
trie which makes it harder and harder to run a full node.  For Ethash miners with
GPUs or FPGAs there is little consequence for them "killing the host".  They can just
exit and go and mine some other coin if ETH or ETC become completely centralized and
unusable because of state bloat.

This malincentive has played out for ETH such that the ETH state tie is now so large
that full-sync-from-genesis is completely impractical and the disk usage is off the
charts for full nodes, let alone for archival nodes.  Fully validating syncs for
ETH nodes are now a multi-month process.

Here is a recent example from Jeff Garzik on 15th January 2020 (it took him nearly 2 months):

https://twitter.com/jgarzik/status/1217488290900848640

Sync'd!

- Ethereum --syncmode=full node:
- Laptop w/ 8G ram, external 1TB USB 3.1 SSD
- Started: November 26, 2019
- Finished: January 13, 2020
- Storage used: 668G
- Docker container restarts, for hard fork geth upgrades: 2

ETH is completely reliant on Infura now and it is well known
(how serious a problem)[https://www.coindesk.com/the-race-is-on-to-replace-ethereums-most-centralized-layer]
that dependency on a single centralized and proprietary service provider is.

(Anthony Lusardi)[https://twitter.com/pyskell] proposed an appeal to the ETC miners to
voluntarily vote the gaslimit down to 1M in March - (ECIP-1047)[https://ecips.ethereumclassic.org/ECIPs/ecip-1047]
but that appeal has never happened, though might soon.  A voluntary solution would
be a step in the right direction in terms of the effects, but it does not solve the
root issue which is the malincentive of the miner vote.

A protocol change to set a hard-cap would resolve the unsustainability issue for
ETC and bring the protocol into alignment with ETC philosophy, rejecting this bad
inheritance from ETH and back in line with Bitcoin's sustainable approach.
Unlike BTC however, we would define a long-term growth curve to reflect the
constantly improving hardware - even with the same protocol and same client
implementations.


## Specification

At block number ACTIVATION_BLOCK on ETC mainnet, switch the gas-limit calculation
to be one of the following two options:

1. gaslimit = INITIAL_GASLIMIT + (block_number - ACTIVATION_BLOCK) * GASLIMIT_CURVE_RATE
2. gaslimit = INITIAL_GASLIMIT + (block_number - ACTIVATION_BLOCK) * 2 ^ GASLIMIT_CURVE_RATE

Let ACTIVATION_BLOCK = TBD
Let INITIAL_GASLIMIT = 2,000,000 (subject to change)
Let GASLIMIT_CURVE_RATE = TBD


## Backwards compatibility

There is certainly a concern that some smart contracts which used to work will cease
to work (until some future point where the raising gaslimit makes them viable again)
and we need to quantify this risk.

There is a concern that it will not be possible to migrate ETH smart contracts to ETC
because of the lower gaslimit.  Straw polls on Twitter seem to indicated that 1M or 2M
is adequate for most smart contracts out there for their heaviest transactions with the
sole exception of transactions for contract deployment, which can hit 4M or more.  In
that case we have no answer yet other than spliting contracts up into multiple libraries.

It looks like some kind of "Webpack for Solidity" would be workable, where we could add
opcodes to deploy chunks of bytecode across several transactions, with new opcodes for
START_DEPLOY, DEPLOY_CHUNK and END_DEPLOY or similar which could be used transparency
internal to the development framework (Truffle, Embark, Brownie, etc) and
compiler (SOLC, SOLL, Vyper, etc) to generate different bytecode depending on the
gaslimit of the target chain.   This is just an idea for the time being and needs its
own new ECIP too.

Aragon is probably the perfect guinea pig for addressing these concerns because they have
large smart contracts and have just recently been the victim of backwards-compatibility
breaks in ETH as part of the Istanbul HF.  If we can provide a great story for ETH to ETC
migration with well engineered changes spanning frameworks, compiler and runtime then
that will be a delightful win-win for all parties.  As Jorge said, while breaking smart
contracts up is the right thing to do, it should not be REQUIRED.  To require changes
to existing script is a break in the implicit social contract:

https://www.coindesk.com/ethereums-istanbul-upgrade-will-break-680-smart-contracts-on-aragon


### Implementation

There is no implementation of this proposal yet because we are missing the specific details
of the future gaslimit curve.  That could either be linear growth or Moore's Law style
exponential growth.

The ETC Cooperative will fund implementations of this ECIP for Hyperledger Besu,
Parity-Ethereum and MultiGeth, including testnets and audits as required.


## Copyright

This work is licensed under the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).  The author, Bob Summerwill, attests to his sole authorship of this work, and that he is able to contribute this work to the ECIP process under the Apache 2.0 licence.

He further attests that he neither holds nor is aware of any patents, trademarks, copyright issues or other IP hinderances associated with this work.

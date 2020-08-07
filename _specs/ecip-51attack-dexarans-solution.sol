---
lang: en
ecip: ?
title: 51% attack solution: private mining rejection
status: Draft
type: Core
discussions-to: https://github.com/ethereumclassic/ECIPs/issues/328
author: Dexaran (dexaran@callisto.network)
created: 2020-07-08
license: LGPL-v3
---

# Abstract

The following describes a method of preventing a 51% attack on Ethash-based POW chains.

# Motivation

Ethereum CLassic suffered a number of 51% attacks already. [Here](https://cointelegraph.com/news/is-etc-102-screwed-after-second-51-attack) you can find an article from Cointelegraph describing the 51% attack on 6 Aug 2020. [Here](https://cointelegraph.com/news/ethereum-classic-51-attack-the-reality-of-proof-of-work) you can find another article describing the 51% attack on 10 Jan 2019. As long as ETC protocol remains unchanged it is susceptible for more 51% attacks.

# Specification

Basically a 51%-attack is a consensus mechanic flaw. Currently the nodes follow a rule of "the longest chain is always the right chain" however this is not what the chain users actually need in reality.

In reality a chain where all the important entities are (i.e. bootnodes, exchange nodes, mining pool nodes, block explorer nodes etc.) remaining in consensus is the right chain. Here we rely on an assumption that this "right chain" is always in a more-or-less consensus state. This means that some independant parties may be lagging slightly (in case these are not yet synced with the whole chain's last block) or outracing the rest of the chain participants slightly (in case they are physically closer to the node which has found the latest block).



# Rationale

...

# Backwards Compatibility

Requires hardfork.

# Implementations

...

# Copyright

This ECIP is licensed under [GNU Lesser General Public License v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html).

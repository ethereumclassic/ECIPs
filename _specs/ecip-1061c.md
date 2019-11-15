---
lang: en
ecip: 1061c
title: Aztlán EVM and Protocol Upgrades (Xichun Edition)
status: Draft
type: Meta
author: Wei Tang (@sorpaas)
created: 2019-11-14
discussions-to: https://github.com/ethereumclassic/ECIPs/issues/81
license: Apache-2.0
---

### Simple Summary

Enable the outstanding Ethereum Foundation _Istanbul_ network protocol
upgrades on the Ethereum Classic network in a hard-fork code-named
_Xichun_ to enable maximum compatibility across these networks.

In particular, enables account versioning EIP-1702.

### Abstract

Add support for a subset of protocol-impacting changes introduced in
the Ethereum Foundation (ETH) network via the _Istanbul_ hardforks.

This document proposes the following blocks at which to implement
these changes in the Classic networks:

- `TBD` on Mordor Classic PoW-testnet (Feb 5th, 2020)
- `TBD` on Kotti Classic PoA-testnet (Feb 12th, 2020)
- `TBD` on Ethereum Classic PoW-mainnet (March 25th, 2020)

For more information on the opcodes and their respective EIPs and
implementations, please see the _Specification_ section of this
document.

### Motivation

To enhance the Ethereum Virtual Machine's (EVM) capabilities, various
opcodes shall be added to the Ethereum Classic networks, all of which
have been in use on the Ethereum Foundation networks since end of
2019.

This enables all Istanbul features, feature gated under ECIP-1702 /
EIP-1702.

### Specification

Enable
[ECIP-1040](https://ecips.ethereumclassic.org/ECIPs/ecip-1040). Freeze
features on version `0`. Define a new account version `1`, with the
following additional EIPs enabled:

- [EIP-152](https://eips.ethereum.org/EIPS/eip-152): Add Blake2
  compression function `F` precompile
- [EIP-1108](https://eips.ethereum.org/EIPS/eip-1108): Reduce
  alt_bn128 precompile gas costs
- [EIP-1344](https://eips.ethereum.org/EIPS/eip-1344): Add ChainID
  opcode
- [EIP-1884](https://eips.ethereum.org/EIPS/eip-1884): Repricing for
  trie-size-dependent opcodes
- [EIP-2028](https://eips.ethereum.org/EIPS/eip-2028): Calldata gas
  cost reduction
- [EIP-2200](https://eips.ethereum.org/EIPS/eip-2200): Rebalance
  net-metered SSTORE gas cost with consideration of SLOAD gas cost
  change

### Implementation

Adoption of the content of this ECIP requires a hard fork as it
introduces changes that are not backward compatible.

The following clients with Ethereum Classic support implement the
_Istanbul_ features and ECIP-1040 / EIP-1702 currently:

- Parity Ethereum
- Multi-Geth

The following clients implement _Istanbul_ features but does not yet
support ECIP-1040 / EIP-1702:

- Hyperledger Besu

## Copyright

This work is licensed under [Apache License, Version
2.0](http://www.apache.org/licenses/).

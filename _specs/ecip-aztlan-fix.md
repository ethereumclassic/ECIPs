---
lang: en
ecip: Unassigned
title: Phoenix EVM and Protocol Upgrades
author: Bob Summerwill (@bobsummerwill)
status: Draft
type: Meta
created: 2020-01-19
license: Apache-2.0
discussions-to: TBD
---

### Simple Summary

This ECIP describes a hard-fork which would occur at the same block as
[ECIP 1061: Aztlán EVM and Protocol Upgrades (Yingchun Edition)](https://ecips.ethereumclassic.org/ECIPs/ecip-1061) to "fix" two issues with ECIP-1061 where the written specification
did not match the original intent.


### Abstract

The network participants who took part in the ETC Core Developers call on xx/xx/xx were under the
impression at the time that the scope we agreed ("Instanbul without the backward-compatibility
breaking parts of EIP-1884") - ECIP-1061 / ECIP-1072 - would move the ETC protocol to a place where
it was 100% compatible with the ETH mainnet.

[Wei Tang](https://github.com/sorpaas)'s implementation of ECIP-1061 shortly afterwards revealed
two flaws in the specification, together with recommendations on how to address those shortcomings.

This ECIP codifies those recommendations.

Both hard-forks would be activated at the same block and the combination of both sets of changes
would result in protocol changes which met the original intent.


### Specification

This document proposes the following blocks at which to implement these changes in the Classic networks:

- `778_507` on Mordor Classic PoW-testnet (Feb 5th, 2020)
- `2_058_191` on Kotti Classic PoA-testnet (Feb 12th, 2020)
- `10_500_839` on Ethereum Classic PoW-mainnet (March 25th, 2020)

After HARD_FORK_BLOCK, apply the following changes:

- Disable [EIP-2200](https://eips.ethereum.org/EIPS/eip-2200)
- Enable [EIP-1283](https://eips.ethereum.org/EIPS/eip-1283) with [EIP-1706](https://eips.ethereum.org/EIPS/eip-1706) instead.
- Enable [https://specs.corepaper.org/50-selfbalance50-SELFBALANCE
- Enable [50-SELFBALANCE](https://specs.corepaper.org/50-selfbalance) - TODO - create an ECIP for this.


### Rationale

[ECIP 1061: Aztlán EVM and Protocol Upgrades (Yingchun Edition)](https://ecips.ethereumclassic.org/ECIPs/ecip-1061) as defined is "broken" and it would be inadvisable to activate on the ETC mainnet in
its current state.

Two better options are:

1. "fix it" and proceed on the existing timeline, if there is enough time to do that.
2. Withdraw it and build consensus for a new HF on a more conservative timeline.


### Implementation

Adoption of the content of this ECIP requires a hard fork as it introduces changes that are not backward compatible.

The following clients with Ethereum Classic support implement the _Istanbul_ features currently:

- Parity Ethereum
- Multi-Geth
- Hyperledger Besu

The author is unaware if any of these clients have implemented [EIP-1706](https://eips.ethereum.org/EIPS/eip-1706), but it is a very simple change, analogous to [EIP-2200](https://eips.ethereum.org/EIPS/eip-2200), which all the
codebases have already implemented.

Similarly [50-SELFBALANCE](https://specs.corepaper.org/50-selfbalance) has not been implemented in any of these
codebases, but is just a "remix" of code which they have already implemented.


## Copyright

This work is licensed under the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).  The author, Bob Summerwill, attests to his sole authorship of this work, and that he is able to contribute this work to the ECIP process under the Apache 2.0 licence.

He further attests that he neither holds nor is aware of any patents, trademarks, copyright issues or other IP hinderances associated with this work.

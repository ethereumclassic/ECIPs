---
ecip: ?
title: Elysium Basefee Split Routing
lang: en
author: Daniel Tocila
status: Draft
type: Standards Track
category: Core
created: 2026-03-11
license: Apache-2
---

## Abstract

This ECIP activates the fee market changes specified in [EIP-1559](https://eips.ethereum.org/EIPS/eip-1559) and the `BASEFEE` opcode specified in [EIP-3198](https://eips.ethereum.org/EIPS/eip-3198) on Ethereum Classic.

Unlike Ethereum (where `BASEFEE` is burned), this ECIP routes `97%` of the protocol-collected `BASEFEE` amount to the block beneficiary and `1%` each to deterministic addresses for Core ETC, ETC Grants, and logtrees.

## Simple Summary

Elysium provides modern fee-market compatibility for ETC while preserving Proof-of-Work and fixed issuance.
Miner `priorityFee` remains payable directly to block producers.
The `BASEFEE` portion is split so that block producers receive `97%`, while Core ETC, ETC Grants, and logtrees each receive `1%` through deterministic protocol-routed addresses.

## Motivation

Ethereum Classic benefits from execution-layer compatibility with the broader EVM ecosystem.
If ETC activates London-style fee market behavior, it must also choose how `BASEFEE` is handled.

Elysium proposes a miner-aligned productive revenue-routing model: most protocol revenue remains with the block producer, while three small deterministic shares are routed to Core ETC, ETC Grants, and logtrees.

## Specification

This ECIP:

- Activates [EIP-1559](https://eips.ethereum.org/EIPS/eip-1559) on Ethereum Classic.
- Activates [EIP-3198](https://eips.ethereum.org/EIPS/eip-3198) on Ethereum Classic.
- Routes `97%` of `BASEFEE`-denominated fee revenue to the block beneficiary and `1%` each to deterministic addresses for Core ETC, ETC Grants, and logtrees (instead of burning it).
- Preserves direct miner receipt of `priorityFee`.
- Preserves ETC monetary policy and issuance schedule (no changes to block subsidy or issuance).
- Excludes Proof-of-Stake-specific features.

### Activation

Activation block numbers are **TBD** pending coordination and testnet deployment.

- **Mordor**: TBD
- **Ethereum Classic Mainnet**: TBD

### Elysium Routing Addresses

Let the following addresses be agreed upon prior to activation.

- `ELYSIUM_CORE_ETC_ADDRESS`: **TBD**
- `ELYSIUM_ETC_GRANTS_ADDRESS`: **TBD**
- `ELYSIUM_LOGTREES_ADDRESS`: **TBD**

This ECIP does not require code to exist at any of these addresses at the activation block. If no code is present, an address behaves as a normal EOA-style account for balance accounting purposes (i.e., it can still accrue balance).

### Consensus Rules

Clients MUST implement EIP-1559 and EIP-3198 as specified, with the sole Ethereum-Classic-specific modification described below.

#### BASEFEE split routing (ETC-specific modification)

Where EIP-1559 specifies that the `BASEFEE` portion of transaction fees is burned, clients MUST instead split that amount between the block beneficiary and the deterministic addresses for Core ETC, ETC Grants, and logtrees.

Informally, for each transaction $i$ in a block with gas used $g_i$ and block base fee $b$ (in wei per gas), define:

$$
\text{basefee\_revenue} = \sum_i g_i \cdot b
$$

Then define:

$$
\text{core\_etc\_share} = \left\lfloor \frac{\text{basefee\_revenue}}{100} \right\rfloor
$$

$$
\text{etc\_grants\_share} = \left\lfloor \frac{\text{basefee\_revenue}}{100} \right\rfloor
$$

$$
\text{logtrees\_share} = \left\lfloor \frac{\text{basefee\_revenue}}{100} \right\rfloor
$$

$$
\text{miner\_basefee\_share} = \text{basefee\_revenue} - \text{core\_etc\_share} - \text{etc\_grants\_share} - \text{logtrees\_share}
$$

Any remainder produced by integer division MUST remain with the block beneficiary through `miner_basefee_share`.

Then the post-state transition for the block MUST include, in addition to normal `priorityFee` handling:

- `balance[block.beneficiary] += miner_basefee_share`
- `balance[ELYSIUM_CORE_ETC_ADDRESS] += core_etc_share`
- `balance[ELYSIUM_ETC_GRANTS_ADDRESS] += etc_grants_share`
- `balance[ELYSIUM_LOGTREES_ADDRESS] += logtrees_share`

All other EIP-1559 behaviors remain unchanged, including:

- `BASEFEE` calculation and validity rules.
- The `BASEFEE` field in the block header.
- The computation and payment of `priorityFee` to the block beneficiary (coinbase).
- Transaction validity rules for `maxFeePerGas` and `maxPriorityFeePerGas`.

## Companion Scope Note

This ECIP defines the consensus-layer `97%`/`1%`/`1%`/`1%` routing of `BASEFEE` between the block beneficiary and the deterministic addresses for Core ETC, ETC Grants, and logtrees.
Any downstream custody, settlement, grants, or logtrees-specific logic for the three `1%` shares is out of scope for this ECIP and is expected to be specified in companion documents or recipient-specific operational documents.

## Draft Alias

Until an ECIP editor assigns a number, this draft should use an alias-based filename rather than a pseudo-numbered identifier.

- Draft alias: `ecip-tocila-elysium-basefee-split`

## Rationale

This proposal preserves Ethereum Classic’s compatibility direction while keeping miners as the primary recipient of fee-market revenue.
The remaining `3%` is split across Core ETC, ETC Grants, and logtrees as small deterministic allocations.

## Backwards Compatibility

This ECIP introduces a hard fork.
Clients that do not implement this ECIP will diverge from the canonical Ethereum Classic chain at the designated activation block.

## Security Considerations

This ECIP does not place subjective verification inside consensus.
Consensus changes are limited to fee-market behavior and deterministic `BASEFEE` split routing.
Any application-layer verification, scoring, estimation, or reward logic must be modular, separately auditable, and non-consensus.

## Implementation

This ECIP requires changes in ETC clients implementing the EVM and state transition function to:

- Introduce EIP-1559 and EIP-3198 at the agreed activation blocks.
- Replace the EIP-1559 `BASEFEE` burn behavior with deterministic balance credits of `97%` to the block beneficiary and `1%` each to `ELYSIUM_CORE_ETC_ADDRESS`, `ELYSIUM_ETC_GRANTS_ADDRESS`, and `ELYSIUM_LOGTREES_ADDRESS`.

## Reference Implementation Status

Companion documents may describe existing logtrees/logN prototype work. That work is illustrative and non-normative unless explicitly incorporated into consensus-client code.

## Copyright/Licensing

This document is licensed under Apache-2.

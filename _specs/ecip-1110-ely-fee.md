---
ecip: 1110-ELY-FEE
title: Elysium Fee Market and Productive Revenue Routing
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

Unlike Ethereum (where `BASEFEE` is burned), this ECIP redirects the protocol-collected `BASEFEE` amount to a deterministic Elysium Revenue Contract address.

## Simple Summary

Elysium provides modern fee-market compatibility for ETC while preserving Proof-of-Work and fixed issuance.
Miner `priorityFee` remains payable directly to block producers.
The `BASEFEE` portion is redirected to a deterministic, protocol-owned Elysium revenue address intended to support productive, auditable settlement modules rather than passive accumulation.

## Motivation

Ethereum Classic benefits from execution-layer compatibility with the broader EVM ecosystem.
If ETC activates London-style fee market behavior, it must also choose how `BASEFEE` is handled.

Elysium proposes a productive revenue-routing model: protocol revenue should be routed into a deterministic contract address intended to support auditable utility generation rather than a passive balance.

## Specification

This ECIP:

- Activates [EIP-1559](https://eips.ethereum.org/EIPS/eip-1559) on Ethereum Classic.
- Activates [EIP-3198](https://eips.ethereum.org/EIPS/eip-3198) on Ethereum Classic.
- Redirects all `BASEFEE`-denominated fee revenue to the Elysium Revenue Contract address (instead of burning it).
- Preserves direct miner receipt of `priorityFee`.
- Preserves ETC monetary policy and issuance schedule (no changes to block subsidy or issuance).
- Excludes Proof-of-Stake-specific features.

### Activation

Activation block numbers are **TBD** pending coordination and testnet deployment.

- **Mordor**: TBD
- **Ethereum Classic Mainnet**: TBD

### Elysium Revenue Address

Let `ELYSIUM_REVENUE_ADDRESS` be an address agreed upon prior to activation.

- `ELYSIUM_REVENUE_ADDRESS`: **TBD**

This ECIP does not require code to exist at `ELYSIUM_REVENUE_ADDRESS` at the activation block. If no code is present, the address behaves as a normal EOA-style account for balance accounting purposes (i.e., it can still accrue balance).

### Consensus Rules

Clients MUST implement EIP-1559 and EIP-3198 as specified, with the sole Ethereum-Classic-specific modification described below.

#### BASEFEE redirection (ETC-specific modification)

Where EIP-1559 specifies that the `BASEFEE` portion of transaction fees is burned, clients MUST instead credit that amount to `ELYSIUM_REVENUE_ADDRESS`.

Informally, for each transaction $i$ in a block with gas used $g_i$ and block base fee $b$ (in wei per gas), define:

$$
	ext{basefee\_revenue} = \sum_i g_i \cdot b
$$

Then the post-state transition for the block MUST include:

- `balance[ELYSIUM_REVENUE_ADDRESS] += basefee_revenue`

All other EIP-1559 behaviors remain unchanged, including:

- `BASEFEE` calculation and validity rules.
- The `BASEFEE` field in the block header.
- The computation and payment of `priorityFee` to the block beneficiary (coinbase).
- Transaction validity rules for `maxFeePerGas` and `maxPriorityFeePerGas`.

## Companion Contract Scope Note

This ECIP defines only `BASEFEE` redirection to the deterministic Elysium revenue address.
Distribution mechanics (including potential multi-destination routing) are out of scope for this ECIP and are expected to be specified in a companion ECIP (draft).

## Symbolic Placeholder IDs (Olympia-relative, non-final)

The identifiers below are symbolic placeholders.

- ECIP-1110-ELY-FEE (this document): Elysium Fee Market and Productive Revenue Routing
- ECIP-1111-ELY-REV: Elysium Revenue Contract
- ECIP-1112-ELY-COMP (informational companion): Elysium logtrees/logN Productive Settlement Overview

## Rationale

This proposal preserves Ethereum Classic’s compatibility direction while offering a different sink for redirected `BASEFEE`.
The intended sink is not a passive treasury, but a deterministic contract address intended to support auditable, utility-generating settlement modules.

## Backwards Compatibility

This ECIP introduces a hard fork.
Clients that do not implement this ECIP will diverge from the canonical Ethereum Classic chain at the designated activation block.

## Security Considerations

This ECIP does not place subjective verification inside consensus.
Consensus changes are limited to fee-market behavior and deterministic `BASEFEE` revenue routing.
Any application-layer verification, scoring, estimation, or reward logic must be modular, separately auditable, and non-consensus.

## Implementation

This ECIP requires changes in ETC clients implementing the EVM and state transition function to:

- Introduce EIP-1559 and EIP-3198 at the agreed activation blocks.
- Replace the EIP-1559 `BASEFEE` burn behavior with a balance credit to `ELYSIUM_REVENUE_ADDRESS`.

## Reference Implementation Status

Companion documents may describe existing logtrees/logN prototype work. That work is illustrative and non-normative unless explicitly incorporated into consensus-client code.

## Copyright/Licensing

This document is licensed under Apache-2.

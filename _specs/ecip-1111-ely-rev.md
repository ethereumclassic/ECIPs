---
ecip: 1111-ELY-REV
title: Elysium Revenue Routing Destinations
lang: en
author: Daniel Tocila
status: Draft
type: Standards Track
category: Core
created: 2026-03-12
license: CC0-1.0
---

## Abstract

This ECIP defines the deterministic destination addresses and minimal custody semantics for receiving the three `1%` `BASEFEE` allocations reserved for Core ETC, ETC Grants, and logtrees under the Elysium fee-market upgrade.

## Motivation

### Design Goal

The Elysium routing destinations are deterministic, minimal, and auditable.
Their purpose is to receive and hold the three non-miner `BASEFEE` allocations while exposing only the minimal interfaces required by separately specified settlement or governance paths.

### Principles

- deterministic destination addresses
- immutable consensus-layer routing targets
- clean separation between routing and downstream governance or settlement logic
- modular support for multiple productive or operational allocations

### Non-Goals

This ECIP does not itself define:
- logN formulas,
- UI behavior,
- grant-program governance,
- off-chain LLC administration,
- empirical calibration of rewards.

Those are separate concerns.

## Specification

### Deterministic destination addresses

The deterministic Elysium routing destination addresses are:

- `ELYSIUM_CORE_ETC_ADDRESS`: **TBD**
- `ELYSIUM_ETC_GRANTS_ADDRESS`: **TBD**
- `ELYSIUM_LOGTREES_ADDRESS`: **TBD**

The mechanism by which these addresses are made deterministic or otherwise fixed for activation is **TBD**.

### Minimal custody semantics

At minimum, each destination MUST be able to receive the value transfers resulting from its `1%` `BASEFEE` allocation under ECIP-1110-ELY-FEE (i.e., it must be a valid address for balance crediting).

The remaining `97%` of `BASEFEE` is paid to the block beneficiary at consensus and does not pass through these destinations.

Any settlement, distribution, routing, grants, or governance logic for funds held at these addresses is out of scope for this ECIP.

## Rationale

This ECIP separates routing of the Core ETC, ETC Grants, and logtrees allocations from any downstream operational or productive settlement logic to keep the consensus-facing requirements minimal and auditable.

## Implementation

Implementation details are **TBD** pending finalization of the deterministic address derivation or address-selection method for each destination.

## Copyright/Licensing

This document is licensed under Apache-2.

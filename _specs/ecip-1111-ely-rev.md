---
ecip: 1111-ELY-REV
title: Elysium Revenue Contract
lang: en
author: Daniel Tocila
status: Draft
type: Standards Track
category: Core
created: 2026-03-12
license: CC0-1.0
---

## Abstract

This ECIP defines the deterministic contract address and minimal custody semantics for receiving all `BASEFEE` redirected under the Elysium fee-market upgrade.

## Motivation

### Design Goal

The Elysium Revenue Contract is protocol-owned, deterministic, minimal, and auditable.
Its purpose is to receive and hold redirected `BASEFEE` while exposing only the minimal interfaces required by separately specified settlement or governance paths.

### Principles

- deterministic address
- immutable deployment target
- no privileged off-chain actor required for custody
- clean separation between custody and settlement logic
- modular support for future productive settlement paths

### Non-Goals

This ECIP does not itself define:
- logN formulas,
- UI behavior,
- discretionary grants,
- off-chain LLC administration,
- empirical calibration of rewards.

Those are separate concerns.

## Specification

### Deterministic address

The deterministic Elysium Revenue Contract address is:

- `ELYSIUM_REVENUE_ADDRESS`: **TBD**

The mechanism by which `ELYSIUM_REVENUE_ADDRESS` is made deterministic is **TBD**.

### Minimal custody semantics

At minimum, the revenue destination MUST be able to receive the value transfers resulting from `BASEFEE` redirection (i.e., it must be a valid address for balance crediting).

Any settlement, distribution, routing, or governance logic for funds held at `ELYSIUM_REVENUE_ADDRESS` is out of scope for this ECIP.

## Rationale

This ECIP separates custody from any productive settlement logic to keep the consensus-facing requirements minimal and auditable.

## Implementation

Implementation details are **TBD** pending finalization of the deterministic address derivation/deployment method.

## Copyright/Licensing

This document is licensed under Apache-2.

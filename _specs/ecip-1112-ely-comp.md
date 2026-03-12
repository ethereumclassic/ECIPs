---
ecip: 1112-ELY-COMP
title: Elysium logtrees/logN Productive Settlement Overview
lang: en
author: Daniel Tocila
status: Draft
type: Informational
created: 2026-03-12
license: CC0-1.0
---

## Status

Informational / Companion

## Abstract

This document describes the initial intended productive settlement path for Elysium revenue: logtrees, powered by logN and the Treemap.

It is non-consensus and exists to make the purpose of Elysium legible to reviewers, builders, and node operators.

## Plain-English Overview

Elysium is intended to route Ethereum Classic protocol revenue into an auditable engine that can reward measurable, verifiable, non-zero-sum activity.

The first proposed engine is logtrees.

logtrees is an application/protocol direction that records supported actions, anchors their event records to a ledger, aggregates them into a public Treemap, and uses bounded reward logic to avoid unbounded extraction.

## Intended End-to-End Flow

1. A user performs a supported action.
2. Metadata and evidence/attestation are submitted.
3. A verification or scoring path determines whether the claim is accepted.
4. A conservative estimator computes expected externality reduction.
5. A bounded reward rule converts that estimate into a capped settlement value.
6. An append-only event record is anchored to ETC.
7. The Treemap updates as auditable derived state.
8. Settlement modules may allocate rewards, credits, or utility access.
9. Over time, ETC gains both fee-market modernization and a utility-expanding application layer.

## Why This Matters

This architecture is intended to make ETC’s redirected `BASEFEE` immediately more legible:
not merely protocol funding,
but protocol funding routed into a measurable and auditable engine of utility generation.

## Prototype Status

A minimal prototype exists for append-only event logging and materialized aggregation.
This prototype is illustrative and does not yet constitute evidence of security, economic efficiency, incentive compatibility, or production readiness.

## Future Work

Future work may include:

- decentralized verifier design,
- estimator governance,
- privacy-preserving attestations,
- parameter calibration,
- miner-alignment modifiers,
- Rainbow Compute integration,
- additional settlement modules.

---

<p align="center">❤️ 💚 💙 🌲 🎄 Love Is Real 🎄 🌲 💙 💚 ❤️</p>

## Copyright/Licensing

This document is licensed under CC0-1.0.
---
ecip: 110x
title: A 2-Dimensional Consensus Arbitration Protocol, Difficulty * TABS
author: Isaac (https://github.com/whilei)
discussions-to: TODO
status: Draft
type: Standards Track
category: Core
created: 2022-04-20
requires: EIP-100, ECIP-1105
lang: en
---

# Abstract

Use a heuristic of chain state capitalization as a 2nd-dimension factor in consensus arbitration to improve normal finality rates and increase the cost of abnormal private chain production.

# Motivation

## State Finality Is Low and Slow

This proposal intends to increase the cost of producing a private, competitive chain segment, which is characteristic of double-spend attacks. It aims to improve finality expectations by increasing the cost of attack, while maintaining existing assumptions and incentives associated with the incumbent proof-of-work protocol.

# Specification

This specification is defined as a modification of the general,[^1] currently existing canon-arbitration algorithm, namely "Modified GHOST," currently in use on the Ethereum and Ethereum Classic networks.

[^1]: Difficulty bomb and/or delay features are ignored.

## TABS: Total Active Balance Synthesis

Total Active Balance Synthesis (TABS) is a positive scalar integer. Generally considered, it provides a measure of currency capitalization over time for some chain state.

It is defined to approach the median aggregate balance of all transaction-originating accounts for a blockchain of some length. It is denominated in Wei.

TABS is a "synthetic" value derived from a "raw" Total Active Balance (TAB) value of any block and, recursively, the TABS value of its parent block, much like block difficulty and gas limit.

### TAB: Total Active Balance

The TAB value of a block is the sum of the balances (at the parent block state) of all unique transaction senders in the current block.

Pseudo-code is provided as:

```go
// blockTAB returns the "raw" TAB value for a block.
// This value is the sum of the balances (at the parent state) 
// of all transaction senders in this block.
func blockTAB(block *Block) (tab *big.Int) {
    
    // uniqueSenders is a lookup to de-dupe sender accounts.
    // Each sender account only gets counted once.
    var uniqueSenders = make(map[common.Address]bool)
    
    // Iterate all transactions in the block
    for _, tx := range block.transactions {
        var _, seen = uniqueSenders[tx.sender]
        if !seen { 
            uniqueSenders[tx.sender] = true
            tab += state.balance(tx.sender, block.parentHash)    
        }
    }    
    return tab
}
```

### TABS Adjustment Algorithm (Validation)

The TABS value is defined as follows.

A __minimum value__ _K_ for TABS is defined as `128e18` Wei, equivalent to 128 Ether.

An __adjustment denominator__ _r_ is defined as `4096`.

An __adjustment numerator__ _y_ is defined to be in the set `[-1,0,1]`, where:

 - `y = -1` if TAB(B<sub>n</sub>) < TABS(B<sub>n-1</sub>)
 - `y = 0` if TAB(B<sub>n</sub>) == TABS(B<sub>n-1</sub>)
 - `y = 1` if TAB(B<sub>n</sub>) > TABS(B<sub>n-1</sub>)

From these definitions, the TABS algorithm for a block numbered _n_, written as TABS(B<sub>n</sub>), is as follows:

- if TABS(B<sub>n-1</sub>) is undefined, then TABS(B<sub>n</sub>) = _K_
- otherwise, TABS(B<sub>n</sub>) = MAX(K, TABS(B<sub>n-1</sub>) + (y * TABS(B<sub>n-1</sub>) // r))

Where `//` means floor division.

Pseudo-code is provided as:

```go
var minimumTABS = 128e18
var tabsAdjustmentDenominator = 4096

// blockTABS returns the TABS value of currentBlock.
func blockTABS(parentBlock, currentBlock *Block) (tabs *big.Int) {
    if parentBlock.tabs == nil {
        return minimumTABS
    }
    
    // tab is the "raw" 'Total Active Balance' value.
    // This is the sum of the balances of all transaction senders
    // in this block.
    var tab = blockTAB(currentBlock)
    
    var numerator *big.Int
    if tab > parentBlock.tabs {
        numerator = 1
    } else if tab < parentBlock.tabs {
        numerator = -1
    } else {
        numerator = 0
    }
    
    // 1  + 4096 => 4097 (4097/4096)
    // 0  + 4096 => 4096 (4096/4096=1)
    // -1 + 4096 => 4095 (4095/4096)
    numerator += tabsAdjustmentDenominator
    
    // Return the adjusted parent block TABS, respecting
    // the minimum 'floor' value, eg.
    // 4097/4096 * parent.tabs
    // 4096/4096 * parent.tabs
    // 4095/4096 * parent.tabs
    tabs = parent.tabs * numerator / tabsAdjustmentDenominator
    
    if tabs < minimumTABS {
        return minimumTABS
    }
    return tabs
}
```

This algorithm is expected to yield a value which approaches the blockchain's median TAB score.

## Consensus Score

The incumbent primary "consensus score" is total difficulty. This value is defined as the sum of block difficulties for all blocks in some segment, as:

```go
var consensusScore *big.Int
for _, block := range blocks {
    consensusScore += block.difficulty
}
```

This proposal modifies the consensus score attribution as:

```go
var consensusScore *big.Int
for _, block := range blocks {
    consensusScore += block.difficulty * block.tabs
}
```

In this context, this proposal changes the atomic block consensus score value from block difficulty to the multiplicative product of block difficulty and block TABS.

Like total difficulty, this value is still summed across a chain segment of any length to yield a total consensus score value.

With this syntax, both the current and proposed arbitration conditions are defined to prefer any chain state with the greatest "consensus score."


## Invariance of Adjacent Canon-Arbitration Conditions

Like the incumbent Total Difficulty comparison condition, the proposed condition replacing it ("Consensus Score") can yield indecisive outcomes, or ties.

In the case of ties, subsequent protocol canon-arbitration conditions are preserved as invariants, namely (and in this order):

- lesser block height preferred (objective)
- selfish authorship preferred (subjective)
- random coin toss (subjective)

# Rationale

## Inversely Proportional Equilibrium Factors

PoW resilience against double-spend attacks depends on an assumption that no entity controls more than the "honest"/public network's hashrate over some time. The difficulty value over time represents an equilibrium value. Difficulty values over time in excess (or deficiency) of the equilbrium represent competitiveness; for good, or for evil.

The logic of this proposal depends on an _additional assumption_ that no entity controls more than the network's TABS value in capital over some time. This is another equilibrium value.

These assumptions (ie. equilibrium values) factored together create a 2-dimensional equilibrium. An excess or shortfall in one variable inversely slackens or raises the demand on the other for equilibrium.

```go
// Equilibrium Example Schema

// D: Difficulty
// S: TABS
// a, b, x, y: Coefficients
(a*D) * (b*S) = (x*D) * (y*S)
```

For example, while maintaining an equivalence in consensus scores, a relatively greater  difficulty value lessens the demand on TABS.
```go
var publicChainConsensusScore = (1*D) * (1*S)

// An attacker with 110% hashrate of the "honest"/public net
// needs 91% of the public TABS value to be competitive.
var attackChainConsensusScore_Hasher = (1.1*D) * (/*1.1/1=*/0.91*S)

// An attacker with 91% hashrate of the "honest"/public net
// needs 110% of the public TABS value to be competitive.
var attackChainConsensusScore_Richer = (0.91*D) * (1.1*S)
```

## Block Space Opportunity Cost for Miners

Miners can include "local" transactions on their own behalf at no currency cost, but at the opportunity cost of the inclusion of a revenue-generating transaction.[^2]

[^2]: :dragon: This changes with EIP-1559 or other transaction burn-fee schemes.

Miner participation in the TABS competition is expected, since expected block revenues are driven, in part, by the competitiveness of the capital they represent on their own behalf.

Since a miner can and should (optimally) represent their self-interested capital as a single transaction in the blocks they mine, they are expected to at least sometimes cannibalize one balance-transfer transaction's worth of block space (the minimum, currently `21,000 / ~10,000,000 = 0.02%`) in their own interest.

Miner-interest transactions can be inoperative. Miners don't have to actually send any balance to anyone. Just a signed transaction to themselves, for example, where they recoup the gas fee (as the credited coinbase) or charge themselves a zero gas price.

## Short-Term Finality Rate Increases

The rate of the network's production of orphan blocks (sometimes recorded as uncles) is expected to drop because the expected rate of objectively decidable (non-tie, "asymmetric") block competitions is expected to rise by around 50\%. The precise value of this expecation depends on the distribution of miner-available capital rates relative to the distribution of miner hashrates.

Lessening the production rate of non-canonical blocks is, by definition, an increase in expected network state finality.

## Conservative Adjustment Rate

> An __adjustment denominator__ _r_ is defined as `4096`.

An adjustment factor of `1/4096` is chosen relative to the incumbent minimum difficulty adjustment factor which is `1/2048`, and represents an intentionally conservative impact on chain production race probabilities and incentives.

The potential rates of change for difficulty are greater (faster) in all cases than those of TABS.

For example, a block produced in the `[1-8] second` interval (`2049/2048*parent.difficulty`) with a diminished TABS value (`4095/4096*parent.TABS`) yields an equivalent overall consensus score (`+1/4096`) compared with a block produced in the next `[9-17] second` interval (`2048/2048*parent.difficulty`) with an increased TABS value (`4097/4096*parent.TABS`) yielding also a consensus score increase of a proportional `+1/4096`.

Further investigation and analysis is encouraged for alternative adjustment rates, eg. `128`.

## Median-Seeking Adjustment Algorithm

The proposed algorithm "synthesizing" TABS is an implementation of a median-seeking algorithm.

From this, and by definition, we expect that eventually for some set of blocks, roughly half will have TAB values above, and half below the resulting TABS value. However, since the block authorship _per miner_ is not equally distributed, the TABS score will be weighted more heavily toward more prolific miners. The scale of this weighting will depend on the ratio of the aggregate balance of public transactions relative to any balance represented exclusively by some miner. 

Further investigation and analysis is encouraged for alternative adjustment algorithms, eg. moving averages, sequential weights.[^3]

[^3]: Another idea uses a count of sequential TABS drops (number of consecutive falling adjustments) to cause the TABS value to fall _faster_ when it is only (or usually) falling. 

## PoW Race Incentives are (Mostly) Maintained

A miner with access to 90\% of the TABS capital cannot produce blocks in isolation competitively; their private chain's TABS score will drop to 90\% of the public TABS and they will need something like 110\% hashrate to compensate if they want to compete independently over time.

So the rich (but not too-rich) miner must compete in the proof-of-work race, and whether or not they can exceed some parent block's TABS will depend on the aggregated TAB value of the public transactions pending block inclusion.

Upon the discovery of a new block and its availability to the miner, the miner faces two strategies -- ORPHAN, or ADOPT -- and should choose the more probably profitable one. To ORPHAN the proposed block means they continue work toward a competitive sibling block. To ADOPT means they begin work toward a child block.

If their balance is _insufficient_ to beat the TABS of the announced block, clearly the incentives of the incumbent PoW race are preserved as invariant and the miner chooses to ADOPT. This covers about 50\% of the cases.

If their balance _is sufficient_ to beat the TABS of the announced block, how do they model their probabilities for the ORPHAN or ADOPT strategies? 

Since their expected TABS consensus score is differentially, at most, `+1/4096` of the proposed block, they can still achieve probabilistic equilibrium with the incumbent race given only `4095/4096` of the otherwise necessary hashrate (representing the likelihood of their PoW solution discovery).

So, unless the miner has `"51%" * 4095/4096` of the hashrate, the best strategy is still to ADOPT.


## Observable, Domain-Specific Competition Drives Security

Heuristics about PoW finality expectations depend on "off-chain" variables, like universally (on- and off-network) available applicable hashrate. For example, hashrate from another network, networks, or any other applicable technologic domain like computer gaming; the state of the art of the work itself; the applicable market(s) for electricity, etc.

Unlike fuzzy estimates about (potentially) globally available hashrate relative to the PoW network in question, all of the functional TABS protocol parameters are observable as on-chain values, namely balance distribution and overall currency supply.

## Soft (But Important) Dependence on Transaction/State Exclusivity

An adjacent proposal "AHA Typed Transactions" is listed as a dependency, which should be understood as an encouraged, prototypical mechanism for developing a way for transactions to be dependent on some chain state at the transactor's discretion, and in expectation that this chain state (presumed to be a public one) is different than any hypothetical private state.

The motivation for this is to encourage a difference of TAB values between public and private chain segments. Transactions which depend on a chain state exclusive to the public chain count differentially toward the aggregated public TABS value, which increases the cost of a double-spend attack.

However, this is not completely theoretically necessary.

Miners can include "local" transactions arbitrarily in blocks they mine (using existing and common APIs and clients). Transactions made in this way already meet the criteria for differentially exclusive transactions, albeit imperfectly, since their differential exclusivity ("locality") is limited to the pending block because the transactions, once published in the public chain state, become available to any competitor.

TLDR; theoretically, existing APIs for "local" transactions can sufficiently differentially benefit the public state, but can do so only to the differential magnitude of a single block, and, as such, are practically insufficient.

# Tests

## Simulation Programs

I have written a couple programs that I've used to simulate and observe chain production characteristics.

- [`go-miner-sim`](https://github.com/etclabscore/go-miner-sim) simulates PoW/TABS chain production in a multi-agent environment.
- `go-block-step` simulates an abstracted version of the block production race.

I would love review, feedback, and collaboration on these.

## Empirical Context

TAB and TABS value estimates can be derived retrospectively for Ethereum and Ethereum Classic chains.

At the time of writing, and with limited sample sizes, I estimate TABS values as follows.

- Ethereum's (ETH): ~500,000 ETH.
- Ethereum Classic's (ETC): ~7,000 ETC.

Further efforts toward current or retrospective analysis of real-life PoW chains, not limited to ETC, is welcome.

# Backwards Compatibility

A hard fork would be required.

# Known Vulnerabilities

## TABS Poisoning

An attacker could promote high-gas, low-balance transactions in the public pool, attempting to lessen the public TABS value for some time.

This strategy would be observable in real time by the public.

## Whales and Collusive Capital

An attacker could challenge the assumption that no entity controls more than the public TABS value for some time. The value of TABS relative to current supply and its account distribution informs this risk model.

This attack, like a pure-PoW double-spend attack, would be invisible until published.




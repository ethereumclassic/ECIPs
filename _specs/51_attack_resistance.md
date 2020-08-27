---
ecip: <ECIP number>
title: 51% Attack Resistance 
lang: en
author: Dimitris Karakostas, Radek Tkaczyk, Romain Pellerin, Brian McKenna
discussions-to: https://github.com/ethereumclassic/ECIPs/issues/348 | https://github.com/input-output-hk/ECIPs/issues/1
status: Draft
type: Standards Track
category: Core
created: 2020-08-26
---

### Abstract

This document outlines a proposal for the implementation of a system to provide 51% attack resistance on the Ethereum Classic blockchain. It describes the high-level structure and general properties of such a system. IOHK has already researched and implemented the checkpointing protection on ETC, and has detailed specifications for each part of the system, as well as reference implementation, that can be found in [this repository](https://github.com/input-output-hk/checkpointing_code_plus_ecip).

### Motivation

Distributed ledgers based on the Proof-of-Work (PoW) paradigm are typically most vulnerable when mining participation is low. During these periods an attacker can mount devastating attacks, such as double spending or censorship of transactions [^CHECK]. We have seen recently that this is particularly relevant to ETC, as witnessed by the two attacks that took place in August 2020.

Checkpointing is proposed as a mechanism to mitigate such 51% attacks. The core idea is to employ an external set of parties that securely run an assisting service which guarantees the ledger's properties and can be relied upon at times when the invested hashing power is low. Once hashing power reaches a level where an attack is no longer financially viable, the system can be discontinued.

The future viability of ETC in its current, unsecured state is now in question. Implementing a fully tested Checkpointing solution, running the Ouroboros-BFT (OBFT) consensus protocol, would provide high assurance, with low performance requirements. It would also boost confidence in the network and provide the much needed stability required to take ETC to a level where 51% attacks are no longer feasible.

### Specification

The checkpointing authority monitors the growth of the chain and periodically issues checkpoints, which are points at which validations occur. As soon as it observes the first valid chain, which extends the latest checkpoint by `𝑘` blocks (for some constant value `𝑘`), the authority signs this chain’s last block and broadcasts this signature, thus producing a new checkpoint.

From the user perspective, chain selection is augmented by enforcing a rule where a chain is valid only if it extends the latest checkpoint. In particular, when selecting a chain, honest use applies as follows:

- first verifies that it contains the latest checkpoint; and
- then applies the longest-chain rule to all validly checkpointed candidates.

Even an adversary controlling a majority of the mining power cannot revert the block history secured by the latest checkpoint, as an honest user will (eventually) reject any chain that does not extend this checkpoint.

The checkpointing authority is distributed among a number `𝑛` of nodes. These nodes run an internal Byzantine fault tolerant (BFT) consensus protocol, Ouroboros BFT [^OBFT], to coordinate the issuing of checkpoints.

The checkpointing nodes use a multi-signature scheme to produce each checkpoint. A 𝑡-out-of-𝑛 multi-signature scheme allows a set of 𝑛 parties to collectively sign a message under the necessary condition that at least `𝑡` of the parties collaborate in order to sign this message. The checkpointing nodes issue their chosen checkpoints by creating respective multi-signature2s using their keys. Choosing ``𝑡 > 𝑛 − 𝑡`` implies that correct (agreed-upon) checkpoints will be continuously produced, while the forgery of checkpoints is impossible assuming that a minority of the checkpointing nodes is corrupted.

#### Checkpointing Service

The federation needs to agree upon the block to be checkpointed. The proposed solution consist of two components:

- a dedicated ETC node that will be used by the federation to monitor and retreive data.
- a checkpointing service server (the server) which allows federation nodes to reach an agreement.

The server is based on Ouroboros BFT [^OBFT]. Ourobotos BFT is a blockchain-based Byzantine Fault Tolerant protocol, i.e. it’s resilient to `t < n / 3` faults, that aims to be simple without compromising security soundness. 

Simplicity is achieved by the fact participants just need to do two things: extend their blockchain and generate the next block, if they are eligible.

The service should periodically execute the following process:

1. Fetch the latest block candidate for checkpointing using `checkpointing_getLatestBlock` RPC call. This RPC method returns just the number and hash of the latest matching block, for which `block_number % checkpointing_interval == 0`
2. Cast a vote with a signature for this block. The vote is a transaction broadcasted in the OBFT network
3. Upon reaching consensus in the OBFT chain (a majority of votes for a given ETC block), a checkpoint with all matching signatures is sent to the associated ETC nodes, from where it is broadcasted to the entire network.

#### Checkpointing Network Definition

The method for selecting the checkpointing committee is a key element of this proposal and must be carefully analyzed and agreed by the ETC community members who have considered the governance implications. In fact, the original PoW consensus is augmented by a layer of security offered by a checkpointing network. This network can be either secured by a federation of ETC entities, by the dynamic selection of a random committee of ETC miners or by implementing a timestamping protocol on an external chain (BTC).

These three options and how they can be implemented are outlined as part  of this proposal:

##### Option 1: Trusted network of federated ETC entities

In this federated option, the checkpointing network is operated and secured by a committee of n members selected by the ETC community. This committee can be either:

- founded by `k` entities and extended by a majority vote, `k < n`;
- extended to miners and/or developers and/or stakeholders;
- elected for a period of time `t`;

We envisage that a multitude of selection criteria could be used to form the committee, but we advise the community to keep this mechanism as lean as possible in a _first implementation by defining a fixed group of federation members_. 

We understand that the aforementioned alternative might not be optimally flexible, so we are proposing an optional improvement that will allow checkpointing to potentially rotate the checkpointing federation. The specific implementation of this federated option will be provided as a smart contract that adheres to the following election mechanism:

- `p` the duration of a voting epoch 
- `a` voting epoch is comprised of three periods; pre-voting, voting, and tally, each lasting `p/3`
- pre-voting period starts;
- `C` candidates register with their respective public key;
- at the end of the pre-voting step if `C < n` the vote fails and go to 1;
- else the voting period starts;
- each stakeholder votes with his/her ETC stake for the candidate(s) of his/her choice, and stake is locked until the vote ends;
- voting period ends;
- tally period starts and calculates the list of entities which gathered the most stake (in case of equivalent stake lexical order of public key prevails), and will form the committee for a designated period of time;
- tally ends, list is confirmed;
- when `t - p` expires go to 1.

Optionally, we can provide a privacy-enabled voting mechanism to ensure that votes will remain anonymous. Depending on the complexity this might be delivered as a second-layer solution. 

We suggest the following configuration: `p=30 (days)`, `n=100`  and  `t=180 (days)`. 

This list can be publicly accessed through a getter smart-contract.

This method can then be called by the nodes that participate in the checkpointing network, and only the nodes listed can issue checkpoints themselves.

- Pros:
    - Community-driven and on-chain selection of com mittee
    - Reliability of the n participants

- Cons:
    - A very wealthy attacker can register multiple public keys and vote for himself to obtain a majority of checkpoint signatures 
    - This is an example of how one could implement a voting scheme, however this scheme starts to resemble Proof of Stake and it may be worthwhile considering hybrid consensus if this scheme is deemed favourable by the community


##### Option 2: Dynamic network of ETC miners

In this dynamic and random selection option, the checkpointing network is operated and secured by a committee of k miners who are randomly selected at every epoch through the blockchain data structure and history. The parameters for this random selection can be either :
- based on the lexical distance of the miner’s public key with the last block hash;
- within a window of time determining a subset of miners;
- within a set of NiPoPoWs [^NIPOPOW] graphs;

We envisage that a multitude of randomized selection algorithms could be used, but we advise the community to select the solution that offers the best resistance to attacks.

The specific implementation of this dynamic and random selection option will be provided as a consensus algorithm used in the checkpointing blockchain that actively monitors the ETC blockchain. The following is a draft proposal for the committee selection algorithm that we consider offers  sufficient protection against long range attacks:
- `e` an epoch of a duration t in which a new list of at least `n` miners is determined;
- `p` the maximum processing time for this algorithm;
- `w` a sliding window of `k blocks` from the latest block of the latest epoch `window + window_min` (or `last block - window_min` at initialization), `k` calculated based on the difficulty  and  `k > window_min`;
- calculate `npp(k)` the subset of `k` latest NiPoPow graphs;
- calculate `l(npp(k))`the list of miners’ public keys that have contributed to mine the blocks contained by `npp(k)`removing duplicates (set);
- if `length(l(npp(k))) < n` go to 2.;
- else the list is determined 
- when `t - p` expires go to 1.

- Pros
    - Checkpointing network is secured by miners
    - On-chain selection of committee
    - Decreased risk of collusion within the committee
- Cons
    - Sensitive to long range attacks 
    - Draft solution and the secure algorithm, or equivalent, needs to be formalised
    - It may not be possible to prove a satisfactory level of security with this scheme, also to make such a scheme secure will likely increase implementation complexity

##### Option 3: Auxiliary Security from an External Blockchain

This option relies on utilizing an external distributed ledger as a timestamping service. We believe that Bitcoin, being the most used and, arguably, most secure existing distributed ledger, can serve as an anchor of security for ETC, in the manner described below.

The timestamping protocol, which can be used to secure ETC, is parameterized with:
- `kc`: the checkpointing interval. Note that kc needs to be large enough, such that a timestamp has enough time to become stable on Bitcoin; in practice, it should correspond to, at the very least, 60 minutes.
- `g`: the ETC block number, which marks the beginning of the timestamped period.

Mining in ETC under timestamping works as follows. When a miner tries to produce a new block, with block number `j`: 

- If `j = g + i*kc` for some integer `i`, i.e. every kc blocks, they construct a special checkpointed block as follows:
    - They retrieve from Bitcoin the timestamp of the most recently checkpointed ETC block; in general, this will be the block with number `g + (i - 1)*kc`. The timestamp is the position in the Bitcoin ledger of the oldest transaction which contains part of the header of this checkpointed ETC block.
    - They insert to the new ETC block the timestamp retrieved in step 1, in a special header field.
    - After creating the new ETC block, they timestamp its headers on Bitcoin, via a series of `OP_RETURN` transactions; the first such transaction to be published on Bitcoin will be the new block's timestamp.
- If `j ≠ g + i*kc` for any integer `i`, then the miner creates a standard ETC block as usual.

When choosing between two ETC chains, `C1` and `C2`, intuitively, an ETC node prioritizes timestamps over PoW. Specifically, between two competing blocks, it always chooses the one with the oldest timestamp, i.e. the one that was created first. If neither block and they both stem from the same timestamped block, then PoW is enforced. Specifically, a node does as follows:
- It finds the common ancestor block BC of the two chains
- In each chain, it finds the first block  Bt1`, `Bt2` after `BC` which has been timestamped on Bitcoin
- If `timestamp(Bt1) < timestamp(Bt2)`, i.e. if Bt1 was timestamped before `Bt2`, then the miner picks `C1`; otherwise they pick `C2`
- If `BC` is the latest timestamped block on both chains, then the standard maxvalid rule applies

Note 1: In practice, an ETC miner can choose on which chain to mine before a timestamp becomes stable in the Bitcoin ledger. Specifically, they may assume that the Bitcoin miners follow a first-come-first-in-the-block rule, such that the first timestamping transaction that the ETC miner observes on the Bitcoin network will eventually be the correct one.

Note 2: The above proposal applies on any alternative distributed ledger that enables publishing arbitrary data, such as Litecoin or Bitcoin Cash (on the PoW side) or Cardano (on the PoS side).

High Level Requirements

- ETC miners need to run a full Bitcoin node to retrieve and verify timestamps
- ETC miners need to own some Bitcoins to create timestamping transactions; on September 2019, this cost was $3.6 per block, see [^CHECK]
- A soft fork will be required to add the special header field (see mining step (b)), which is needed to ensure liveness

- Pros
    - Supplemental security can be provided by other blockchains (Bitcoin, Ethereum, Polkadot, Cardano etc.) 
    - No need to elect or agree upon a (semi)centralized committee
    - Security is ensured in the most decentralized way possible; in order to break the security of checkpoints, an attacker needs to break Bitcoin's security
    - The design ensures liveness via the unpredictable timestamp (introduced in mining step b), which could not be achieved e.g. if simply a hash of the ETC chain were published on Bitcoin

- Cons
    - ETC miners need to run a Bitcoin full node and own some bitcoins, in order to retrieve and publish timestamping transactions
    - Bitcoin fees may be non-trivial
    - Bitcoin block latency (10 minutes) may result in delays or misplaced mining work, in case timestamping transactions are published in a Bitcoin block out-of-order, i.e. in a different order from the order of creation

### Implementation

The following section refers to the _Option 1 with fixed commite members_

#### Data Structures

A checkpoint is another block in the chain. To distinguish it from regular blocks we need an extra field in the header called checkpoint. To simplify implementation all other header fields remain the same. What follow is recipe to build checkpoint block:

```
parentHash = <same as regular block>
beneficiary = address: 0x0
difficulty = <same as parent>
number = <same as regular block>
gasLimit = <same as parent>
timestamp = parent.timestamp + 1
extraData = <empty>
stateRoot = <same as parent>
transactionsRoot = <empty MPT>
receiptsRoot = <empty MPT>
logsBloom = <empty bloom filter>
checkpoint = <list of signatures or empty for regular block>
gasUsed = 0
mixHash = <empty>
nonce = <empty>
```

where the signature follows the same ECDSA scheme as transaction signatures and consists of:

```
R = <R component of ECDSA signature: 32 bytes>
S = <S component of ECDSA signature: 32 bytes>
V = <offsetted recovery id, 27 or 28: 1 byte>
```

Notes:
- there is no block reward for a checkpoint block
- timestamp should be predetermined so that all federation nodes construct exactly the same header

Validation of checkpoint upon import should check that all header values match the recipe specified above. It should also validate that the checkpoint block does not contain any signatures.

#### Consensus changes

In order to facilitate checkpointing the following consensus changes need to be made:

1. Each node in the network should be configured with a list of ECDSA public keys of the Checkpointing Federation
2. Upon importing a checkpoint block a node should verify the signatures conveyed in the checkpoint field against the parentHash of the block. The recovered keys must match the keys in 1. and each signature must come from a unique signer (note that checking signature non-equality is not enough)
3. Once a checkpoint has been imported it becomes stable in the chain. It can never be rolled back.

#### JSON-RPC Additions

An ETC node that is part of the Checkpointing Federation must implement these RPC methods to communicate with an OBFT node:

- **`checkpointing_getLatestBlock`**

Returns the hash and number for the latest block that matches the given checkpointing interval

Parameters:

- `QUANTITY` - integer checkpointing interval

Example:

```
// request
curl -X POST --data '{"jsonrpc":"2.0", "method":"checkpointing_getLatestBlock", "params":[4], "id":1}

// result
{
  "jsonrpc": "2.0",
  "result": {
    "hash":     "0x6cb6eb11c3f12689171585fde5107110fc846098ad02e323ff08eec1f9474f74",
    "number": 12 // 12 will be returned when the current best  
                 // block number is on of 12, 13, 14, 15
  },
  "id": 1
}
```

- **`checkpointing_pushCheckpoint`**

Used to push checkpoint information from the OBFT node to the associated ETC node

Parameters:

- `DATA` - hash of the checkpointed block, 32 bytes
- `Array of DATA` - a list ECDSA signatures encoded in 65-byte uncompressed format

Example:
```
// request
curl -X POST --data '{"jsonrpc":"2.0", "method":"checkpointing_pushCheckpoint", "params":[“0x6cb6eb11c3f12689171585fde5107110fc846098ad02e323ff08eec1f9474f74”, ["87fe715bfff7d6143f0ffd5662a54baa2ada865a0c83b248e67689100b0258356d155823b049815faca88cd2ea7c99a6fa601bdca787624272f752f35656a64a1c", "ec8b3662520174d4be70c4e91bcd7f156b21de54e60b2ed8019d8608dc0199cb231067508eca311b652b52328df34a74f720d4b08423eb4b528fdf1eece1478d1c", "2c53c2a4e1b4a3fb20d6f7e42fd4a72a703efededb66ca75c15495ccdc5eacdc1cd3b803b9149a92161e8373da035849272db7c299b56676649d31344e1446211c" ]], "id":1}

// result
{
  "jsonrpc": "2.0",
  "result": true,
  "id": 1
}
```


Note that these methods are not required for a regular ETC network node.

[^OBFT]: Aggelos Kiayias, Alexander Russell, Ouroboros-BFT: A Simple Byzantine Fault Tolerant Consensus Protocol https://eprint.iacr.org/2018/1049.pdf

[^CHECK]: Dimitris Karakostas, Aggelos Kiayias: Securing Proof-of-Work Ledgers via Checkpointing. IACR Cryptol. ePrint Arch. 2020: 173 (2020). https://eprint.iacr.org/2020/173

[^NIPOPOW]: Aggelos Kiayias, Andrew Miller, and Dionysis Zindros: Non-Interactive Proofs of Proof-of-Work https://eprint.iacr.org/2017/963.pdf
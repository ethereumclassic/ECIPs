---
lang: en
ecip: ECIP 1094
title: VeriBlock Proof-of-Proof 51%-Attack Prevention
status: Draft
type: Standards Track
discussions-to: https://github.com/max-sanchez/ECIPs-1/issues/?
author: Max Sanchez (@max-sanchez)
created: 2020-08-19
license: Apache-2
---

# Abstract

This document describes the implementation of the **VeriBlock Proof-of-Proof (“PoP”) consensus protocol on the Ethereum Classic blockchain for the prevention of 51% attacks. PoP reinforces Ethereum Classic’s existing Proof-of-Work protocol by allowing it to inherit the full Proof-of-Work security of Bitcoin in an entirely Decentralized, Trustless, Transparent, and Permissionless manner.**

PoP introduces a new form of mining (“PoP mining”) which rewards PoP miners for publishing headers from a security-inheriting blockchain to a security-providing blockchain, allowing the security-inheriting blockchain to reference these publications in the event that a 51% attack is attempted.

**With PoP implemented, the VeriBlock Bitcoin Finality Indicator (“vBFI”) provides blocks (and thus, transactions) on the Ethereum Classic network with Bitcoin confirmations as well as regular confirmations. Ethereum Classic transactions with at least one Bitcoin confirmation would be mathematically impossible to double-spend** or otherwise reverse without performing a reorganization of the Bitcoin blockchain itself.

Additionally, PoP provides a mechanism for transaction offloading which allows transactions to be processed on the Ethereum Classic blockchain even when a majority ETC hashrate adversary is exerting complete censorship over Ethereum Classic blocks.

# Motivation
**Ethereum Classic has suffered several high-profile 51% attacks which resulted in the theft of millions of dollars of funds from exchanges. Furthermore, several styles of 51% attacks can exploit many types of vulnerabilities in applications/protocols built on top of a smart-contract platform. 
There are two types of 51% attacks which pose risks to smart contract applications and protocols**:
1.	Surprise 51% attacks where an attacker controlling the majority of the hashrate builds a large chain in private and releases it to the network, causing a long-range reorganization of the blockchain (overwriting hours, days, or weeks of blockchain history)
2.	Real-time censorship 51% attacks, where an attacker controlling the majority of the hashrate only builds on top of blocks that they agree with all of the contents of and controls the content of all blocks they mine, and releases blocks as soon as they mine them   


51% attacks do not only allow for the theft of funds through double-spend attacks; **more sophisticated attacks can leverage long-range blockchain reorganizations and/or censorship attacks to**:


1.  **Time-out payment channels or force the redemption of old payment channel states** (and more generally, selectively censor time-sensitive interactions with smart contracts resulting in the triggering of default/refund behavior or punishment of the "unresponsive" party who was censored)
resulting in the triggering of default/refund behavior or punishment of the “unresponsive” party who was censored)

2.  **Desynchronize 1:1 pegs of cross-chain assets and artificially inflate their supply**


3. **Retroactively insert bets and take positions** on oracle-driven betting platforms and prediction markets

4. **Roll back decentralized exchanges and other DeFi applications based on external market forces** and take advantage of favorable pricing or trade opportunities

5. **Manipulate contract governance by censoring votes** (ex: “steal” funds from DAOs by allocating them to parties which aren’t actually approved by the majority of the DAO’s ownership, inject malicious “upgrades” to upgradeable protocols, etc.)

6. **Perform any other exploits that rely on censoring interaction with a smart contract or retroactively interacting with a smart contract** in a particular fashion with “future” information

These potential 51% attack exploits do not only threaten exchanges and merchants accepting ETC as a payment mechanism, *****but also dissuade from the deployment of smart contract protocols and applications on Ethereum Classic because of the attack vectors long-range reorganizations and/or censorship attacks pose to their security and reliability.*****

All of the successful 51% attacks against Ethereum Classic thus far have fallen into the first category (surprise long-range reorganizations); these long-range reorganizations are what make double-spends against services like exchanges possible. However, the second type of attack can be used in other exploits and can still be exploited when only protections against long-range attacks are implemented (such as max reorg distance, which also opens an attack vector for permanent irreconcilable network splits).

This proposal includes a solution for both types of attacks: **preventing surprise long-range reorganizations and preventing a majority hashrate operator from exerting complete censorship** *****even while publishing blocks to the network as the blocks are found.***** 

Additionally, this proposal exposes the presence(/absence) of Bitcoin finality for a particular block as an opcode, enabling smart contracts to execute certain actions only when certain blocks (or transactions) reach a certain level of Bitcoin finality.

# Specification
## Data Structures
<table> 
  <tr>
    <th>Name</th>
    <th>Fields</th>
    <th>Description</th>
  </tr>
  <tr>
    <td rowspan="4">AltPublicationData</td>
    <td>uint64 identifier</td>
    <td rowspan="4">Represents publication of Ethereum Classic data in the VeriBlock or Bitcoin blockchains</td>
  </tr>
  <tr>
    <td>byte[] header</td>
  </tr>
  <tr>
    <td>byte[] payoutInfo</td>
  </tr>
  <tr>
    <td>byte[] contextInfo</td>
  </tr>  
  <tr>
    <td rowspan="1">VBKAddress</td>
    <td>byte[] addressBytes</td>
    <td rowspan="1">A valid address on the VeriBlock network</td>
  </tr>
  <tr>
    <td rowspan="1">VBKCoin</td>
    <td>int64 atomicUnits</td>
    <td rowspan="1">A representation of a number of atomic units of VBK</td>
  </tr>
  <tr>
    <td rowspan="2">VBKOutput</td>
    <td>VBKAddress address</td>
    <td rowspan="2">An output on the VeriBlock network</td>
  </tr>
  <tr>
    <td>VBKCoin amount</td>
  </tr>
  <tr>
    <td rowspan="3">VBKNetworkBytePair</td>
    <td>boolean hasNetworkByte</td>
    <td rowspan="3">A byte indicating which VeriBlock network the transaction is valid on, and whether it is a standard VBK transaction (0x01) or PoP VBK transaction (0x02)</td>
  </tr>
  <tr>
    <td>uint8 networkByte</td>
  </tr>
  <tr>
    <td>uint8 txTypeId</td>
  </tr>
  <tr>
    <td rowspan="8">VBKStandardTransaction</td>
    <td>VBKNetworkBytePair networkOrType</td>
    <td rowspan="8">A standard VeriBlock transaction, which can include the publication of altchain data (in publicationData)</td>
  </tr>
  <tr>
    <td>VBKAddress sourceAddress</td>
  </tr>
  <tr>
    <td>VBKCoin sourceAmount</td>
  </tr>
  <tr>
    <td>vector<VBKOutput> outputs</td>
  </tr>
  <tr>
    <td>int64 signatureIndex</td>
  </tr>
  <tr>
    <td>AltPutlicationData publicationData</td>
  </tr>
  <tr>
    <td>byte[] signature</td>
  </tr>
  <tr>
    <td>byte[] publicKey</td>
  </tr>
  <tr>
    <td rowspan="1">BTCTransaction</td>
    <td>byte[] transactionData</td>
    <td rowspan="1">Raw bytes representing a Bitcoin transaction</td>
  </tr>
  <tr>
    <td rowspan="3">GenericMerklePath</td>
    <td>int32 treeIndex</td>
    <td rowspan="3">A Merkle path proving the inclusion of data in a Merkle tree on VeriBlock</td>
  </tr>
  <tr>
    <td>uint256 subject</td>
  </tr>
  <tr>
    <td>vector<uint256> layers</td>
  </tr>
  <tr>
    <td rowspan="4">VBKMerklePath</td>
    <td>int32 treeIndex</td>
    <td rowspan="4">A Merkle path proving the inclusion of data in a Merkle tree on VeriBlock</td>
  </tr>
  <tr>
    <td>int32 index</td>
  </tr>
  <tr>
    <td>uint256 subject</td>
  </tr>
  <tr>
    <td>vector<uint256> layers</td>
  </tr>
  <tr>
    <td rowspan="6">BTCBlock</td>
    <td>uint32 version</td>
    <td rowspan="6">A Bitcoin block header separated into its constituent values</td>
  </tr>
  <tr>
    <td>uint256 previousBlock</td>
  </tr>
  <tr>
    <td>uint256 merkleRoot</td>
  </tr>
  <tr>
    <td>uint32 timestamp</td>
  </tr>
  <tr>
    <td>uint32 bits</td>
  </tr>
  <tr>
    <td>uint32 nonce</td>
  </tr>
  <tr>
    <td rowspan="9">VBKBlock</td>
    <td>int32 height</td>
    <td rowspan="9">A VeriBlock block header separated into its constituent values</td>
  </tr>
  <tr>
    <td>int16 version</td>
  </tr>
  <tr>
    <td>uint96 previousBlock</td>
  </tr>
  <tr>
    <td>uint72 previousKeystone</td>
  </tr>
  <tr>
    <td>uint72 secondPreviousKeystone</td>
  </tr>
  <tr>
    <td>uint128 merkleRoot</td>
  </tr>
  <tr>
    <td>int32 timestamp</td>
  </tr>
  <tr>
    <td>int32 bits</td>
  </tr>
  <tr>
    <td>int32 nonce</td>
  </tr>
  <tr>
    <td rowspan="9">VBKPoPTransaction</td>
    <td>VBKNetworkBytePair networkOrType</td>
    <td rowspan="9">A PoP VeriBlock transaction, which proves the publication of a particular VeriBlock block header to the Bitcoin blockchain, and provides Bitcoin block headers (if necessary) to provide additional context about the VeriBlock blockchain</td>
  </tr>
  <tr>
    <td>VBKAddress address</td>
  </tr>
  <tr>
    <td>VBKBlock publishedBlock</td>
  </tr>
  <tr>
    <td>BTCTransaction bitcoinTransaction</td>
  </tr>
  <tr>
    <td>GenericMerklePath merklePath</td>
  </tr>
  <tr>
    <td>BTCBlock blockOfProof</td>
  </tr>
  <tr>
    <td>vector<BTCBlock> blockOfProofContext</td>
  </tr>
  <tr>
    <td>byte[] signature</td>
  </tr>
  <tr>
    <td>byte[] publicKey</td>
  </tr>    
  <td rowspan="3">VTB</td>
    <td>VBKPoPTransaction popTransaction</td>
    <td rowspan="3">VTB (“VeriBlock to Bitcoin”) package containing a VeriBlock-to-Bitcoin PoP transaction as well as a Merkle path proving inclusion of the VTB in a VeriBlock block</td>
  </tr>
  <tr>
    <td>VBKMerklePath merklePath</td>
  </tr>
  <tr>
    <td>VBKBlock containingBlock</td>
  </tr>
  <td rowspan="3">ATV</td>
    <td>VBKStandardTransaction transaction</td>
    <td rowspan="3">ATV (“Altchain to VeriBlock”) package containing a VeriBlock standard transaction proving publication of altchain state data to the VeriBlock blockchain</td>
  <tr>
    <td>VBKMerklePath merklePath</td>
  </tr>
  <tr>
    <td>VBKBlock blockOfProof</td>
  </tr>
  <td rowspan="2">VBKPoPDatastore</td>
    <td>uint64 altchainIdentifier</td>
    <td rowspan="2">Cryptographically authenticates which altchain block headers are endorsed in which amount under a particular altchain identifier</td>
  <tr>
    <td>vector<Pair<byte[], int16>> headerEndorsements</td>
  </tr>
  <tr>
    <td rowspan="3">VBKPoPDatastoreSlice</td>
    <td>uint64 altchainIdentifier</td>
    <td rowspan="3">A slice of a VBKPoPDatastore which authenticates a particular vector of headerendorsement pairs to a VBKPoPDatastore hash</td>
  </tr>  
  <tr>
    <td>vector<Pair<byte[], int16>> headerEndorsements</td>
  </tr> 
  <tr>
    <td>GenericMerklePath merklePath  </td>
  </tr>
  <tr>
    <td rowspan="1">ETCAddress</td>
    <td>uint160 addressBytes</td>
    <td rowspan="1">An address on the Ethereum Classic blockchain</td>
  </tr>  
  <tr>
    <td rowspan="2">ETCPoPPayout</td>
    <td>ETCAddress popBeneficiary</td>
    <td rowspan="2">An association between an address and the number of Wei to be paid out to the address for PoP rewards in a particular block</td>
  </tr>
  <tr>
    <td>uint64 payoutWei</td>
  </tr>
  <tr>
    <td rowspan="1">ETCPoPPayoutRound</td>
    <td>vector<ETCPoPPayout> payouts</td>
    <td rowspan="1">A collection of all ETCPoPPayouts paid in a particular block</td>
  </tr>
  <tr>
    <td rowspan="4">ETCBlockEndorsement</td>
    <td>byte[] blockHeader</td>
    <td rowspan="4">The collection of data published to the VeriBlock blockchain to endorse a particular Ethereum Classic block. Note that the blockHeader will not include the contentRoot (which replaces the transactionsRoot in the PoP-integrated version of the Ethereum Classic block header) because the hash of the previousKeystones combined with the provided transactionsRoot can be used to recalculate the contentRoot.</td>
  </tr>
  <tr>
    <td>vector<uint256> previousKeystones</td>
  </tr> 
  <tr>
    <td>uint256 transactionsRoot</td>
  </tr> 
  <tr>
    <td>ETCAddress popMinerAddress</td>
  </tr> 
</table>

## Overview
When integrated into Ethereum Classic, **VeriBlock Proof-of-Proof will function by creating a new class of miner on the Ethereum Classic network** (an Ethereum Classic Proof-of-Proof miner) **who is rewarded for publishing endorsements of Ethereum Classic blocks in the VeriBlock blockchain.**

**The VeriBlock network itself is secured using the Proof-of-Proof protocol to the Bitcoin blockchain** using a similar mechanism (Proof-of-Proof miners on the VeriBlock network publish endorsements of VeriBlock blocks to Bitcoin).

Proof-of-Proof miners on the Ethereum Classic blockchain spend VeriBlock coins (VBK) to publish Ethereum Classic block headers (and accompanying context data which introduces a braided block reference pattern to the Ethereum Classic blockchain) to the VeriBlock blockchain.

Similarly, on the VeriBlock blockchain, VeriBlock Proof-of-Proof miners spend Bitcoin (BTC) to publish VeriBlock block headers to the Bitcoin blockchain. 

As a result, **the VeriBlock blockchain inherits Bitcoin PoW security to protect against double-spend attacks, and the Ethereum Classic blockchain inherits Bitcoin + VeriBlock PoW security to protect against double-spend attacks.**

![ETC and VBK Flow](/assets/ecip-vbkpop/etc_vbk_flow.png)

The protection against long-range reorganizations that Proof-of-Proof functions because Proof-of-Proof-enabled blockchains modify their fork resolution protocol to consult publications of both alternative chains to determine the canonical chain. **As a result, an attacker who wants to cause a surprise reorganization in a Proof-of-Proof-secured blockchain has to announce their attack “in-step” with the main chain by publishing fingerprints of their attacking chain in a timely manner.** These publications can be seen by any Ethereum Classic network participant by looking at the VeriBlock and Bitcoin blockchains. 

As a practical example, with the recent 51% attacks against Ethereum Classic, if Proof-of-Proof were implemented the attacker would have to publish fingerprints of their attacking chain to VeriBlock “in-step” with the main chain, **so long before the attack occurred it would have been publicly known at what block height the attacker’s ETC fork started, and whether the attack were still a potential threat.** In the absence of an active attack (or the abandonment of a previously active attack), **blocks (and thus, transactions) on the Ethereum Classic network would have reached Bitcoin finality which provides a mathematical guarantee that the block (and its containing transactions) could not be reversed without performing a 51% attack on Bitcoin itself.**

Normally when a security-inheriting chain has no competing publications in the security-providing chain, blocks on the network achieve spFinality (mathematical certainty that the block cannot be reverted/overwritten without also 51% attacking the security-providing blockchain) like so:

![SI Chain No Competition](/assets/ecip-vbkpop/si_inheriting_no_competition.png)

In the event that a competing security-inheriting blockchain is also published to the security-providing blockchain in a timely manner:

![SI Chain Competition Attack](/assets/ecip-vbkpop/si_inheriting_attack.png)

And when the attacking chain is eventually abandoned, the main security inheriting chain will begin getting spFinality because of the attacking chain abandonment:

![SI Chain Competition Attack Resolved](/assets/ecip-vbkpop/si_inheriting_attack_resolved.png)

The implementation of Proof-of-Proof on the Ethereum Classic blockchain requires small modifications to:

*	*****Block reward generation and validation code***** (to add additional beneficiaries to receive Proof-of-Proof payouts)
*	*****Ethereum Classic block structure***** (to add in Proof-of-Proof data about the Bitcoin and VeriBlock blockchains, and publications of Ethereum Classic block headers)
*	*****Fork resolution protocol***** (to consult publications of Ethereum Classic on VeriBlock and Bitcoin blockchains)
*	*****P2P messaging protocol***** (to add commands which communicate ATV, VTB, and VBK block data)
*	*****EVM***** (updated Opcode to expose Bitcoin finality)


Much of the functionality for validating and processing VeriBlock-related data, keeping track of the VeriBlock and Bitcoin blockchain state, and performing fork resolution is already implemented as part of a pre-built altchain integration library which is a C++ library designed to be called from any language. The changes to Ethereum Classic to implement Proof-of-Proof leverage this existing library, minimizing the amount of functionality which must be implemented in the Ethereum Classic codebase itself.   
VeriBlock Proof-of-Proof requires the determination of several parameters, which are selected based on the block time and block variability of the network, and size of rewards intended for payout to Proof-of-Proof miners.

The exact values of these parameters must be the result of public community discussion and consensus. 

Additional details for what these parameters do and how they should be selected is available in the [VeriBlock whitepaper](http://bit.ly/vbk-wp-pop "VeriBlock Whitepaper").


<table> 
  <tr>
    <th>Parameter</th>
    <th>Description</th>
    <th>Proposed Value</th>
  </tr>
  <tr>
    <td>keystoneInterval</td>
    <td>The frequency of keystone blocks on the Ethereum Classic network. PoP security operates at they keystone level, and keystones are used to create a braided reference pattern in blocks such that the endorsement of a block connects it to non-immediate ancestors to maintain security and publication continuity without requiring publication of every Ethereum Classic block to VeriBlock</td>
    <td>40<br>
Reasoning: Ethereum Classic’s ~15 second block time would make a keystone period occur once every ~10 minutes
</td>
  </tr>
  <tr>
    <td>numReferencedKeystones</td>
    <td>The number of previous keystones that a block references</td>
    <td>2<br>
Reasoning: With a keystoneInterval of 40, this allows for a publication of a keystone itself or the block immediately following to provide context for 20 minutes of ETC, and for a publication of any other block to provide context for 10 minutes of ETC. 
</td>
  </tr>
  <tr>
    <td>keystoneFinalityDelay</td>
    <td>The number of VeriBlock blocks that must pass before a particular ETC block cannot be reversed without reorganizing the VeriBlock blockchain itself</td>
    <tdTBD – Based on Ethereum Classic difficulty algorithm aggression></td>
  </tr>
  <tr>
    <td>popRewardSettlementInterval</td>
    <td>The number of Ethereum Classic blocks after a particular block which allows endorsements of the particular block to be included in the Ethereum Classic blockchain</td>
    <td>1000<br>
Reasoning: This allows approximately four hours of Ethereum Classic blocks for endorsements to be returned to the chain
</td>
  </tr>
  <tr>
    <td>popRewardPaymentDelay</td>
    <td>The number of Ethereum Classic blocks which elapse after a particular block before the rewards for endorsements of the particular block are paid out</td>
    <td>1250<br>
Reasoning: 1.25x the popRewardSettlementInterval
</td>
  </tr>
  <tr>
    <td>forkResolutionRelativeScoreLookupTable</td>
    <td>A function used during Proof-of-Proof fork resolution to look up the fork resolution weight of a publication relative to the first publication of a keystone of either chain being compared</td>
    <td>1/(pubTime-amnesty)^(1.05) 
where pubTime is the relative timeliness of the publication and amnesty is 40 VeriBlock blocks, and where the function returns 0 when pubTime > keystoneFinalityDelay

Reasoning: The 20-VBK-block amnesty time is approximately 20 minutes or 80 ETC blocks long, meaning that an attacker would have to produce ETC blocks at a significantly faster rate than the main network to begin getting a PoP fork resolution advantage.
</td>
  </tr>
  <tr>
    <td>popPayoutRewardCurves</td>
    <td>The curves which, all endorsements of a block (including their timeliness to VBK relative to the first endorsement), and the historical publication quantities and timeliness of previous blocks, calculates what reward is to be paid out to each endorsement.</td>
    <td>TBD – Based on community input about how many rewards will be allocated to PoP mining, and the finalization of other parameters</td>
  </tr>
  <tr>
    <td>altchainPoPIdentifier</td>
    <td>The identifier used to mark publications on VeriBlock as (potentially) relevant to Ethereum Classic </td>
    <td>TBD – Can be 1-8 arbitrary bytes, such as 0x455443504F50 (“ETCPOP” in ASCII)</td>
  </tr>
  <tr>
    <td>altchainTxOffloadIdentifier</td>
    <td>The identifier used to mark offloaded transactions on VeriBlock as (potentially) relevant to Ethereum Classic</td>
    <td>TBD – Can be 1-8 arbitrary bytes, such as 0x4554435458 (“ETCTX” in ASCII)</td>
  </tr>
</table>

## Block Reward Generation and Validation Code
Normally, Ethereum Classic pays out a block reward to a block’s beneficiary according to an emissions schedule. Integrating Proof-of-Proof will add additional payouts to Proof-of-Proof miners who secure the Ethereum Classic network.

These payouts will be calculated based on proofs Ethereum Classic PoP miners return to the Ethereum Classic network that prove they published Ethereum Classic blocks to the VeriBlock blockchain.

The exact reward algorithm and magnitude of rewards need to be determined based on community discussions and consensus, however the reward algorithm should have the following properties:

1.	*****Ethereum Classic PoP miners are incentivized to publish Ethereum Classic block endorsements as quickly as possible***** to the VeriBlock blockchain to optimize the speed at which the Ethereum Classic blockchain reaches Bitcoin finality for particular blocks

2.	*****Rewards are sufficiently large such that a sufficient number of PoP miners are incentivized to participate in PoP mining***** in a variety of VeriBlock fee market scenarios

3.	*****The reward calculation introduces predictable and cyclic “jitter”***** for robust handling of different VeriBlock fee market scenarios

The PoP rewards paid out in a particular block are calculated using the `popPayoutRewardCurves` to be determined by the Etherum Classic community consensus, and will be based on the total number and relative timelinesses of the publications of endorsements of the block for which rewards are being paid out (block x pays out PoP rewards for endorsements of block `x – popRewardPaymentDelay`), and the recent publication quantities and timelinesses of blocks prior to block x. The exact weighting of past scores (the PoP difficulty) will be determined as part of the determination of `popPayoutRewardCurves`.

The functionality for calculating rewards based on publication timeliness is implemented by the C++ altchain integration library, which will handle tracking all of the endorsements of each Ethereum Classic block, calculating their relative publication timelinesses, and calculating the PoP difficulty based on publications of blocks prior to the one targeted by a particular reward calculation.

**The Ethereum Classic blockchain code responsible for generating prototype blocks for mining needs to call the altchain integration C++ library to acquire the correct PoP reward payouts**, and include these PoP reward payouts in the block (see the “popPayouts” section added to the Ethereum Classic block format in the Block Structure Modification section) ***in the order that they are returned from the library in***, discarding any that don’t have a valid Ethereum Classic address as a payout destination. Additionally, the code which gathers transactions to include in a block must be further modified to query the altchain integration C++ library’s built-in mempool of ATV, VTB, and VeriBlock header information to determine which ATVs, VTBs, and VeriBlock headers should be included in the block, and to add those data structures to the prototype block, updating the contentRoot accordingly.

**The Ethereum Classic blockchain code responsible for validating new blocks received from the network needs to call the altchain integration C++ library to acquire the correct PoP reward payouts when processing a particular Ethereum Classic block, and ensure that the returned PoP reward payouts match those returned from the library**, less any that don’t have a valid Ethereum Classic address as a payout destination. If the calculated payouts don’t match the ones included in the block, then the block must be rejected as invalid (similar to if the block contained an invalid transaction).

**The Ethereum Classic blockchain code responsible for paying out the Proof-of-Work reward to the beneficiary miner needs to be updated to also perform the respective payouts to all addresses contained in the PoP payout** for the block being processed.

Additionally, **the Ethereum Classic blockchain code responsible for processing blocks needs to pass VTB, ATV, and VeriBlock header data stored in the updated Ethereum Classic block structure (see the Block Structure Modification section) to the integration library, and ensure that the return values of the calls to the integration library don’t indicate a failure.** If a failure is encountered, the block must be treated invalid (similar to if the Ethereum Classic block contained an invalid transaction). 

Furthermore, **the code needs to be updated to check that the `VBKPoPDatastoreSlice` associated with each `VBKBlock` either**: 
1.	Proves a mapping of `altchainTxOffloadIdentifier` to one or more potential offloaded Ethereum Classic transactions
2.	Proves two mappings of unrecognized altchain Tx identifiers which are contiguous given their Merkle path indexes and which are smaller and larger (respectively) than `altchainTxOffloadIdentifier`, proving that the VBK block contains no potential offloaded Ethereum Classic transactions 

Finally, **the Ethereum Classic blockchain code responsible for processing block transactions needs to be updated to attempt to process all transactions associated with the `altchainTxOffloadIdentifier` directly after processing the regular transactions in the Ethereum Classic block.** If any of the transactions are invalid (formatted incorrectly, not signed or signed incorrectly, spends ETC that an address does not have, contains an invalid opcode, etc.) then the transaction must be ignored (but the Ethereum Classic block being processed ***MUST NOT*** be marked invalid as would be the case if a normal transaction in the block was invalid). 

## Block Structure Modification
**Blocks on the Ethereum Classic blockchain must have three data sections added to it to store data returned from PoP miners** (which allows the blockchain to properly reward PoP miners as well as reference PoP data during fork resolution to protect against 51% attacks), **and an additional data section added to it to store PoP payouts paid out to PoP miners in the block. Additionally, the blocks will be modified to cryptographically authenticate these data sections, as well as to cryptographically authenticate a new data structure which contains references to previous Ethereum Classic blocks (creating a braided reference pattern) to provide publication continuity without requiring the publication of all Ethereum Classic blocks to VeriBlock.**

The following additional fields will be added to Ethereum Classic blocks:

<table> 
  <tr>
    <th>Field</th>
    <th>Notes</th>
  </tr>
  <tr>
    <td>vector<Pair<VBKBlock, VBKPoPDatastoreSlice>> vbkHeaders</td>
    <td>Headers to maintain SPV-level knowledge of the VeriBlock blockchain, and their associated VBKPoPDatastoreSlices which authenticate altchain publication data to the VeriBlock block header</td>
  </tr>
  <tr>
    <td>vector<VTB> vtbs</td>
    <td>VTBs to maintain VeriBlock blockchain security based on publications of VeriBlock in Bitcoin</td>
  </tr>
  <tr>
    <td>vector<ATV> atvs</td>
    <td>ATVs which record publications of Ethereum Classic blocks in the Ethereum Classic blockchain</td>
  </tr>
  <tr>
    <td>vector<ETCPoPPayout> popPayouts</td>
    <td>PoP payouts processed in this block rewarding PoP miners for securing a previous ETC block</td>
  </tr>
  <tr>
    <td>vector<uint256> previousKeystones</td>
    <td>A vector containing two hashes of previous Ethereum Classic blocks (two previous keystones, as described later)</td>
  </tr>
</table>

The vbkHeaders vector entries will be added in the order they appear in the vector to a Keccak-256-based Merkle tree, and the top-level hash of this tree will be termed the `vbkHeadersRoot`.

The vtbs vector entries will be added in the order they appear in the vector to a Keccak-256-based Merkle tree, and the top-level hash of this tree will be termed the `vtbsRoot`.

The atvs vector entries will be added in the order they appear in the vector to a Keccak-256-based Merkle tree, and the top-level hash of this tree will be termed the `atvsRoot`.

The popPayouts entries will be added in the order they appear in the vector to a Keccak-256-based Merkle tree, and the top-level hash of this tree will be termed the `popRewardsRoot`.

The `vbkHeadersRoot`, `vtbsRoot`, `atvsRoot`, and `popRewardsRoot` will be added in that order to a Keeccak-256-based Merkle tree, and the top-level hash of this tree will be termed the `popDataRoot`.

The `popDataRoot` and the Keccak-256 hash of the two uint256 values constituting the `previousKeystones` vector (serialized as a single uint512 value and with the serialization order of the `previousKeystones` elements based on their order in the vector) will be added to a Keccak-256-based Merkle tree, and the top-level hash of this tree will be termed the `popTopRoot`. 

The `transactionsRoot` (calculation unchanged from standard Ethereum Classic) and the `popTopRoot` will be added in that order to a Keccak-256-based Merkle tree, and the top-level hash of this tree will be termed the `contentRoot`. 

This `contentRoot` will replace the `transactionsRoot` in the block header of Ethereum Classic blocks:

![Ethereum Classic Header Hash Format and Calculation](/assets/ecip-vbkpop/etc_header_hash_format.png)

Adding the `popTopRoot` to the right of the `transactionsRoot` allows maximal compatibility with existing software by making the indexes of transactions in the Ethereum Classic block’s transaction tree stay the same as before, and only requiring the addition of the `popTopRoot` in the Merkle path to authenticate transactions against the root in the header.

## Fork Resolution Modification
**The Ethereum Classic blockchain code which determines whether a reorganization should occur upon receipt of a non-mainchain block needs to be updated to consult the altchain integration C++ library to determine whether the blockchain should be reorganized based on Proof-of-Proof data.**

## P2P Message Protocol Modification
**The Ethereum Classic blockchain code which handles sending and receiving P2P messages needs to be introduced to add new P2P commands:**

<table> 
  <tr>
    <th>Command</th>
    <th>Parameters</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>PoPOffer<VTB/ATV/VBKHeader></td>
    <td>uint256 hash</td>
    <td>Offers a VTB, ATV, or VBKHeader by providing the SHA256 hash of the data structure</td>
  </tr>
  <tr>
    <td>PoPGet<VTB/ATV/VBKHeader></td>
    <td>uint256 hash</td>
    <td>Requests a VTB, ATV, or VBKHeader based on the SHA256 hash of the data structure</td>
  </tr>
  <tr>
    <td>PoPSend<VTB/ATV/VBKHeader></td>
    <td>VTB vtb or
ATV atv or
VBKHeader vbkHeader
</td>
    <td>Sends the requested VTB, ATV, or VBKHeader</td>
  </tr>
</table>

Additionally, the anti-DoS portion of the P2P code should penalize (and eventually ban/disconnect from) peers who:
1.	Send `PoPOffers` with hashes and then don’t respond with a valid `PoPSend` when a corresponding `PoPGet` is sent by the local node (or sends invalid data in response to the `PoPGet`, invalidity determined by a failure when attempting to add the received data structure to the altchain integration C++ library PoP data mempool)
2.	Send `PoPGet`s for hashes which the local node never sent a `PoPOffer` advertising
3.	Sends `PoPSend`s for `VTB`s, `ATV`s, or `VBKHeader`s which the local node never sent a `PoPGet` requesting

**The code which handles receiving P2P commands must call the altchain integration C++ library and add the received `VTB`, `ATV`, or `VBKHeader`s to the altchain integration C++ library’s PoP data mempool (so that the data can be eventually incorporated into the Ethereum Classic blockchain by miners).**

## EVM Modification

The EVM must have an additional opcode `BITCOINFINALITY` implemented, which exposes the Bitcoin finality of an Ethereum Classic block (identified by block number on the current active chain).

This opcode allows smart contracts to be aware of the finality of a block (and thus, the transactions in it and the state modifications that those transactions result in). Smart contracts could use this opcode to only execute certain functions once a certain threshold of Bitcoin finality is reached for a block which caused a previous state modification.

**The opcode takes a single argument from the top of the stack** (a block index, where the genesis block’s block index is 0), **and pushes a single value indicating the Bitcoin finality of that Ethereum Classic block (if it exists) to the top of the stack**. If the block index is a block which does not exist, then the Bitcoin finality will be 0. The Bitcoin finality value will be 0 to indicate no Bitcoin finality, or a positive integer to indicate a number of Bitcoin blocks providing finality for the particular Ethereum Classic block. 

The `BITCOINFINALITY` opcode functions internally by:

1.	Determining whether a block at the provided index exists (if not, push 0 to the stack and exit)
2.	Acquiring the hash of the block at the provided index (note that the 256-block limit of the existing BLOCKHASH opcode is to small for this query, so this query must be done without using functionality from the `BLOCKHASH` opcode)
3.	Querying the altchain integration C++ library to determine the Bitcoin finality of the particular Ethereum Classic block hash, pushing the returned value onto the EVM stack
The numerical opcode which identifies `BITCOINFINALITY` will be chosen by community consensus such that it doesn’t collide with any other proposals for opcodes in Ethereum Classic or Ethereum.

The numerical opcode which identifies `BITCOINFINALITY` will be chosen by community consensus such that it doesn’t collide with any other proposals for opcodes in Ethereum Classic or Ethereum.

# Rationale
Integrating VeriBlock Proof-of-Proof into Ethereum Classic allows Ethereum Classic to prevent both types of 51% attacks (surprise long-range reorganizations and censorship attacks) by inheriting the Proof-of-Work security of Bitcoin. Blocks (and thus transactions) on Ethereum Classic would receive Bitcoin confirmations as well as standard Ethereum Classic confirmations, and as soon as transactions on Ethereum Classic achieve a nonzero number of Bitcoin confirmations, they can be accepted with the same (technically higher) security as transactions on Bitcoin.

Proof-of-Proof takes the guesswork out of transaction security, allowing ecosystem participants to accept transactions as finalized with the full security guarantees of Bitcoin’s Proof-of-Work. 

Additionally, the anti-censorship capabilities that VeriBlock introduces through transaction offloading protect applications and protocols deployed on Ethereum Classic from many other sophisticated attacks from forcibly redeeming old payment channel states to desynchronizing 1:1 asset pairs to censoring voting mechanisms in decentralized governance systems.

Proof-of-Proof doesn’t replace Ethereum Classic’s existing Proof-of-Work algorithm but provides reinforcement of it based on Bitcoin, and doesn’t introduce any centralized system or modify the blockchain’s governance system (adoption of hard forks, etc. is still done by consensus amongst PoW miners).

Adjustments can be made to how Proof-of-Proof is integrated into Ethereum Classic based on tradeoffs between backwards compatibility with existing software, ease of implementation, data size, and tolerable levels of introduced complexity. As well, some parts of the VeriBlock integration can be skipped; the transaction offloading system that provides protection against 51% censorship attacks could be removed while still integrating Proof-of-Proof to provide security against surprise long-range reorganizations, and the integration of the `BITCOINFINALITY` opcode can be skipped to reduce the amount of data required to be stored directly on-chain (versus acquired by only nodes wanting to access Bitcoin finality statistics) if desired. 

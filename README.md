# ECIPs

# Summary

This document is a summary of the Ethereum Classic Improvement Proposal (ECIP) process. To view the full description of the ECIP process please read [ECIP-1000](https://github.com/ethereumclassic/ECIPs/blob/master/ECIPs/ECIP-1000.mediawiki) which is the formal document generally acknowledged by the Ethereum Classic (ETC) ecosystem, by [rough consensus](https://en.wikipedia.org/wiki/Rough_consensus), as the most suitable system to propose new standard changes to the ETC protocol, informational documents, or ECIP process suggestions.

# Getting Started
After reading [ECIP-1000](https://github.com/ethereumclassic/ECIPs/blob/master/ECIPs/ECIP-1000.mediawiki), the [ECIP sample](./ECIP-1.sample.md) is the best place to continue. The sample was updated for Ethereum use by Martin Becze, it was predominantly derived from the Bitcoin improvement proposal process based on the Python improvement proposal system. Fork the repository and add your ECIP to it, using the provided [ECIP markdown template](./ECIP-number.template.md). Submit by creating a Pull Request to the Ethereum Classic [ECIPs repository](https://github.com/ethereumclassic/ECIPs).

# Types of Participants

As you will see by reading this summary and the other documents suggested above, there are several parties that participate in the life cycle of an ECIP:

- **ECIP Author:** This is you! The author is the person interested in improving ETC by making a new ECIP. Therefore, responsible for learning how the process works, so he or she can effectively propose protocol changes, informational or procedural improvements. The author is also responsible for following up on the ECIP life cycle throughout all the status steps, from 'draft' to 'active' as described below, so the proposal becomes a reality. If not, it is possible that the ECIP will be eventually rejected.
- **Editors:** Editors are developers, mainly ETC volunteers, members of the Ethereum Classic Github Organization whose responsibilities include, but are not limited to, assigning numbers to ECIPs, merging them, listing them in the ECIP directory, checking if they are ready, sound and complete, if the status steps are followed, and to check their motivation, accuracy and proper licensing terms.
- **Core Developer Team:** ETC has several developer companies and volunteer developers who work on different node clients. Because these developers are dedicated to maintaining the core protocol of Ethereum Classic, they are categorized as "core developers" or "core developer team". Core developers are in charge of making new proposals or reviewing and accepting or rejecting proposals from other developers or teams. When they accepts new changes, they merge them into the respective clients they maintain for the ETC network.
- **Implementers:** Once an ECIP is accepted and merged, the last step is for miners, mining pools, wallet operators, exchanges, and other full node operators to implement the changes by installing or upgrading their nodes to integrate the new changes. These operating network participants are called "implementers". 
- **Users:** Users or end users may be regular consumers, businesses, governments, non-economic node operators, investors, or other kinds of users who see when the implementers upgraded their systems and adopt the new rules for sending transactions and managing smart contracts or using applications on top of ETC. 
- **Discussion Participants:** According the ECIP process, when moving ECIPs forward, authors will open for discussion their proposals. These discussions are located in public forums, Github or developer calls. Discussion participants may be core or volunteer Ethereum Classic client developers, any developers on Github willing to contribute their well reasoned opinions, and other interested stakeholders or participants in the ETC ecosystems.

# Contributing

### Steps

 1. Review [ECIP-1](./ECIP-1.sample.md).
 2. Fork the repository by clicking "Fork" in the top right.
 3. Add your ECIP to your fork of the repository. There is a [template ECIP here](ECIP-number.template.md).
 4. Submit a Pull Request to Ethereum Classic's [ECIPs repository](https://github.com/ethereumclassic/ECIPs).

### Format and Numbering

Your first PR should be a first draft of the final ECIP. It must meet the formatting criteria enforced by the build (largely, correct metadata in the header). An editor will manually review the first PR for a new ECIP and assign it a number before merging it. Make sure you include a `discussions-to` header with the URL to a discussion forum or open GitHub issue where people can discuss the ECIP as a whole.

### Images

If your ECIP requires images, the image files should be included in a subdirectory of the `assets` folder for that ECIP as follow: `assets/ecip-X`. When linking to an image in the ECIP, use the related links such as `./assets/ecip-X/image.png`.

### Tips

When you believe your ECIP is mature and ready to progress past the draft phase, you should do one of two things:

 - **For a Standards Track ECIP of type Core**, ask to have your issue added to the agenda of an upcoming core developer team meeting. There, it can be discussed for inclusion in a future hard fork. If developers agree to include it, the ECIP editors will update the state of your ECIP to 'Accepted'.
 - **For all other ECIPs**, open a PR changing the state of your ECIP to 'Final'. An editor will review your draft and ask if anyone objects to its finalization. If the editor decides there is no rough consensus - for instance, because contributors point out significant issues with the ECIP - they may close the PR and request that you fix the issues in the draft before trying again.

# ECIP Status Terms
* **Draft** - An ECIP that is undergoing rapid iteration and changes.
* **Last Call** - An ECIP that is done with its initial iteration and ready for review by a wider audience.
* **Accepted** - An ECIP that has been in Last Call for at least 2 weeks and any technical changes that were requested have been addressed by the author.
* **Final** - An ECIP that was accepted, implemented, and no longer can be modified without submitting a new proposal, e.g., it has been released in a hard fork.
* **Deferred** - An ECIP that is not being considered for immediate adoption. May be reconsidered in the future for a subsequent hard fork.
* **Replaced** - When a Final ECIP is no longer relevant, its status may be changed to Replaced or Obsolete.
* **Rejected** - Reasons for rejecting ECIPs include duplication of effort, disregard for formatting rules, unfocused or too broad, being technically unsound, not providing proper motivation, or obvious popular disapproval.
* **Withdrawn** - ECIP authors may decide to change the status between Draft, Deferred, or Withdrawn. The ECIP editor may also change the status to Deferred if no progress is being made on the ECIP.

# Important ECIPs

## Accepted ECIPs

| Number        | Title        | Author | Type  | Layer        | Status / Discussion |
| ------------- | ------------ | ------ | ----- | -------------| ------------------- |
| [ECIP-1010](ECIPs/ECIP-1010.md) | Delay Difficulty Bomb Explosion | Igor Artamonov | Standard | Consensus (hard-fork) | Accepted |
| [ECIP-1017](ECIPs/ECIP-1017.md) | Monetary Policy and Final Modification to the Ethereum Classic Emission Schedule | Matthew Mazur | Standard | Consensus (hard-fork) | Accepted |

## Inherited EIPs (Ethereum Improvement Proposals) That Apply to the Ethereum Classic Network

| Number        | Title        | Author | Type  | Layer        | Status / Discussion |
| ------------- | ------------ | ------ | ----- | -------------| ------------------- |
| [EIP-2](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-2.mediawiki) | Homestead Hard-fork Changes | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |
| [EIP-7](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-7.md) | DELEGATECALL | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |
| [EIP-8](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-8.md) | devp2p Forward Compatibility Requirements for Homestead | Felix Lange | Standard | Networking | Final |
| [EIP-141](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-141.md) | Designated invalid EVM instruction | Alex Beregszaszi | Standard | Consensus | Final |
| [EIP-150](https://github.com/ethereum/EIPs/issues/150) | Long-term gas cost changes for IO-heavy operations | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |
| [EIP-155](https://github.com/ethereum/EIPs/issues/155) | Simple replay attack protection | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |
| [EIP-160](https://github.com/ethereum/EIPs/issues/160) | EXP cost increase | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |

# Process Overview

Ethereum Classic Improvement Proposals (ECIPs), are technical write-ups that describe suggested changes to the Ethereum Classic Protocol. Finalized proposals agreed by core and volunteer client developers, implementers and other users of the Ethereum Classic mainnet are implemented by the core developer team into their respective clients.

Every pull request will be reviewed and discussed by core and volunteer Ethereum Classic developers and any developers on Github willing to contribute their well reasoned opinions. Regardless whether there is general agreement, you are still able to use the information generated in the discussions to create a second draft. This can be done by either updating the pull request or submitting a new pull request. This process may be repeated (See figure 1) until the ETC developer community agrees to add the pull request.

![Figure 1: The cyclic process of proposal and review](./process.png "Figure 1: The process of proposal and review")

Having an ECIP within the folder of the repository does not make it a formally accepted standard until its status becomes "Final". For an ECIP to become Final it requires the common consent of the ecosystem. Those proposing changes should consider that, ultimately, consent may rest with the consensus of the Ethereum Classic implementers and users.

# ECIPs Historical Background

ECIPs were born out of the [Ethereum](https://github.com/ethereum/EIPs) (or Ethereum Foundation) EIP repository after [TheDAO hard fork](https://en.wikipedia.org/wiki/The_DAO_(organization)). At that time no other differences between Ethereum Classic (the original mainnet) and Ethereum existed besides TheDAO hard-fork. Changes have since been added such as the early defusal of the difficulty bomb and a change of the monetary policy to a fixed supply.

### Avoiding Network Splits

**Pushing changes to the protocol without consensus will cause a network split. The ECIP process should not be skipped**, as previously done by Ethereum Foundation developers who unilaterally implemented a rushed hard-fork in the most widely used client, therefore creating a network split at block 1920000.

### Decentralized Decision making

The Ethereum Foundation raised money from the community to work towards the "mission to promote and support research, development and education to bring decentralized protocols", but failed at that goal when, shortly after TheDAO exploit, Vitalik Buterin announced, using the Ethereum Foundation blog, that they had already unilaterally decided to fork. A [chat log](http://pastebin.com/raw/aMKwQcHR) from an internal chat reveals this decision was made prior to the announcement, and comments like "default behavior of Geth to be pro-fork as per internal discussions" found in DAO hard-fork [pull requests](https://github.com/ethereum/go-ethereum/pull/2814), and the unwillingness to use their own proposal system, show that the narrative in which the Ethereum Foundation followed the will of the community was clearly wrong. What the Ethereum foundation did was the opposite of decentralized decision making.

# Conclusion

Decentralized decision making is part of the deep security that protects the integrity of the Ethereum Classic blockchain. It is critical for keeping the promise of "applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference."

**In other words, please follow the ECIP process!**

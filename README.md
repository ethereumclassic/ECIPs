# ECIPs


# Getting started contributing
The [ECIP sample](./ECIP-1.sample.md) is the best place to start. The sample was updated for Ethereum use by Martin Becze, it was predominantly derived from the Bitcoin improvement proposal based on the Python improvement proposal system. Fork the repository and add your ECIP to it, using the provided [ECIP markdown template](./ECIP-number.template.md). Submit by creating a Pull Request to the Ethereum Classic [ECIPs repository](https://github.com/ethereumclassic/ECIPs).

# Contributing

 1. Review [ECIP-1](./ecip-1.sample.md).
 2. Fork the repository by clicking "Fork" in the top right.
 3. Add your ECIP to your fork of the repository. There is a [template ECIP here](ecip-number.template.md).
 4. Submit a Pull Request to Ethereum Classic's [ECIPs repository](https://github.com/ethereumclassic/ECIPs).

Your first PR should be a first draft of the final ECIP. It must meet the formatting criteria enforced by the build (largely, correct metadata in the header). An editor will manually review the first PR for a new ECIP and assign it a number before merging it. Make sure you include a `discussions-to` header with the URL to a discussion forum or open GitHub issue where people can discuss the ECIP as a whole.

If your ECIP requires images, the image files should be included in a subdirectory of the `assets` folder for that ECIP as follow: `assets/eip-X` (for ecip **X**). When linking to an image in the ECIP, use relative links such as `../assets/ecip-X/image.png`.

When you believe your ECIP is mature and ready to progress past the draft phase, you should do one of two things:

 - **For a Standards Track ECIP of type Core**, ask to have your issue added to the agenda of an upcoming All Dev Team meeting, where it can be discussed for inclusion in a future hard fork. If implementers agree to include it, the ECIP editors will update the state of your ECIP to 'Accepted'.
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

# Accepted ECIPs

| Number        | Title        | Author | Type  | Layer        | Status / Discussion |
| ------------- | ------------ | ------ | ----- | -------------| ------------------- |
| [ECIP-1010](ECIPs/ECIP-1010.md) | Delay Difficulty Bomb Explosion | Igor Artamonov | Standard | Consensus (hard-fork) | [Accepted](https://github.com/ethereumproject/ECIPs/issues/4) |
| [ECIP-1017](ECIPs/ECIP-1017.md) | Monetary Policy and Final Modification to the Ethereum Classic Emission Schedule | Matthew Mazur | Standard | Consensus (hard-fork) | Accepted |

# EIPs that applies to Ethereum Classic network

| Number        | Title        | Author | Type  | Layer        | Status / Discussion |
| ------------- | ------------ | ------ | ----- | -------------| ------------------- |
| [EIP-2](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-2.mediawiki) | Homestead Hard-fork Changes | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |
| [EIP-7](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-7.md) | DELEGATECALL | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |
| [EIP-8](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-8.md) | devp2p Forward Compatibility Requirements for Homestead | Felix Lange | Standard | Networking | Final |
| [EIP-141](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-141.md) | Designated invalid EVM instruction | Alex Beregszaszi | Standard | Consensus | Final |
| [EIP-150](https://github.com/ethereum/EIPs/issues/150) | Long-term gas cost changes for IO-heavy operations | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |
| [EIP-155](https://github.com/ethereum/EIPs/issues/155) | Simple replay attack protection | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |
| [EIP-160](https://github.com/ethereum/EIPs/issues/160) | EXP cost increase | Vitalik Buterin | Standard | Consensus (hard-fork) | Final |


Ethereum Classic Improvement Proposals (ECIPs), are technical write-ups that describe suggested changes to the Ethereum Protocol. Finalized proposals agreed up by volunteer client developers, and the users of the Ethereum Classic main net blockchain are implemented by Ethereum Classic client developers.

Every pull request will be reviewed and discussed by volunteer Ethereum Classic client developers and any developers on Github willing to contribute their well reasoned opinions. Regardless if there is general agreement you are able to use the information generated from the discussion to create a second draft. This can be done by either updating the pull request or submitting a new pull request. This process can be repeated (See figure 1) until the volunteer developer community agrees to add the pull request.

![Figure 1: The cyclic process of proposal and review](./process.png "Figure 1: The process of proposal and review")

Having an ECIP within the folder of the repository does not make it a formally accepted standard until its status becomes Active. For an ECIP to become Active requires the mutual consent of the community. Those proposing changes should consider that ultimately consent may rest with the consensus of the Ethereum Classsic users.

ECIPs grew out of the now hard-forked Ethereum DAO hard-fork (or ETF) repository, at which time no other differences between Ethereum Classic/original main net and Ethereum DAO hard-forked besides the DAO hard-fork. Changes have since been added such as early defusal of the difficulty bomb.

# Network split

Pushing changes to the protocol without consensus will cause a network split. The ECIP process should not be skipped, as previously done by Ethereum Foundation developers who unilaterally implemented a rushed hard-fork in the most widely used client thereby creating a network split at block 1920000.

The Ethereum Foundation raised money from the community to work towards the "mission to promote and support research, development and education to bring decentralized protocols", bur failed that goal when shortly after the DAO exploit was used Vitalik Buterin announced using the Ethereum Foundation blog that they had already unilaterally decided on forking. A [chat log](http://pastebin.com/raw/aMKwQcHR) from an internal chat reveals this decision was made prior to the announcement, and comments like "default behavior of Geth to be pro-fork as per internal discussions" found in DAO hard-fork [pull requests](https://github.com/ethereum/go-ethereum/pull/2814) and the unwillingness to use their own proposal system show that the narrative in which the Ethereum Foundation followed the will of the community is clearly wrong. What the Ethereum foundation did was the opposite of decentralized decision making. 

Decentralized decision making is part of the in-depth security that protects the integrity of the Ethereum Classic blockchain. It is critical for keeping the promise of "applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference."



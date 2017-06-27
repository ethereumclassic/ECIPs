# ECIP

[![Join the chat at https://gitter.im/ethereumproject/ECIPs](https://badges.gitter.im/ethereumproject/ECIPs.svg)](https://gitter.im/ethereumproject/ECIPs?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Ethereum Classic Improvement Proposals (ECIPs), are technical write-ups that describe suggested changes to the Ethereum Protocol. Finalized proposals agreed up by volunteer client developers, and the users of the Ethereum Classic main net blockchain are implemented by Ethereum Classic client developers.

Every pull request will be reviewed and discussed by volunteer Ethereum Classic client developers and any developers on Github willing to contribute their well reasoned opinions. Regardless if there is general agreement you are able to use the information generated from the discussion to create a a second draft. This can be done by either updating the pull request or submitting a new pull request. This process can be repeated (See figure 1) until the volunteer developer community agrees to add the pull request.

![Figure 1: The cyclic process of proposal and review](./process.png "Figure 1: The process of proposal and review")

Having an ECIP within the folder of the repository does not make it a formally accepted standard until its status becomes Active. For a ECIP to become Active requires the mutual consent of the community. Those proposing changes should consider that ultimately consent may rest with the consensus of the Ethereum users.

ECIPs grew out of the now hard-forked Ethereum DAO hard-fork (or ETF) repository, the are currently no other differences between Ethereum Classic/original main net and and Ethereum DAO hard-forked besides the DAO hard-fork but future changes may be added like early defusal of the difficulty bomb.

# Network split

Pushing changes to the protocol without consensus will cause a network split. The ECIP process should not be skipped, as previously done by Ethereum Foundation developers unilaterally implementing a rushed hard-fork in the most widely used client creating a network split at block 1920000.

The Ethereum Foundation raised money from the community to work towards the "mission to promote and support research, development and education to bring decentralized protocols", and failed when shortly after the DAO exploit was used Vitalik Buterin announced using the Ethereum Foundation blog that a they had already unilaterally decided on forking. A [chat log](http://pastebin.com/raw/aMKwQcHR) from an internal chat reveals this decision was made prior to the announcement, and comments like "default behavior of Geth to be pro-fork as per internal discussions" found in DAO hard-fork [pull requests](https://github.com/ethereum/go-ethereum/pull/2814) and the unwillingness to use their own proposal system show the narrative that the Ethereum Foundation followed the will of the community is clearly wrong. What the Ethereum foundation did the opposite of decentralized decision making. 

Decentralized decision making is part of the defense in depth security that protects the integrity of the Ethereum blockchain. It is critical for keeping the promise of "applications that run exactly as programmed without any possibility of downtime, censorship, fraud or third party interference."

# Getting started contributing
The [ECIP sample](./ECIP-1.sample.md) is the best place to start. The sample was updated for Ethereum use by Martin Becze, it was predominantly derived from the Bitcoin improvement proposal based on the Python improvement proposal system. Fork the repository and add your ECIP to it, using the provided [ECIP markdown template](./ECIP-number.template.md). Submit by creating a Pull Request to the Ethereum Classic [ECIPs repository](https://github.com/ethereumproject/ECIPs).

# Current ECIPs

| Number        | Title        | Author | Type  | Layer        | Status / Discussion |
| ------------- | ------------ | ------ | ----- | -------------| ------------------- |
| [ECIP-1010](ECIPs/ECIP-1010.md) | Delay Difficulty Bomb Explosion | Igor Artamonov | Standard | Consensus (hard-fork) | [Accepted](https://github.com/ethereumproject/ECIPs/issues/4) |
| [ECIP-1013](ECIPs/ECIP-1013.md) | ETC On-Chain Cryptographic Signing and Authentication Protocol | Cody W Burns | Standard | Meta | Draft |
| [ECIP-1017](ECIPs/ECIP-1017.md) | Monetary Policy and Final Modification to the Ethereum Classic Emission Schedule | Matthew Mazur | Standard | Consensus (hard-fork) | Final |

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

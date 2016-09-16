# ECIP
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
The [ECIP sample](./ECIP-0000.md.sample) is the best place to start. The sample was updated for Ethereum use by Martin Becze, it was predominantly derived from the Bitcoin improvement proposal based on the Python improvement proposal system. Fork the repository and add your ECIP to it, using the provided [ECIP markdown template](ECIP-0000.md.template). Submit by creating a Pull Request to the Ethereum Classic [ECIPs repository](https://github.com/ethereumproject/ECIPs).

# Current ECIPs
| Number        |Title         | Author | Type  | Layer        | Status / Discussion |
| ------------- | ------------ | ------ | ----- | -------------| ------------------- |
| [1](ECIPS/EIP-1001.mediawiki)    | Homestead Hard-fork Changes | Vitalik Buterin | Standard | Homestead (hard-fork) | Accepted |
| [2](ECIPS/EIP-1002.mediawiki)    | Addition of CALLDEPTH opcode | Martin Holst Swende | Standard | Consensus (hard-fork) | [Draft](https://github.com/ethereum/EIPs/issues/25) |
| [3](ECIPS/EIP-1003.mediawiki)    | EIP Classification | Joseph Chow | Meta | | Draft |
| [4](ECIPS/EIP-1004.md)    | Gas Usage for `RETURN` and `CALL*` | Christian Reitwiessner | Standard | Consensus (hard-fork) | [Draft](https://github.com/ethereum/EIPs/issues/8) |
| [5](ECIPS/EIP-1005.md)    | Renaming Suicide Variable | Hudson Jameson | Meta |  | [Draft](https://github.com/ethereum/EIPs/pull/42) |
| [6](ECIPS/EIP-1006.md)    | DELEGATECALL | Vitalik Buterin | Standard | homestead (hard-fork) | [Accepted](https://github.com/ethereum/EIPs/issues/23) |
| [7](ECIPS/EIP-1007.md)    | devp2p Forward Compatibility Requirements for Homestead | Felix Lange | Standard | Networking | [Accepted](https://github.com/ethereum/EIPs/pull/49) |
| [8](ECIPS/EIP-1008.md)    | Serenity Currency and Crypto Abstraction | Vitalik Buterin | Standard | Serenity feature | Draft |
| [9](ECIPS/EIP-1009.md)    | Ethereum Domain Name Service - Specification | Nick Johnson | Standard | Informational | Draft |
| [10](ECIPS/ECIP-1010.md)    | Delay Difficulty Bomb Explosion | Igor Artamonov | Standard | Consensus (hard-fork) | [Draft](https://github.com/ethereumproject/ECIPs/issues/4) |
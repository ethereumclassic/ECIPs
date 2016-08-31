# EIP (or ECIP) 
Ethereum (classic) improvement proposal,are proposal that describe changes made to Ethereum Protocol. Finalized proposals agreed up by volunteer client developers, and the users of the Ethereum classic main net blockchain.

People wishing to submit EIPs, start by writing a PreEIP and placing it in the /PreEIPs/ folder in your own branch or fork, then create a pull request. 

Every pull request will be reviewed and discussed by volunteer Ethereum classic client developers and any developers willing to contribute their well reasoned opinions. Regardless if there is general agreement you are able to use the information generated from the discussion to create a final draft. Place your finalized EIP in the /EIPs/ folder in your own branch or fork, submiting it by creating a pull request.

Having an EIP within the folder of the repository does not make it a formally accepted standard until its status becomes Active. For a EIP to become Active requires the mutual consent of the community. Those proposing changes should consider that ultimately consent may rest with the consensus of the Ethereum users.

EIPs (or ECIP) grew out of the now hard-forked Ethereum DAO hard-fork (or ETF) repository, the are currently no other differences between Ethereum classic/original main net and and EThereum DAO hard-forked besides the DAO hard-fork but future changes may be added like early defusal of the difficulty bomb. 

# Contributing
First review [EIP-1](EIPS/eip-1.mediawiki). Then clone the repository and add your EIP to it. There is a [template EIP here](eip-X.mediawiki). Then submit a Pull Request to Ethereum's [EIPs repository](https://github.com/ethereumproject/EIPs).

# Current EIPS
| Number        |Title         | Author | Type  | Layer        | Status / Discussion | 
| ------------- | ------------ | ------ | ----- | -------------| ------------------- |
| [1](EIPS/eip-1.mediawiki)    | EIP Purpose and Guidelines | Martin Becze | Meta | | Active |
| [2](EIPS/eip-2.mediawiki)    | Homestead Hard-fork Changes | Vitalik Buterin | Standard | homestead (hard-fork) | Accepted |
| [3](EIPS/eip-3.mediawiki)    | Addition of CALLDEPTH opcode | Martin Holst Swende | Standard | Consensus (hard-fork) | [Draft](https://github.com/ethereum/EIPs/issues/25) |
| [4](EIPS/eip-4.mediawiki)    | EIP Classification | Joseph Chow | Meta | | Draft |
| [5](EIPS/eip-5.md)    | Gas Usage for `RETURN` and `CALL*` | Christian Reitwiessner | Standard | Consensus (hard-fork) | [Draft](https://github.com/ethereum/EIPs/issues/8) |
| [6](EIPS/eip-6.md)    | Renaming Suicide Variable | Hudson Jameson | Meta |  | [Draft](https://github.com/ethereum/EIPs/pull/42) |
| [7](EIPS/eip-7.md)    | DELEGATECALL | Vitalik Buterin | Standard | homestead (hard-fork) | [Accepted](https://github.com/ethereum/EIPs/issues/23) |
| [8](EIPS/eip-8.md)    | devp2p Forward Compatibility Requirements for Homestead | Felix Lange | Standard | Networking | [Accepted](https://github.com/ethereum/EIPs/pull/49) |

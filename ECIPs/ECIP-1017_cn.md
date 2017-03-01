### Title

    ECIP: 1017
主题:ETC 货币政策和铸币方案最终修改 作者:Matthew Mazur 5n4pr011@gmail.com 翻译:Roy (以太坊原链协会 ECC) QQ:1251433202 状态:起草阶段
类型:标准
创建:2016/11/20
    
<br />

### 摘要

这个 ECIP 提议了一个 ETC 货币政策的解决方案,为最后的调整做准备,目前的出币方案是每 个区块永远固定在 14.0625ETC。此解决方案带来了理论上的总量上限和一个随着时间递减的出币 规律。

<br />

### 原动力

从核心上来说,将现在 ETC 网络的货币政策调整为一个有上限数量的代币和随着时间递减的出 币规律的目的,最重要的出发点是维护网络的安全,让其有自力更生的能力。通过提高网络的安全 性能,一个合适的货币政策将间接地促进网络的发展,提供一个为所有智能合约开发所需的安全平 台。

如果我们承认投机需求是一个新经济系统的主要经济动力,显然 ETC(Ethereum Classic)网络是 一个全新的系统,那么投机需求会驱动 ETC 的价格往前走,直到 ETC 网络真正的实用价值超过它 的投机价值。回应投机需求来帮助培育和提供网络的安全性就是有原因的:

大型、高风险、或者高价值的应用如果脱离了一个安全的网络就很难发展了,譬如我们的算力 很低的话。提高 ETC 币的需求会直接刺激 ETC 币价的上涨。ETC 币价的上涨会激励矿工的积极 性,吸引更多的矿工来挖矿,更多的矿工意味着更高的安全性。一个高安全性的网络有助于在网 络、现有用户和潜在用户、以及开发者之间建立良好的信任关系。这个信任鼓励大型的、高风险的 或者高价值的应用等需求来到这个网络。因此,奖励投机需求有助于培育和提高 ETC 网路的安全 性。

这对加密货币早期 Era 来说特别重要,假设所有的条件都是相同的,一个产量递减和有上限的 币比一个没有产出规律和没有上限的币显而易见地会提供更多的激励给高风险投机者。

综上所述,承认一个货币政策并没有直接为网络创造价值这个观点是很重要的。拥有一些好的 应用和一个活跃的社区等诸多条件的稳定平台才能驱动价值。设计适当的货币政策方案是创造一个 激励机制、促使人们愿意在这个还没有完全发挥自身潜力网络进行高风险投资的目的。为那些还没 有对这个网络产生兴趣或还没有在这个网络进行任何开发或者到目前为止还保持怀疑的这些人来说 一个很好的激励,鼓励让他们加入到一个还处于早期发展 Era 的平台上来。
<br />

### 详细说明

####目前的 ETC 货币政策

[来源](http://ethdocs.org/en/latest/mining.html)

![image alt text](ETC_MP_Perpetual.png)

ETC 网络目前的挖矿奖励模型如下:

* 一个“静态”区块奖励是胜出的区块将会得到 5 ETC 的奖励。

* 一个额外的奖励是胜出的矿工得到包括每叔块 1/32 (0.15625ETC) 的奖励,最高是两 个叔块。

* 在竞争中胜出的矿工得到的区块奖励为 7/8 (4.375ETC),里面包括叔块奖励,最高是 两个叔块。


* 这个奖励设计会被一直执行。

<br />

####建议中的 ETC 货币政策

[来源](https://docs.google.com/spreadsheets/d/1Fs_RNEPSRJxP22PZmwxWjiulVVcu5Ic1GvBXCPCt9to/edit?usp=sharing)

![image alt text](ETC_MP_5M20.png)

*An "Era" is defined as the number of blocks containing a given production rate.*

The proposed mining rewards on the Ethereum Classic Network are as follows:

* Era 1 (blocks 1 - 5,000,000)

    * A "static" block reward for the winning block of 5 ETC

    * An extra reward to the winning miner for including uncles as part of the block, in the form of an extra 1/32 (0.15625ETC) per uncle included, up to a maximum of two (2) uncles. 

    * A reward of up to 7/8 of the winning block reward (4.375ETC) for a miner who has mined an uncled block and has that uncle included in the winning block by the winning miner, up to a maximum of two (2) uncles included in a winning block.

* Era 2 (blocks 5,000,001 - 10,000,000)

    * A "static" block reward for the winning block of 4 ETC

    * An extra reward to the winning miner for including uncles as part of the block, in the form of an extra 1/32 (0.125ETC) per uncle included, up to a maximum of two (2) uncles. 

    * A reward of 1/32 (0.125ETC) of the winning block reward for a miner who has mined an uncled block and has that uncle included in the winning block by the winning miner, up to a maximum of two (2) uncles included in a winning block.

    * Era 2 represents a reduction of 20% of Era 1 values, while also reducing uncle rewards to uncle miners to be the same value as the reward to the winning miner for including the uncle(s).

* Era 3+

    * All rewards will be reduced at a constant rate of 20% upon entering a new Era. 

    * Every Era will last for 5,000,000 blocks. 
    
<br />

### Rationale

Why this 5M20 model:

* Minimizes making the first adjustment too "exceptional." Other than equalizing all uncle rewards at block 5M, the changes/reductions to supply over time are equal. 

* The model is easy to understand. Every 5M blocks, total reward is reduced by 20%.

* Uncle inclusion rates through block 5M will likely remain at around the 5%. Because of this, once block 5M is reached, in the worst case scenario (supply wise, which assumes two uncles included every block in perpetuity) the total supply will not exceed 210.7M ETC. Should the network remain as efficient in its ability to propagate found blocks as it has in Era 1 (5.4% uncle rate), the total supply will not be less than 198.5M ETC. This provides for an incentive to miners and client developers to maintain high standards and maintenance of their hardware and software they introduce into the network.

* The 5M model provides a balance between providing an acceptable depreciating distribution rate for rewarding high risk investment into the system and maintaining an active supply production over time. Maintaining this future supply rate keeps the potential price of the ethereum token suppressed enough to ensure transaction prices can remain lower than if the supply were to reduce to zero at an earlier date. This serves as a "blow off valve" for price increases in the case that a dynamic gas model cannot be implemented for the foreseeable future. 

* Having the monetary policy begin at 5M provides a balance between delaying the implementation to provide enough time for code development and testing, and accelerating the implementation to provide an incentive to potential early adopters and high risk investors. Based on community discussion, beginning before block 4M is too soon for development, testing, and implementation of the policy, and later than block 6M is too long to interest many potential early adopters/investors. 

* Not changing the monetary policy of ETC provides no benefit to risk taking early on in the life of the system, speculation wise. It will be difficult for the network to bootstrap its security. While bitcoin has what is considered to be the generally accepted ideal monetary policy, with its 50% reduction every four years, this model is not likely to yield optimal investment for ETC. If ETC were to adopt the bitcoin halving model, it is arguable that too much of the supply would be produced too soon: 50% of the estimated total ETC supply would be mined 75% sooner than traditional bitcoin because of the pre-mine of 72M ETC that was initially created in the genesis block. While the 5M model does not completely eliminate the effects of the premine, since 50% of total estimated production occurs sooner than would the bitcoin model, it makes up for this, to an extent, with its lengthening of the time until 90%, 99% and 100% of bitcoin are mined. The tail end of ETC production is longer and wider than bitcoin. 

* In the current ETC reward schedule, the total reward for uncles is higher than the reward received by the miner who also includes uncles. In this state, a miner is significantly diluting the value of his reward by including these uncled blocks. By equalizing the rewards to uncle block miners with the rewards to miners who include an uncle block, the reward structure is more fairly distributed. In addition, equalizing the uncle rewards reduces the incentive for miners to set up an ETC "uncle farm," and instead drives them to better secure the network by competing for the latest "real block." 

* Because the rate at which uncled blocks can vary with extreme, reducing the reward for uncle blocks assists considerably with being able to forecast the true upper bound of the total ETC that will ultimately exist in the system. 

* The model is the best attempt at balancing the needs to incentivize high risk investment into the system in order to bootstrap security and create a potential user base, be easy to understand, include a reduction to the rate of production of ETC over time, include an upper bound on supply, provide for a long term production of the ETC token, and allow enough time for development, adoption, and awareness. 

<br />

### Implementation

*Timeline for the implementation and the code required to execute.*


    ECIP: 1035
    Title: Ethereum Classic Privacy Enhanced Stealth Address Schema
    Author: Cody Burns <DontPanic@codywburns.com>
    Status: Draft
    Type: Process
    Created: 2017-09-05
  
### Abstract 

Currently user accounts are represented in a manner that allows for any third party who know a user’s public account number to review all transactions and interactions associated with that account creating a linkable transaction history. While these addresses are good for transactions requiring psudeo-identity( contracts, tokens, etc), it is not ideal for standard user accounts.  The purpose of a stealth addressing scheme is to create one-time addresses which are publicly unlinkable to the owner or any other one-time addresses and allow for only the recipient to link transactions and derive the secret key associated with the address. In short, with a privacy enhanced ethereum classic (ETC-PE) capable node a user can publish one address and receive publicly unlinkable payments as well as make traditional ethereum transactions. This type of cryptographic scheme is described in detail in the cryptonote whitepaper.

### Definitions

`Private Key`(yellowpaper: pr) is a standard elliptic curve private key: a ∈ [1, secp256k1n − 1].

`Public Key` (yellowpaper: pu) is a standard elliptic curve public key: a point pu = prG; 

`one-time keypair` is a pair of private and public keys; 

`private user key` is a pair (a, b) of two different private ec-keys; 

`public user key` is a pair (A, B) of two public ec-keys derived from (a, b); 

`Public Spend Key` is a standard elliptic curve public key: A = aG used to spend transactions

`Public View Key` is a standard elliptic curve public key: B = bG used to view transactions

`Random private key` random nonce where r ∈ [1, secp256k1n − 1];

`Random public key` is a standard elliptic curve public key: a point R = rG;

`tracking key` is a pair (a, B) of private and public ec-key (where B = bG and a 6= b); 

`standard address` is a representation of a public user key given into human friendly string with error correction; 

`truncated address` is a representation of the second half (point B) of a public user key given into human friendly string with error correction. 

`Standard Ethereum address`(yellow paper: A(pr)) rightmost 160-bits of the Keccak hash of the corresponding ECDSA public key  A(pr) = B96..255(KEC(ECDSAPUBKEY(pr))) 

`Contract Address` rightmost 160 bits of the Keccak hash of the RLP encoding of the structure containing only the sender and the nonce. a ≡ B96..255(KEC(RLP((s, σ[s]n − 1)))

`Transaction Extra Data`An unlimited size byte array specifying the input data of the message call, formally Td 



### Stealth Address

![image alt text](ECIP-1035-Stealth.png)

Cryptonote whitepaper Figure 4

#### The Alice and Bob

 Alice wants to send a payment to Bob. 

Alice= Private spend key (Prz)and Private View Key (Pry)

Alice= Public Address (Z,Y)

Bob = Public Address (A,B)

Bob = Private spend key (Pra)and Private View Key (Prb)

Alice and Bob know each others Public Address

#### Send Process
	
  Alice chooses a random private key r  and calculates R = rG. r is no longer needed after this point, however it may be retained to prove Alice sent the transaction to a 3rd party. A new r should be used with every transaction.  R is added to the transactions extradata prefixed with: halt code `0x00`  and a version byte `01` to prevent accidental evm functioning and to allow for rapid lookup. 
	
  `Td=0x0001(R)`

Alice then generates a stealth address `P` 

`P = KEC(rA)G+B`

Where:

`P` is the final stealth address;

`KEC` is the hashing algorithm;

`r` is Alice’s random private key;

`A` is Bobs Public View key

`G` is the standard base point;

`B` is  Bobs Public spend key

#### Receiving Process

Bob's ETC-PE node checks every transaction with his private key (a,b) and computes 

`P’ = KEC(aR)G+B`

Where:

`P’` is an address;

`KEC` is the hashing algorithm;

`a` is Bobs Private View Key

`R` is a transactions extra Data begingin with `0x0001`

`G` is the standard base point;

`B` is  Bobs Public spend key

If Alice’s transaction for with Bob as the recipient was among them:

`aR = arG = rA` and `P’ = P`

Bob can recover the corresponding one-time private key: 

`x = KEC(aR) + b, so as P = xG`

Bob can spend this output at any time by signing a transaction with `x`.

### Rationale

Having both legacy, contract, and stealth account schema allows for additional privacy features to be incorporated into the ethereum classic ecosystem. The stealth account schema by themselves provide the benefit of a unique account per transaction, it is computationally non-trivial for a third party to determine Bobs true holdings.

Additional notes from Cryptonote white paper:

• When Bob “recognizes” his transactions (see step 5) he practically uses only half of his private information: (a, B). This pair, also known as the tracking key, can be passed to a third party (Carol). Bob can delegate her the processing of new transactions. Bob doesn’t need to explicitly trust Carol, because she can’t recover the one-time secret key p without Bob’s full private key (a, b). This approach is useful when Bob lacks bandwidth or computation power (smartphones, hardware wallets etc.). 

• In case Alice wants to prove she sent a transaction to Bob’s address she can either disclose r or use any kind of zero-knowledge protocol to prove she knows r (for example by signing the transaction with r). 

• If Bob wants to have an audit compatible address where all incoming transaction are linkable, he can either publish his tracking key or use a truncated address. That address represent only one public ec-key B, and the remaining part required by the protocol is derived from it as follows: a = Hs(B) and A = Hs(B)G. In both cases every person is able to “recognize” all of Bob’s incoming transaction, but, of course, none can spend the funds enclosed within them without the secret key b. 


### Backwards Compatibility

This ECIP is applicable at the node/client level and has no effect on consensus. It is fully backwards compatible. Any node not upgrade to ETC-PE addressing will view the transactions as normal transactions with extra data. ETC-PE nodes should retain legacy addressing as well for interacting with contracts.  


### Copyright

Copyright and related rights waived via CC0.


### Ref

ETHEREUM: A SECURE DECENTRALISED GENERALISED TRANSACTION LEDGER EIP-150 REVISION, Dr. Gavin Wood, http://yellowpaper.io/
CryptoNote v 2.0, Nicolas van Saberhagen ,https://cryptonote.org/whitepaper.pdf

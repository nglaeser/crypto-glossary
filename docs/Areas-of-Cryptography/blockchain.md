# Blockchain and Cryptocurrencies

!!! tip "Background Reading"
    **Bitcoin whitepaper (2009)**: [A Peer-to-Peer Electronic Cash System](https://bitcoin.org/bitcoin.pdf) by Satoshi Nakamoto  
    **Ethereum whitepaper (2014)**:  [Ethereum: A Next-Generation Smart Contract and Decentralized Application Platform](https://ethereum.org/669c9e2e2027310b6b3cdce6e1c52962/Ethereum_Whitepaper_-_Buterin_2014.pdf) by Vitalik Buterin  

!!! info "The Blockchain Trilemma"
    The Blockchain Trilemma refers to the idea that no blockchain can have all three of the following: security, scalability, and decentralization. Any blockchain is forced to optimize for two features to the detriment of the third. The term was coined by Ethereum founder Vitalik Buterin.

## Layer 1 (Consensus)

!!! summary
    An area of problems about how to get distributed systems to agree on state or some other piece of information. Found new application with the emergence of blockchains.

**State Machine Replication (SMR)** { #smr }
: The problem of ensuring that a group of machines maintains agreement on a collective state even under updates (which may only be sent to some of the machines)

**Byzantine Agreement (BA)** { #ba }
: 
- **Consistency**: All honest parties output the same bit
- **Validity**: If all honest parties input $b$, all honest parties will output $b$
- **Termination**: All honest parties eventually terminate and output some value

### State Representation

There are two main *accounting models* used to represent the state of a blockchain system:

**UTXO**
: Unspent Transaction Output. Every transaction $tx$ consists of input transactions and output transactions; before executing $tx$, the chain (miners) check that the input transactions are *unspent*, i.e., they are as-yet unused output transactions from some previous $tx'$ (they are in the UTXO set). Once $tx$ is processed its inputs are removed from the UTXO set (that is, input UTXOs must be fully consumed by a transaction). That means that there is a directed acyclic graph (DAG) describing how assets (UTXOs) have moved between addresses. This DAG represents the global state. (Account balances are computed locally by adding up an account's UTXOs.)  
Used by: Bitcoin, Litecoin, and Monero.

**Account-based**
: The account model simply maintains a database mapping accounts to balances. This database represents the global state.  
Used by: Ethereum.

!!! tip "Further Reading"
    [The UTXO vs. Account Model](https://www.horizen.io/academy/utxo-vs-account-model/)

### Common Cryptocurrencies

| Cryptocurrency | Main idea                                                                                                                                  | Model   |
| :------------- | :------------------------------------------------------------------------------------------------------------------------------------------ | :------ |
| Bitcoin        | PoW to select miner of next block; resolve forks via longest-chain rule; a transaction is only valid if it spends a UTXO | UTXO    |
| Ethereum       | Initially used PoW, now PoS to select next block proposer; Keeps global state of account balances; Turing-complete programmability via EVM | Account |
| Monero         | Users pick other pk's to include in their transaction whenever they spend coins, use a ring signature to hide which pk actually spent them | UTXO
| Zcash          |                                                                                                                          | UTXO

## Layer 2

!!! summary
    Layer 2 protocols are protocols which rely on an underlying "main" chain and are meant to help with scalability.

**Payment channel (PC)** { #pc }
: 

    ** Payment channel network (PCN)** { #pcn }
    : 

**Sidechain**
: 

**Rollup** { #rollup }
: <!-- TODO --> These are often erroneously called "zk" even though they are not [zero-knowledge](../Areas-of-Cryptography/zk.md#zk).

## Layer 3 (UI)

**Deterministic wallet**
: A deterministic wallet is a cryptocurrency wallet where the keys are [deterministically](../general.md#deterministic) dervied from some seed (e.g., a string of words written on a piece of paper). If the user loses their keys, they can re-derive them from the seed.
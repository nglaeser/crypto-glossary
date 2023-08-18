# Zero-Knowledge (ZK)

!!! summary
    Ways to prove knowledge of a piece of information without revealing that information. More specifically, the goal is usually to prove knowledge of a _witness_ for some _statement_ in a _language_ without revealing the witness.

## Background

First, we define what an NP language is. A **language** is some set of elements that meet a particular property. For instance, the language $L_{HAM}$ is the set of graphs which contain a Hamiltonian cycle. A less mathy example might be the set of words which have double-letters ("hello" is in this language because it contains two back-to-back L's, but "world" is not).

Loosely defined, a language is in [NP](https://en.wikipedia.org/wiki/NP_(complexity)) if it is difficult to decide whether an element belongs to a language, but easy to confirm that it is when provided some evidence (called a **witness**). In the case of $L_{HAM}$, it's difficult to check if a graph contains a Hamiltonian cycle because finding such a cycle is hard. But if you are given a graph and a supposed cycle in the graph, it's easy to check that the graph really does contain that cycle. 

In the case of our less abstract example, think of a computer program that determes whether a word is in the double-letter language: we have to check all the pairs of consecutive letters in the word and see if any of them match. If we are told exactly which two letters repeat and where they are in the word (that is, given the witness `ll, 2` for the word "hello"), we can quickly jump to the letter at index `2` in the word and only check that the next two letters both equal `l`. (This is not a perfect example, since cycling through the entire length of the word doesn't take all that much time, but the point is that the witness simplifies the verification process.)

## ZK 

Zero-knowledge (ZK) protocols occur between two parties: a **prover** and a **verifier**. The prover's goal is to convince the verifier that some statement $x$ is in some language $L$, by convincing the verifier that it knows some witness $w$ for that statement. The verifier's goal is to be sure the prover knows such a witness.

ZK protocols are only interesting if the prover doesn't want to reveal its witness (the [zero-knowledge](#zk) property). (If we didn't care about revealing the witness, the prover could simply send the witness to verifier and we'd be done.)
<!-- Not true, we might also just want efficient verification -->

!!! example "Example: _Where's Waldo?_ in zero-knowledge"

    <!-- Where's Waldo example -->

## Properties

**Completeness** { #completeness }
: For honest prover P and verifier V, the protocol will accept only on "correct" (true) statements (except with [negligible](../general.md#negligible) probability).

**Honest-verifier zero-knowledge (HVZK)** { #hvzk }
: 

**Non-interactive** { #non-int }
: No interaction is required; that is, a proof consists of a single message sent by the prover to the verifier (1 round).

**Soundness** { #soundness }
: Intuitively, a cheating ([malicious](../general.md#malicious)) prover P\* cannot (except with [negligible](../general.md#negligible) probability) provide a valid proof of a false statement. 

- **Knowledge Soundness** { #knowledge-soundness}
: This property is stronger than [soundness](#soundness). Intuitively, it says that any valid proof has a corresponding witness. Formally, for any valid proof, there exists an _extractor_ which can extract the witness when given the proof. What does this actually mean? It says that if a prover provides a valid proof, _it must have known the witness_. In other words, a cheating prover cannot provide a proof of even a _true_ statement if it does not know the witness.

- **Special Soundness** { #special-soundness }
: This lies between [soundness](#soundness) and [knowledge soundness](#knowledge-soundness) (?) and applies only to interactive proof systems. Given two (or $s$, in the case of **$s$-special soundness**) valid transcripts for the same statement and with the same first message, there exists an efficient extractor which can recover the witness corresponding to the statement.  
The "special" part means that this property implies soundness.

- **Simulation Soundness**  { #simulation-soundness }
: This property requires that [soundness](#soundness) holds even when P\* has seen many simulated proofs (potentially even for false statements), i.e. P\* is additionally given an arbitrary number of statement-proof pairs $(x,\pi)$ such that $V(x,\pi)=1$.

- **Simulation Extractability** { #simulation-extractability }
: aka **simulation-knowledge soundness**. A combination of [knowledge soundness](#knowledge-soundness) and [simulation soundness](#simulation-soundness), this notion says that [knowledge soundness](#knowledge-soundness) holds even when given access to arbitrarily many simulated proofs. This notion was formulated to capture the notion of non-malleability (which it implies), since [knowledge soundness](#knowledge-soundness) on its own says nothing about the capabilities of a prover that has seen a valid proof to produce a new valid proof by "mauling" the honest proof (malleability). A good discussion can be found in the introduction of [[2019/641]](https://eprint.iacr.org/2019/641.pdf).

**Succinct** { #succinct }
: 
1. the proof size is "small"
1. verification is "fast"

    There is some disagreement on exactly how to define "small" and "fast" in the above: constant, polynomial in the security parameter, polylogarithmic in the statement size, sublinear in the witness? <!-- Can link to Justin's post on misconceptions (#2) once it's out https://a16zcrypto.com/posts/article/17-misconceptions-about-snarks/ -->

    What exactly is meant by "small" and "fast" often depends on the author.  
    "Small" commonly means polynomial in the security parameter ($\lvert \pi \rvert \in \mathrm{poly}(\lambda)$) or polylogarithmic in the statement size ($\lvert \pi \rvert \in \mathrm{polylog}(\lvert x \rvert)$).  
    "Fast" could mean polylogarithmic in the security parameter and statement size ($V(x,\pi) \in O(\mathrm{polylog}(\lambda + \lvert x \rvert)$). <!-- link to Justin's misconception blog post once it's done -->

**Witness indistinguishable (WI)** { #wi }
: Given a proof, the (malicious?) verifier cannot distinguish between which of two valid witnesses was used to generate the proof with more than negligible probability.

**Zero-knowledge (ZK)** { #zk }
: (With overwhelming probability,) a [malicious](../general.md#malicious) verifier V\* learns nothing about the prover's witness. Formally, there exists a [simulator](../proofs.md#proof-by-simulation) which, given access only to the statement $x$, can generate a view for V\* that is [indistinguishable](../general.md#indist) from its view in the real execution. This property comes in [computational](../general.md#computational) and [information-theoretic](../general.md#it-security) variants (depending on the type of indistinguishability of the two transcripts).

<!-- - **Black-box ZK**
: The above holds even when the simulator is given _only oracle (aka, black-box) access_ to V\*. -->

## Proofs and Arguments

By definition, proof systems are [complete](#completeness) and [sound](#soundness). Based on the strength of the soundness, we make a distinction betweeen "arguments" and "proofs":

**Argument** { #argument }
: [Completeness](#completeness) holds [perfectly](../general.md#perfect-security). [Soundness](#soundness) holds only against a [computationally _bounded_](../general.md#computational) cheating prover (i.e., computational soundness). For this reason, arguments are sometimes referred to as "computationally sound proofs".

**Proof** { #proof }
: [Completeness](#completeness) holds [perfectly](../general.md#perfect-security). [Soundness](#soundness) holds against a computationally _unbounded_ cheating prover (i.e., [statistical](../general.md#statistical) or even [perfect](../general.md#perfect-security) soundness).

## Types of zero-knowledge proofs

Zero-knowledge proofs are named in a fairly self-explanatory way by combining their properties into an acronym. 
<!-- Rememeber from above that all proof systems are by definition complete and sound, so the "proof" part of the name implies completeness and soundness. Common ZK proofs: -->

**Argument of Knowledge (AoK)** { #aok }
: [Argument](#argument) where the (computational) [soundness](#soundness) is [_knowledge_ soundness](#knowledge-soundness).  
*Properties*: [completeness](#completeness), computational [knowledge soundness](#knowledge-soundness).

**Proof of Knowledge (PoK)** { #pok }
: [Proof](#proof) where the [soundness](#soundness) is [_knowledge_ soundness](#knowledge-soundness).  
*Properties:* [completeness](#completeness), [knowledge soundness](#knowledge-soundness).

**Probabilistically Checkable Proof (PCP)** { #pcp }
: 

**Interactive Oracle Proof (IOP)** { #iop }
: Sometimes referred to as **probabilistically checkable interactive proofs (PCIP)**, this is an interactive variant of PCPs.

**NIWI** { niwi }
: [Non-Interactive](#non-int) [Witness Indistinguishable](#wi) [proof](#proof).  
*Properties:* [non-interactivity](#non-int) ("NI"), [witness indistinguishability](#wi) ("WI"), [completeness](#completeness) and [soundness](#soundness) ("proof").

**NIZK** { #nizk }
: [Non-Interactive](#non-int) [Zero Knowledge](#zk) [proof](#proof).  
*Properties:* [non-interactivity](#non-int) ("NI"), [zero-knowledge](#zk) ("ZK"), [completeness](#completeness) and [soundness](#soundness) ("proof").
<!-- TODO Make properties into a table -->
<!-- Maybe list for each type what assumptions they are known from? -->
<!-- - Not known from CDH  -->

**SNARG**/**SNArg** { #snarg }
: [Succinct](#succinct) [Non-interactive](#non-int) [Argument](#argument).  
*Properties:* [succinctness](#succinct) ("S"), [non-interactivity](#non-int) ("N"), [completeness](#completeness) and computational [soundness](#soundness) ("Arg").

**SNARK**/**SNArK** { #snark }
: [Succinct](#succinct) [Non-interactive](#non-int) [Argument](#argument) of Knowledge.  
*Properties:* [succinctness](#succinct) ("S"), [non-interactivity](#non-int) ("N"), [completeness](#completeness) and [_knowledge_ soundness](#knowledge-soundness) ("ArK").

    **zk-SNARK** { #zk-snark }
    : [zero-knowledge](#zk) SNARK.  
    *Properties:* the above _plus_ [zero-knowledge](#zk) ("zk").

<!-- **SNIP**
: [Secret-shared](./mpc.md#building-blocks) Non-Interactive Proof (introduced in [Prio](https://www.usenix.org/system/files/conference/nsdi17/nsdi17-corrigan-gibbs.pdf)). -->

**STARK**/**STArK**
: Scalable Transparent [Argument](#argument) of Knowledge.  
*Properties:* Fast verifier _and prover_ time ("S"), transparent/no trusted setup ("T"), [completeness](#completeness) and [_knowledge_ soundness](#knowledge-soundness) ("ArK").

**DV-NIZK**
: Designated Verifier [NIZK](#nizk). 

<!-- **Signature of Knowledge**
: A generalization of digital signatures. Instead of only proving that the signer has knowledge of a secret key corresponding to a public key, signatures of knowledge can be used to prove the signer knows a witness to some statement $x$. Thus the signature is done with respect to some NP statement.
[Introduced by [CL06](https://eprint.iacr.org/2006/184.pdf)] -->

<!-- Insert table? -->

### Sigma protocols

<!-- useful slides: http://cyber.biu.ac.il/wp-content/uploads/2018/08/WS-19-11-sigma-protocols-winter-school-2019-1.pdf -->

A sigma protocol (&Sigma;-protocol) is a 3-round interactive [HVZK](#hvzk) [PoK](#pok). Put another way, a sigma-protocol has the following properties:  

- [perfect](../general.md#perfect-security) [completeness](#completeness)
- [special soundness](#special-soundness) (here, this implies [knowledge soundness](#knowledge-soundness), so the protocol is a [PoK](#pok))
- [honest verifier zero-knowledge](#hvzk) (HVZK)

Any sigma protocol proving that $(x, w)$ is in some relation $R$ follows the same outline:

1. Prover P sends a first message $a$ (the *commitment*)
1. Verifier V responds with a uniformly random *challenge* $c$
1. P uses the challenge to generate a *response* $z$

Lastly, V must output either "accept" or "reject" as a [deterministic](../general.md#deterministic) function of $x$ and the transcript $(a, c, z)$.

Sigma protocols can be made non-interactive via the [Fiat-Shamir transform](../techniques.md). They can also be composed in the following ways, so that the languages they operate over are composed:

**OR composition**
: 

**AND composition**
: 

!!! tip "Further Reading"
    ["On &Sigma;-protocols"](https://cs.au.dk/~ivan/Sigma.pdf) by Ivan Damg&aring;rd  
    ["Sigma Protocols" slides](http://cyber.biu.ac.il/wp-content/uploads/2018/08/WS-19-11-sigma-protocols-winter-school-2019-1.pdf) by Benny Pinkas

!!! example "Sigma protocol: DLog [Schnorr'89]"

    === "Scheme"
        To prove knowledge of the discrete logarithm x of y with respect to b (i.e., knowledge of $x$ such that $y = b^x$), 

        1. The prover P chooses a uniform value $r$ and sends $a := b^r$ to the verifier V
        1. V sends back a uniform challenge $ch$
        1. P sends $z := r + ch \cdot x$
        1. V check that $b^z = a \cdot y^{ch}$

        Correctness holds since $a \cdot y^{ch} = (b^r) \cdot (b^x)^{ch} = b^{r + x \cdot ch}$.

    === "Properties"
        - HVZK
        - PoK
        - [Cramer'97] generalizes this to knowledge of a homomorphism preimage

!!! example "Sigma protocol: DDH"

    === "Scheme"

    === "Properties"

!!! example "Sigma protocol: DLEq [Chaum-Pedersen'92]"

    === "Scheme"

    === "Properties"

!!! example "Sigma protocol: Pedersen opening"

    === "Scheme"
<!-- https://crypto.stackexchange.com/questions/81236/question-of-proving-the-opening-of-pedersen-commitment#81260 -->

    === "Properties"


## Example Protocols

!!! example "3-coloring [GMW]"
    === "Scheme"
    === "Properties"

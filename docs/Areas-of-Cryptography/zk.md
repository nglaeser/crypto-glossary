# Zero-Knowledge (ZK)

!!! summary
    Ways to prove knowledge of a piece of information without revealing that information. More specifically, the goal is usually to prove knowledge of a _witness_ for some _statement_ in a _language_ without revealing the witness.

## Background

First, we define what an NP language is. A _language_ is some set of elements that meet a particular property. For instance, the language $L_{HAM}$ is the set of graphs which contain a Hamiltonian cycle. A less mathy example might be the set of words which have double-letters ("hello" is in this language because it contains two back-to-back L's, but "world" is not).

Loosely defined, a language is in _[NP](https://en.wikipedia.org/wiki/NP_(complexity))_ if it is difficult to decide whether an element belongs to a language, but easy to confirm that it is when provided some evidence (called a _witness_). In the case of $L_{HAM}$, it's difficult to check if a graph contains a Hamiltonian cycle because finding such a cycle is hard. But if you are given a graph and a supposed cycle in the graph, it's easy to check that the graph really does contain that cycle. 

In the case of our less abstract example, think of a computer program that determes whether a word is in the double-letter language: we have to check all the pairs of consecutive letters in the word and see if any of them match. If we are told exactly which two letters repeat and where they are in the word (that is, given the witness `ll, 2` for the word "hello"), we can quickly jump to the letter at index `2` in the word and only check that the next two letters both equal `l`. (This is not a perfect example, since cycling through the entire length of the word doesn't take all that much time, but the point is that the witness simplifies the verification process.)

## ZK 

Zero-knowledge (ZK) protocols occur between two parties: a _prover_ and a _verifier_. The prover's goal is to convince the verifier that some statement _x_ is in some language _L_, by convincing the verifier that it knows some witness _w_ for that statement. The verifier's goal is to be sure the prover knows such a witness.

ZK protocols are only interesting if the prover doesn't want to reveal its witness (the _zero-knowledge_ property). (If we didn't care about revealing the witness, the prover could simply send the witness to verifier and we'd be done.)

!!! example "Example: _Where's Waldo?_ in zero-knowledge"

    <!-- Where's Waldo example -->

## Properties

**Completeness**
: For honest prover P and verifier V, the protocol will accept only on "correct" (true) statements (except with negligible probability).

**Honest-verifier zero-knowledge (HVZK)**
: 

**Non-interactive**
: No interaction is required; that is, a proof consists of a single message sent by the prover to the verifier (1 round).

**Soundness**
: Intuitively, a cheating (malicious) prover P\* cannot (except with negligible probability) provide a valid proof of a false statement. 

- **Knowledge Soundness**
: This property is stronger than _soundness_. Intuitively, it says that any valid proof has a corresponding witness. Formally, for any valid proof, there exists an extractor which can extract the witness when given the proof. What does this actually mean? It says that if a prover provides a valid proof, _it must have known the witness_. In other words, a cheating prover cannot provide a proof of even a _true_ statement if it does not know the witness.

- **Special Soundness**
: This lies between soundness and knowledge soundness (?) and applies only to interactive proof systems. Given two (or $s$, in the case of _$s$-special soundness_) valid transcripts for the same statement and with the same first message, there exists an efficient extractor which can recover the witness corresponding to the statement. The "special" part means that this property implies soundness.

- **Simulation Soundness** 
: This property requires that _soundness_ holds even when P\* has seen many simulated proofs (potentially even for false statements), i.e. P\* is additionally given an arbitrary number of statement-proof pairs $(x,\pi)$ such that $V(x,\pi)=1$.

- **Simulation Extractability**
: aka **simulation-knowledge soundness**. An even stronger version of _knowledge soundness_ or (respectively) of _simulation soundness_, this notion says that _knowledge soundness_ holds even when given access to arbitrarily many simulated proofs. This notion was formulated to capture the notion of non-malleability (which it implies), since _knowledge soundness_ on its own says nothing about the capabilities of a prover that has seen a valid proof to produce a new valid proof by "mauling" the honest proof (malleability). A good discussion can be found in the introduction of [[2019/641]](https://eprint.iacr.org/2019/641.pdf).

**Succinct**
: 
1. the size of the proof is "small" (e.g., polynomial in the security parameter: $\lvert \pi \rvert \in \mathrm{poly}(\lambda)$, or polylogarithmic in the statement size: $\lvert \pi \rvert \in \mathrm{polylog}(\lvert x \rvert)$), and 
1. verification is "fast", (e.g. $V(x,\pi) \in O(\mathrm{polylog}(\lambda + \lvert x \rvert))$).

**Witness indistinguishable (WI)**
: Given a proof, the (malicious?) verifier cannot distinguish between which of two valid witnesses was used to generate the proof with more than negligible probability.

**Zero-knowledge (ZK)**
: (With overwhelming probability,) a malicious verifier V\* learns nothing about the prover's witness. Formally, there exists a simulator which given access only to the statement $x$ can generate a view for V\* that is indistinguishable from its view in the real execution. This property comes in computational and information-theoretic variants (depending on the type of indistinguishability of the two transcripts).

- **Black-box ZK**
: The above holds even when the simulator is given _only oracle (aka, black-box) access_ to V\*.

## Proofs and Arguments

By definition, proof systems are complete and sound. Based on the strength of the soundness, we make a distinction betweeen "arguments" and "proofs":

**Argument**
: Completeness holds perfectly. Soundness holds only against a computationally _bounded_ cheating prover (i.e., computational soundness). For this reason, arguments are sometimes referred to as "computationally sound proofs".

**Proof**
: Completeness holds perfectly. Soundness holds against a computationally _unbounded_ cheating prover (i.e., statistical or even perfect soundness).

## Types of zero-knowledge proofs

Zero-knowledge proofs are named in a fairly self-explanatory way by combining their properties into an acronym. Rememeber from above that all proof systems are by definition complete and sound, so the "proof" part of the name implies completeness and soundness. Common ZK proofs:

**Argument of Knowledge (AoK)**
: Argument where the (computational) soundness is _knowledge_ soundness.  
*Properties*: completeness, (computational) knowledge soundness.

**Proof of Knowledge (PoK)**
: Proof where the soundness is _knowledge_ soundness.  
*Properties:* completeness, knowledge soundness.

**NIWI**
: Non-Interactive Witness Indistinguishable proof.  
*Properties:* non-interactivity ("NI"), witness indistinguishability ("WI"), completeness and soundness ("proof").

**NIZK**
: Non-Interactive Zero Knowledge proof.  
*Properties:* non-interactivity ("NI"), zero-knowledge ("ZK"), completeness and soundness ("proof").
<!-- TODO Make properties into a table -->
<!-- Maybe list for each type what assumptions they are known from? -->
<!-- - Not known from CDH  -->

**SNARG**/**SNArg**
: Succinct Non-interactive Argument.  
*Properties:* succinctness ("S"), non-interactivity ("N"), completeness and (computational) soundness ("Arg").

**SNARK**/**SNArK**
: Succinct Non-interactive Argument of Knowledge.  
*Properties:* succinctness ("S"), non-interactivity ("N"), completeness and _knowledge_ soundness ("ArK").

- **zk-SNARK**
    : zero-knowledge SNARK.  
    *Properties:* the above _plus_ zero-knowledge ("zk").

**SNIP**
: [Secret-shared](./mpc.md#building-blocks) Non-Interactive Proof (introduced in [Prio](https://www.usenix.org/system/files/conference/nsdi17/nsdi17-corrigan-gibbs.pdf)).

**STARK**/**STArK**
: Scalable Transparent Argument of Knowledge.
*Properties:* Fast verifier _and prover_ time ("S"), transparent/no trusted setup ("T"), completeness and _knowledge_ soundness ("ArK").

**DV-NIZK**
: Designated Verifier NIZK; can only be verified by a particular party. This is also referred to as the *private-coin* setting, since the coins (randomness) needed to verify the NIZK are known only to the designated verifier and are thus private.  
A [_MAC_](../Cryptographic-Primitives/other.md) can be thought of as a DV-NIZK for a key (witness) corresponding to a message-signature pair (statement), where the verifier is the party holding the MAC key. This is zero-knowledge since no other party learns the witness from the MAC.

**Signature of Knowledge**
: A generalization of digital signatures. Instead of only proving that the signer has knowledge of a secret key corresponding to a public key, signatures of knowledge can be used to prove the signer knows a witness to some statement $x$. Thus the signature is done with respect to some NP statement.
[Introduced by [CL06](https://eprint.iacr.org/2006/184.pdf)]

<!-- Insert table? -->

### Sigma protocols

<!-- useful slides: http://cyber.biu.ac.il/wp-content/uploads/2018/08/WS-19-11-sigma-protocols-winter-school-2019-1.pdf -->

A sigma protocol (&Sigma;-protocol) is a 3-round interactive HVZK PoK. Put another way, a sigma-protocol has the following properties:
- perfect completeness
- special soundness (here, this implies knowledge soundness, so the protocol is a PoK)
- honest verifier zero-knowledge (HVZK)

Any sigma protocol proving that $(x, w)$ is in some relation $R$ follows this outline:

1. Prover P sends a first message $a$ (the *commitment*)
1. Verifier V responds with a uniformly random *challenge* $c$
1. P uses the challenge to generate a *response* $z$

Lastly, V must output either "accept" or "reject" as a deterministic function of $x$ and the transcript $(a, c, z)$.

Sigma protocols can be made non-interactive via the [Fiat-Shamir transform](../techniques.md). They can also be composed in the following ways, so that the languages they operate over are composed:

**OR composition**
: 

**AND composition**
: 

!!! tip "Further Reading"
    ["On &Sigma;-protocols"](https://cs.au.dk/~ivan/Sigma.pdf) by Ivan Damg&aring;rd  
    ["Sigma Protocols" slides](http://cyber.biu.ac.il/wp-content/uploads/2018/08/WS-19-11-sigma-protocols-winter-school-2019-1.pdf) by Benny Pinkas

!!! example "Sigma protocol: DLog [Schnorr]"

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

!!! example "Sigma protocol: DDH"

    === "Scheme"

    === "Properties"

## Example Protocols

!!! example "3-coloring [GMW]"
    === "Scheme"
    === "Properties"

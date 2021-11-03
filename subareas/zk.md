[← Back to Glossary](../glossary.md)

# Zero-Knowledge

## Background

First, we define what an NP language is. A _language_ is some set of elements that meet a particular property. For instance, the language <img alt="L_{HAM}" src="https://render.githubusercontent.com/render/math?math=L_%7BHAM%7D" style="transform: translateY(20%);" /> is the set of graphs which contain a Hamiltonian cycle. A less mathy example might be the set of words which have double-letters ("hello" is in this language because it contains two back-to-back L's, but "world" is not).

Loosely defined, a language is in _[NP](https://en.wikipedia.org/wiki/NP_(complexity))_ if it is difficult to decide whether an element belongs to a language, but easy to confirm that it is when provided some evidence (called a _witness_). In the case of <img alt="L_{HAM}" src="https://render.githubusercontent.com/render/math?math=L_%7BHAM%7D" style="transform: translateY(20%);" />, it's difficult to check if a graph contains a Hamiltonian cycle because finding such a cycle is hard. But if you are given a graph and a supposed cycle in the graph, it's easy to check that the graph really does contain that cycle.

In the case of our less abstract example, think of a computer program that determes whether a word is in the double-letter language: we have to check all the pairs of consecutive letters in the word and see if any of them match. If we are told exactly which two letters repeat and where they are in the word (that is, given the witness `ll, 2` for the word "hello"), we can quickly jump to the letter at index `2` in the word and only check that the next two letters both equal `l`. (This is not a perfect example, since cycling through the entire length of the word doesn't take all that much time, but the point is that the witness simplifies the verification process.)

## ZK

Zero-knowledge (ZK) protocols occur between two parties: a _prover_ and a _verifier_. The prover's goal is to convince the verifier that some statement _x_ is in some language _L_, by convincing the verifier that it knows some witness _w_ for that statement. The verifier's goal is to be sure the prover knows such a witness.

ZK protocols are only interesting if the prover doesn't want to reveal its witness. (If we didn't care about revealing the witness, the prover could simply send the witness to verifier and we'd be done.)

## Properties

**Argument of knowledge (AoK)**:

**Honest-verifier zero-knowledge (HVZK)**:

**Non-interactive**:

**Proof of knowledge (PoK)**: Secure against a dishonest prover.

**Soundness**: (knowledge soundness?)

**Simulation Soundness**: (simulation extractability?)

**Succinct**:

**Witness indistinguishable (WI)**:

**Zero-knowledge (ZK)**: Secure against a dishonest verifier.

## Types

Zero-knowledge proofs are named in a fairly self-explanatory way by combining their properties into an acronym. Common ZK proofs:

**Sigma protocol (Σ-protocol)**: Interactive honest-verifier zero-knowledge (HVZK) proof system.

**NIWI**: Non-Interactive Witness Indistinguishable proof.

**NIZK**: Non-Interactive Zero Knowledge proof.
* Not known from CDH
* <!-- Maybe list for each type what assumptions they are known from? -->
* <br/>
**SNARG**: Succinct Non-interactive Argument (a more accurate acronym would be SNArg).

**SNARK**: Succinct Non-interactive Argument of Knowledge (a more accurate acronym would be SNArK).

**SNIP**: [Secret-shared](./mpc.md#building-blocks) Non-Interactive Proof (introduced in [Prio](https://www.usenix.org/system/files/conference/nsdi17/nsdi17-corrigan-gibbs.pdf)).

**STARK**:

**DV-NIZK**: Designated Verifier NIZK; can only be verified by a particular party. A _MAC_ can be thought of as a DV-NIZK for a key (witness) corresponding to a message-signature pair (statement), where the verifier is the party holding the MAC key. This is zero-knowledge since no other party learns the witness from the MAC.

**Signature of Knowledge**: A generalization of digital signatures. Instead of only proving that the signer has knowledge of a secret key corresponding to a public key, signatures of knowledge can be used to prove the signer knows a witness to some statement x. Thus the signature is done with respect to some NP statement.
[Introduced by [CL06](https://eprint.iacr.org/2006/184.pdf)]

<!-- Insert table? -->

## Example Protocols

**GMW ZK proof**:


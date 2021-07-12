# Glossary

[General](#general) | [Primitives](#cryptographic-primitives) | [Areas of Crypto](#areas-of-cryptography) | [Threat Models](#threat-models) | [Phrases](#phrases) | [Models](#models)

## General
**Advantage**: The probability of an _adversary_ violating the security property of a scheme. The advantage is generally defined with respect to a _security game_. For secure constructions, the adversary's advantage usually shown to be small by showing it is bounded by a _negligible function_.

**Adversary**: Some dishonest entity that will try to break a primitive or protocol. See [Threat Models](#threat-models) for the types of adversaries, each with different capabilities.

**Big-O notation**: Written O(n), this is an upper bound on the computational complexity of an algorithm/protocol/etc. when n is large enough.

**Big-omega notation**: Written &Omega;(n), this is a lower bound on the computational complexity of an algorithm/protocol/etc. when n is large enough.

**Big-theta notation**: Written &Theta;(n), this is an approximation of the computational complexity of an algorithm/protocol/etc. when n is large enough. A function _f(n)_ is Big-Theta of n (written as _f(n) &isin; &Theta;(n)_) iff _f(n) &isin; O(n)_ and _f(n) &isin; &Omega;(n)_.

<!-- TODO: drawing of O/Omega/Theta and f(n) --->

**Concurrent composition**: Two protocols running concurrently are run with their messages arbitrarily interleaved. In the two-party case:

![The messages of the blue and green protocols are arbitrarily interleaved](./img/concurr-comp.png)

In general, concurrent composition of secure protocols does not maintain security (against malicious adversaries). A special case of concurrent composition is _parallel composition_. Compare to _sequential composition_.

**Correctness**: A property of a scheme that ensures it works correctly and does not trivially meet the definition of the scheme. For example, we usually require that decryption and encryption are inverses, or that sharing and reconstruction are inverses.

**Deterministic**: A function that always proceeds in the same way when run on the same outputs. Alternatively, the inputs directly determine the output. Compare to _randomized_.

**Field**: A set of elements _F_ with two binary operations + and • (addition and multiplication) that satisfy particular properties called the [field axioms](https://en.wikipedia.org/wiki/Field_(mathematics)#Classic_definition) (specifically associativity, commutativity, identity, and invertibility of both operations along with distributivity of multiplication over addition). Both the rational numbers and the real numbers are fields.

**Functionality** vs. **function**:

**Group**: A set of elements _G_ with some binary operation • (the group operation) that satisfies particular properties called the [group axioms](https://en.wikipedia.org/wiki/Group_(mathematics)#Definition) (specifically associativity, identity, and invertibility). The integers form a group under addition.

**Hardness assumption**: A problem, such as factoring, which is assumed to be hard. A cryptographic scheme's security may hinge on the adversary not being able to solve this problem, and if the assumption turns out not to hold, the proof of security is invalidated.

**Hybrid composition**: 
- **Composition Theorem.** If &rho;_1_, ..., &rho;_m_ are secure protocols for computing the functionalities _f1_, ..., _fm_, and if &Pi; is a secure protocol for computing _f_ in the (_f1_, ..., _fm_)-hybrid world, then the composed protocol &Pi;^&rho;_1_, ..., &rho;_m_ is a secure protocol for _f_.
That is, if we have a protocol that can secure compute some function _f_ given it has access to some other functionality/ies, and we have protocols for securely computing those functionality/ies, we can "plug in" those protocols into our main protocol and it will be secure.

**i.i.d.**: Independent and identically distributed. Two random variables are i.i.d. if they have the same probability distribution and are independent of each other.

**Negligible function**: A function that asymptotically (i.e. after some fixed point) decreases faster than any inverse polynomial:

![The function f is upper bounded by n^{-1} and n^{-2} (and presumably all inverse polynomials) for large enough inputs.](./img/negligible.png)

<details>
<summary>Formal Definition</summary>
A function <emph>f</emph> is negligible if for all natural numbers <emph>c</emph>, there exists a natural number <emph>N</emph> such that <emph>f(n) < n^{-c}</emph> for all <emph>n > N</emph>.
</details>

**Parallel composition**: Two protocols running in parallel run in "lockstep", i.e. the first round messages of both are sent together, followed by the second, and so on. In the two-party case:

![The messages in each round of the blue and green protocols are sent together](./img/parallel-comp.png)

In general, composing secure protocols in parallel does not maintain security (against malicious adversaries). Parallel composition is a special case of _concurrent composition_. Compare to _sequential composition_.

**Protocol**: A sequence of messages exchanged between parties to compute some functionality. A protocol specifies how parties should compute their messages based on their knowledge and the other parties' responses. Usually denoted by the variable &Pi;.

**Randomized**: A function whose output is influenced by some additional source of randomness. Running the function twice on the same inputs may result in a different outcome. Compare to _deterministic_.

**Security game**:

**Sequential composition**: Two protocols are composed sequentially when they are run back-to-back, i.e. one protocol only begins after the other has concluded. In the two-party case:

![The messages in each round of the blue and green protocols are sent together](./img/seq-comp.png)

Sequential composition of two secure protocols is still secure. Compare to _concurrent composition_, _parallel composition_.

**Uniform**: A distribution is uniform, or a value uniformly distributed, if every outcome is equally likely. We may say that a value is "drawn uniformly at random". A uniform distribution over _N_ elements means each of the elements is drawn with probability 1/_N_.

**Without loss of generality**: 

## Cryptographic Primitives

Basic building blocks for cryptographic protocols.

**Pseudo-random function (PRF)**: A function that maps inputs to outputs so that the outputs appear randomly distributed. The function is deterministic in the sense that querying it on the same input always returns the same (random-looking) output.

**Pseudo-random permutation (PRP)**:

### Encryption Schemes

**Asymmetric (public-key) encryption**:

**Symmetric (secret-key) encryption**:

### Signatures

**Schnorr signatures**:

**ECDSA signatures**:

## Areas of Cryptography
**Consensus**:

**Lattice-based cryptography**: Cryptography based on lattice hardness assumptions.

**Multi-party computation (MPC)**: Functionality in which two or more parties with secret inputs compute a joint function on those inputs. No party learns any more information about the others' inputs, except what it can infer from the output. [More about MPC &rarr;](./mpc.md)

**Post-quantum cryptography (PQC)**: Cryptographic primitives that are secure against adversaries with quantum capabilities. _Lattice-based cryptography_ is one area of PQC.

**Private set intersetion (PSI)**:

**Program Obfuscation**: hide the inner workings (and secrets) of a program cryptographically while preserving functionality. The strongest notion of security here is virtual-black-box (VBB) security, which means that the obfuscated program acts as a black box.

**Quantum Cryptography**:

**Zero-knowledge proofs**: Ways to prove knowledge of a piece of information without revealing that information. More specifically, the goal is usually to prove knowledge of a _witness_ for some _statement_ in a _language_ without revealing the witness. [More about zero-knowledge &rarr;](./zk.md)

### Cryptographic Schemes
These are active lines of research creating particular schemes or primitives that are not quite large enough to be their own area but new enough not to fall under the "classic" crypto primitives [above](#cryptographic-primitives).

**Attribute-based encryption (ABE)**: Policy-based access to encrypted data (general case of identity-based encryption (IBE)). The policy is public. A trusted third-party distributes keys to parties that meet the policy.

**Functional encryption (FE)**: An encryption scheme in which it is possible to issue "function keys", e.g. a key _k_f_ that decrypts the ciphertext into a function _f(m)_ of the plaintext _m_.

**Identity-based encryption (IBE)**:

**Time-Lock Puzzle**:

**One-time Pad**:

## Threat Models
**Active adversary**: See _malicious adversary_.

**Honest-but-curious (HbC)**: See _semi-honest adversary_.

**Malicious adversary**: 
An adversary that can deviate arbitrarily from the protocol it is participating in. That is, it doesn't follow the rules and may send malformed, empty, or incorrect messages, not send a message when it is supposed to or vice versa, and otherwise behave maliciously. Also known as _active_; compare to _semi-honest adversary_.

We sometimes use * as a superscript to denote that a party may be malicious, i.e. cheat and deviate from the protocol. For instance, the party S* in a commitment scheme denotes a potentially malicious sender.

**Passive adversary**: See _semi-honest adversary_.

**Semi-honest adversary**: An adversary that follows the protocol and acts honestly, but tries to learn as much as possible from the information it sees. Also known as _honest-but-curious (HbC)_ or _passive_.

## Security Notions

**Adaptive security** (adaptive security):

**Computational security**:

**Information-theoretic security**: ... See also _unconditional security_.

**Perfect security**:

**Semantic security**:

**Statistical security**: Another term for _information-theoretic security_.

**Unconditional security**: Usually used interchangeably with _information-theoretic security_. However, it can also be used to mean security that is not based on any computational assumption.

## Phrases
**Secure in the __ model**:

**In the __-hybrid model**:

**Black-box**:

## Models
**Generic Group Model (GGM)**:

**Random Oracle Model (ROM)**:

**Standard Model**:
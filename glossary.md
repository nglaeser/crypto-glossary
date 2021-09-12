# Glossary

[General](#general) | [Areas of Crypto](#areas-of-cryptography) | [Primitives](#cryptographic-primitives) | [Threat Models](#threat-models) | [Security Definitions](#security-definitions--notions) | [Models](#models)

## General
**Advantage**: The probability of an _adversary_ violating the security property of a scheme. The advantage is generally defined with respect to a _security game_. For secure constructions, the adversary's advantage usually shown to be small by showing it is bounded by a _negligible function_.

**Adversary**: Some dishonest entity that will try to break a primitive or protocol. See [Threat Models](#threat-models) for the types of adversaries, each with different capabilities.

**Black-box**: Treating some algorithm or protocol as a "black box" that hides the inner mechanism, allowing only the inputs and outputs to be seen.

**Complexity Theory**:
- **Big-O notation**: Written O(n), this is an upper bound on the computational complexity of an algorithm/protocol/etc. when n is large enough.

- **Big-omega notation**: Written &Omega;(n), this is a lower bound on the computational complexity of an algorithm/protocol/etc. when n is large enough.

- **Big-theta notation**: Written &Theta;(n), this is an approximation of the computational complexity of an algorithm/protocol/etc. when n is large enough. A function _f(n)_ is Big-Theta of n (written as _f(n) &isin; &Theta;(n)_) iff _f(n) &isin; O(n)_ and _f(n) &isin; &Omega;(n)_.

<!-- TODO: drawing of O/Omega/Theta and f(n) --->

**Composition**:
- **Concurrent composition**: Two protocols &Pi;1, &Pi;2 running concurrently are run with their messages arbitrarily interleaved. In the two-party case:  
![The messages of the blue and green protocols are arbitrarily interleaved](./img/concurr-comp.png)  
In general, concurrent composition of secure protocols does not maintain security (against malicious adversaries). A special case of concurrent composition is _parallel composition_. Compare to _sequential composition_.

- **Hybrid composition**: 
  - >**Composition Theorem.** If &rho;_1_, ..., &rho;_m_ are secure protocols for computing the functionalities _f1_, ..., _fm_, and if &Pi; is a secure protocol for computing _f_ in the (_f1_, ..., _fm_)-hybrid world, then the composed protocol &Pi;^&rho;_1_, ..., &rho;_m_ is a secure protocol for _f_.  
  That is, if we have a protocol that can secure compute some function _f_ given it has access to some other functionality/ies, and we have protocols for securely computing those functionality/ies, we can "plug in" those protocols into our main protocol and it will be secure.

- **Parallel composition**: Two protocols &Pi;1, &Pi;2 running in parallel run in "lockstep", i.e. the first round messages of both are sent together, followed by the second, and so on. In the two-party case:  
![The messages in each round of the blue and green protocols are sent together](./img/parallel-comp.png)  
In general, composing secure protocols in parallel does not maintain security (against malicious adversaries). Parallel composition is a special case of _concurrent composition_. Compare to _sequential composition_.

- **Sequential composition**: Two protocols are composed sequentially when they are run back-to-back, i.e. one protocol only begins after the other has concluded. In the two-party case:  
![The messages in each round of the blue and green protocols are sent together](./img/seq-comp.png)  
Sequential composition of two secure protocols is still secure. Compare to _concurrent composition_, _parallel composition_.


**Correctness**: A property of a scheme that ensures it works correctly and does not trivially meet the definition of the scheme. For example, we usually require that decryption and encryption are inverses, or that sharing and reconstruction are inverses.

**Deterministic**: A function that always proceeds in the same way when run on the same outputs. Alternatively, the inputs directly determine the output. Compare to _randomized_.

**Feasibility result**:

**Field**: A set of elements _F_ with two binary operations + and • (addition and multiplication) that satisfy particular properties called the [field axioms](https://en.wikipedia.org/wiki/Field_(mathematics)#Classic_definition) (specifically associativity, commutativity, identity, and invertibility of both operations along with distributivity of multiplication over addition). Both the rational numbers and the real numbers are fields.

**Functionality**: A particular set of capabilities or properties to be achieved. For example, many protocols exist that implement the functionality of public key encryption. In this way, a functionality is abstract and independent of implementation details, and cryptosystems are build to achieve a functionality. Often, to prove security, a protocol is compared to an _ideal_ functionality, to show that it meets the same security properties.

**Function**: A mathematical object that maps each input to at most one output.

**Group**: A set of elements _G_ with some binary operation • (the group operation) that satisfies particular properties called the [group axioms](https://en.wikipedia.org/wiki/Group_(mathematics)#Definition) (specifically associativity, identity, and invertibility). The integers form a group under addition.

**Hardness assumption**: A problem, such as factoring, which is assumed to be hard. A cryptographic scheme's security may hinge on the adversary not being able to solve this problem, and if the assumption turns out not to hold, the proof of security is invalidated.

**i.i.d.**: Independent and identically distributed. Two random variables are i.i.d. if they have the same probability distribution and are independent of each other.

**Linear operations:** Addition and scalar multiplication.

**Negligible function**: A function that asymptotically (i.e. after some fixed point) decreases faster than any inverse polynomial:  
![The function f is upper bounded by n^{-1} and n^{-2} (and presumably all inverse polynomials) for large enough inputs.](./img/negligible.png)

<details>
<summary>Formal Definition</summary>
A function <emph>f</emph> is negligible if for all natural numbers <emph>c</emph>, there exists a natural number <emph>N</emph> such that <emph>f(n) < n^{-c}</emph> for all <emph>n > N</emph>.
</details>

**Protocol**: A sequence of messages exchanged between parties to compute some functionality. A protocol specifies how parties should compute their messages based on their knowledge and the other parties' responses. Usually denoted by the variable &Pi;.

**Randomized**: A function whose output is influenced by some additional source of randomness. Running the function twice on the same inputs may result in a different outcome. Compare to _deterministic_.

**Security game**: A game is a challenge in which an attacker (called the adversary and usually denoted by a curly letter A) is given some information and tries to break the security property of the scheme. A "wins" the game if it can give an answer that proves it broke the security property of the scheme. See ["Game-based security"](#game-based-security).
<!-- TODO: link to an example game, e.g. CCA -->

**Uniform**: A distribution is uniform, or a value uniformly distributed, if every outcome is equally likely. We may say that a value is "drawn uniformly at random". A uniform distribution over _N_ elements means each of the elements is drawn with probability 1/_N_.

**Without loss of generality**: 

## Areas of Cryptography
**Consensus**: An area of problems about how to get distributed systems to agree on state or some other piece of information. [More about consensus &rarr;](./consensus.md)

**Multi-party computation (MPC)**: Functionality in which two or more parties with secret inputs compute a joint function on those inputs. No party learns any more information about the others' inputs, except what it can infer from the output. [More about MPC &rarr;](./mpc.md)
- **Private set intersetion (PSI)**: Two parties, each with their own set, want to compute the intersection of these sets without revealing any of the elements not in the intersection. This is a specialized problem that can be considered to fall under MPC.
<!-- add use case -->


**Post-quantum cryptography (PQC)**: Cryptographic primitives that are secure against adversaries with quantum capabilities. _Lattice-based cryptography_ is one area of PQC.
- **Lattice-based cryptography**: Cryptography based on lattice hardness assumptions.

**Program Obfuscation**: hide the inner workings (and secrets) of a program cryptographically while preserving functionality. The strongest notion of security here is virtual-black-box (VBB) security, which means that the obfuscated program acts as a black box.

**Quantum Cryptography**: Rebuilding cryptographic primitives and cryptosystems that run on (and take advantage of the properties of) quantum computers.

**Zero-knowledge proofs**: Ways to prove knowledge of a piece of information without revealing that information. More specifically, the goal is usually to prove knowledge of a _witness_ for some _statement_ in a _language_ without revealing the witness. [More about zero-knowledge &rarr;](./zk.md)

## Cryptographic Primitives

Basic building blocks for cryptographic protocols.

**Cryptographic hash function**:

**Hash function**:

**Pseudo-random function (PRF)**: A function that maps inputs to outputs so that the outputs appear randomly distributed. The function is deterministic in the sense that querying it on the same input always returns the same (random-looking) output.

**Pseudo-random permutation (PRP)**:

**Encryption**: Encryption schemes are used to ensure _confidentiality_. [More about encryption &rarr;](primitives/encryption.md)

**Signatures**: Signatures are used to ensure _integrity_. [More about signatures &rarr;](primitives/signatures.md)

### Cryptographic Schemes
These are active lines of research creating particular schemes or primitives that to me don't seem quite large enough to be their own area and are new enough not to fall under the "classic" crypto primitives [above](#cryptographic-primitives).

**Message authentication code (MAC)**:

**Time-Lock Puzzle (TLP)**:

## Threat Models

**Malicious adversary**: An adversary that can deviate arbitrarily from the protocol it is participating in. That is, it doesn't follow the rules and may send malformed, empty, or incorrect messages, not send a message when it is supposed to or vice versa, and otherwise behave maliciously.  
Also known as **active adversary**; compare to _semi-honest adversary_.

> We sometimes use * as a superscript to denote that a party may be malicious, i.e. cheat and deviate from the protocol. For instance, the party S* in a commitment scheme denotes a potentially malicious sender.

**Semi-honest adversary**: An adversary that follows the protocol and acts honestly, but tries to learn as much as possible from the information it sees.  
Also known as **honest-but-curious (HbC)** or **passive**.

## Security Definitions & Notions

**Computational security**:

**Knowledge assumption**:

**Semantic security**: Equivalent to _IND-CPA_.

**UC security**: Universal composability. Security definitions in the UC framework cannot be game-based.

### Game-based security
Security is defined by a _security game_ in which an attacker should have _negligible_ _advantage_.

**CCA security**: Secure against chosen ciphertext attacks (CCA); this is an indistinguishability-based notion, so it is more accurately IND-CCA security. 
- **IND-CCA1**: Non-adaptive (lunchtime) chosen ciphertext attack. <!-- Game -->  
Weaker than IND-CCA2.
- **IND-CCA2**: Adaptive chosen ciphertext attack. "IND-CCA" (without a number) usually refers to IND-CCA2.
<!-- Game -->

**CPA security**: Secure against chosen plaintext attacks (CPA). Again, this is indistinguishability-based, so the more accurate name is IND-CPA security. This is equivalent to semantic security (semantic security &rArr; IND-CPA and IND-CPA &rArr; semantic security, so semantic security &iff; IND-CPA).
- **IND-CPA**:
<!-- Game -->

<!-- Table of security games. 
Columns: name, primitive (Enc, MAC, etc.), weaker/stronger than -->

---

**Adaptive security**:

**Computational security**:

**Information-theoretic security**: ... See also _unconditional security_.

**Perfect security**:

**Statistical security**: Another term for _information-theoretic security_.

**Unconditional security**: Usually used interchangeably with _information-theoretic security_. However, it can also be used to mean security that is not based on any computational assumption.

## Models

The phrase used is "[Scheme] is secure in the [X] model".
<!-- "In the __-hybrid model"? -->

**Oracle**:

**Algebraic Group Model (AGM)**: This is a stronger assumption than the _standard model_, but weaker than the _GGM_. The model assumes that the adversary is algebraic, meaning that for any group element it outputs, it also knows the representation of the group. This differs from the GGM in that the adversary knows and can exploit the group structure.

**Generic Group Model (GGM)**: This model assumes that the adversary is given access to a randomly chosen (encoding of a) group instead of the groups used in practice, which have efficient encodings. The adversary also has access to an oracle for the group function.
(Can see this as an analogue of giving the adversary access to a _random oracle_ instead of a real hash function used in practice.)

**Random Oracle Model (ROM)**: A proof paradigm that models hash functions as random oracles, i.e. an oracle that outputs a random number for any input (but outputs the same number when given the same input). Read more [here](https://blog.cryptographyengineering.com/2020/01/05/what-is-the-random-oracle-model-and-why-should-you-care-part-5/).

**Standard Model**: This model assumes only that the adversary is limited by time or computational power; it makes no further assumptions (the way, e.g., the ROM does). Proofs in the standard model therefore usually rest on a computational hardness assumption, but no idealized cryptographic primitives, and are thus very difficult. In this way this model is "better" than the others listed here because it assumes less.  
Also known as the **bare model** or **plain model**.
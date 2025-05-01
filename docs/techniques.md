# Standard Techniques

**Fiat-Shamir (FS) Transform** { #fiat-shamir }
: A technique which turns any constant-round public-coin [HVZK](./Areas-of-Cryptography/zk.md) protocol (e.g., a [sigma protocol](./Areas-of-Cryptography/zk.md#sigma-protocols)) into a [non-interactive zero-knowledge proof of knowledge (NIZK PoK)](./Areas-of-Cryptography/zk.md#types-of-zero-knowledge-proofs) in the [random oracle model](./general.md#rom). Introduced in [[FS86]](https://link.springer.com/content/pdf/10.1007/3-540-47721-7_12.pdf).
The technique works as follows: instead of sampling a random challenge, set the challenge equal to the hash of the protocol transcript until that point.

**Fujisaki-Okamoto (FO) Transform** { #fujisaki-okamoto }
: The FO transform is a technique which "upgrades" a [CPA-secure](./Cryptographic-Primitives/encryption.md#cpa-security)[^1] [PKE](./Cryptographic-Primitives/encryption.md#pke) to [CCA-security](./Cryptographic-Primitives/encryption.md#cca-security) in the [random oracle model](./general.md#rom). Introduced in [[FO99]](https://link.springer.com/content/pdf/10.1007/s00145-011-9114-1.pdf).
Given the base scheme $\Pi_E = (\mathsf{Gen}, \mathsf{Enc}, \mathsf{Dec})$ and two hash functions $H_1, H_2$ modeled as random oracles, the FO-transformed ciphertext for a message $m$ is $(\mathsf{Enc}(\mathsf{pk}, r; H_1(r)), H_2(r) + m)$, where $r$ is sampled uniformly at random.

[^1]: In fact, the base scheme only needs to satisfy an even weaker security property than CPA-security.

**Complexity Leveraging**
: 

**Forking Lemma**
: 

**Leftover Hash Lemma (LHL)**
: 

**Union bound**
: 

**Naor-Yung Paradigm** { #naor-yung }
: Another way to "upgrade" a [CPA-secure](./Cryptographic-Primitives/encryption.md#cpa-security) encryption scheme $\Pi_E = (\mathsf{Gen}, \mathsf{Enc}, \mathsf{Dec})$ to a [CCA1](./Cryptographic-Primitives/encryption.md#cca-security) one using an [adaptively-secure](./general.md#adaptive) [NIZK](./Areas-of-Cryptography/zk.md#nizk): compute $c_1 \gets \mathsf{Enc}(pk_1, m)$ and $c_2 \gets \mathsf{Enc}(pk_2, m)$ and use the NIZK to prove $c_1, c_2$ encrypt the same message; the CCA-secure ciphertext is $(c_1, c_2, \pi)$.

    !!! tip "Further Reading"
        ["CMSC 858K — Advanced Topics in Cryptography: Lecture 7"](https://www.cs.umd.edu/~jkatz/gradcrypto2/NOTES/lecture7.pdf) by Jonathan Katz

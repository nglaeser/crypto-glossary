# Secret Sharing

Sharing a secret means "splitting" it between parties so that none of the parties know the secret, but they each have a piece of the information. They can recover the secret only if they work together. Here's a visual intuition:  
<div style="text-align: center">
<a title="Blokhead at English Wikipedia, Public domain, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Visual_crypto_animation_demo.gif"><img width="256" alt="Visual crypto animation demo" src="https://upload.wikimedia.org/wikipedia/commons/0/0e/Visual_crypto_animation_demo.gif"></a>
</div>

## Basic Constructions

!!! example "Additive/XOR secret-sharing"

    For a secret $s$, set Party $i$'s share to some random value $r_i$, except for a designated party which gets $s - r_1 - \ldots - r_N$. The sum of the shares is $s$, but each individual share looks random.

!!! example "Shamir secret sharing [[Shamir79]](https://dl.acm.org/doi/abs/10.1145/359168.359176)"
    This is a form of $(t+1)$-out-of-$n$ secret-sharing, i.e., at least $t+1$ out of $n$ parties must work together to recover the secret. Shamir secret-sharing gives every party a point on a degree-t polynomial. Because t+1 points define a unique polynomial, t+1 parties can work together to recover it. The secret is the value when the polynomial is evaluated at 0. Interactive demo [here](./ShamirSS.ipynb).

## Advanced Types of Secret Sharing
Secret-sharing schemes with additional properties also exist and are sometimes helpful for constructing [MPC](../Areas-of-Cryptography/mpc.md) or other protocols.

**Function secret sharing (FSS)**
:

**Homomorphic secret sharing (HSS)**
:

**Robust secret sharing**
: Does not consider a corrupt dealer. ...

**Verifiable secret sharing (VSS)**
: Protects against a corrupt dealer. Parties who receive shares from the dealer can also run a verification function to confirm that the shares they received are well-formed (are consistent with each other).

    <a name="feldman-vss"></a>
    !!! example "Feldman VSS [[Fel87](https://www.cs.umd.edu/~gasarch/TOPICS/secretsharing/feldmanVSS.pdf)]"

        === "Construction"
            Choose a DLog-hard subgroup $G$ of $\mathbb{Z}_p$ such that $G$ is of order $q$ with generator $g$. The dealer shares the secret $s$ as in regular Shamir secret sharing, using some degree-t polynomial $f(x) = s + a_1 x + \ldots + a_t x^t \pmod{q}$.
            
            For verifiability, the dealer includes [commitments](../Cryptographic-Primitives/commitments.md) to the coefficients of $f$, calculated as 
            
            \[c_0 := g^s, c_1 := g^{a_1}, \ldots, c_t := g^{a_t} \in \mathbb{Z}_p\]
            
            To verify that some share $s_i = f(i)$, party $i$ (working in $\mathbb{Z}_p$) checks that
            
            \[ g^{s_i} \stackrel{?}{=} c_0 c_1^i \cdots c_t^{i^t} \pmod{p}\]
            
            Note that if the share and the commitments are well-formed, this equals $g^{s + a_1 i + \ldots + a_t i^t} = g^{f(i)}$.

        === "Properties"
            - Computationally secure (by [DLog](../assumptions.md#discrete-logarithm) assumption)

    !!! example "KZG-VSS [[KZG10]](https://www.iacr.org/archive/asiacrypt2010/6477178/6477178.pdf)"
        As explained in §4.1 of their paper, the KZG polynomial commitment scheme directly yields a more efficient version of the [Feldman VSS](#feldman-vss) by enabling a size-O(1) instead of O($n$) commitment to the Shamir-sharing polynomial $f$.

    - **Publicly-verifiable secret sharing (PVSS)**
    : 

## Related Protocols

**Distributed Key Generation (DKG)**
: 

    !!! example "Pedersen DKG"

    !!! example "Gennaro et al. DKG [GJKR]"
# Signatures

!!! summary
    Signatures are used to ensure integrity.

A digital signature scheme consists of three algorithms: a key generation algorithm $\mathsf{Gen}$ (or $\mathsf{KGen}$) that takes no input and outputs a key pair, an signing algorithm $\mathsf{Sign}$ that takes a private key and a message and outputs a signature, and a verification algorithm $\mathsf{Vrfy}$ that takes a public key, a message, and a signature and outputs 1 (the signature is a valid signature on that message) or 0 (the signature is not valid on that message).

!!! notation "Signature scheme syntax"
    - $({\sf pk}, {\sf sk}) \gets \mathsf{Gen}(1^\lambda)$
    - $\sigma \gets \mathsf{Sign}({\sf sk}, m)$
    - $\{0, 1\} \gets \mathsf{Vrfy}({\sf pk}, m, \sigma)$

For correctness, we require that for all key (pairs) output by $\sf Gen$ we have $\mathsf{Vrfy}({\sf pk}, m, \mathsf{Sign}({\sf pk}, m)) = 1$.

It is known that [OWFs](./other.md#owf) imply (one-time) signatures (OTS).

!!! example "One-time signatures (OTS) from OWFs [Lamport]"
<!-- TODO -->

OTS in turn imply many-time (i.e., regular) signatures:

!!! example "Many-time signatures from OTS"
    The construction is a bit involved so it is given in a [separate document](../assets/notes/Sigs-from-OTS.png). The general idea is to make a depth-$\lvert m \rvert$ binary tree of OTS keypairs. Then each parent is used to sign the pair of verification keys below it, and the signature on $m$ consists of the $\lvert m \rvert$ signatures on the path the bits of $m$ from the root to a leaf.

## Schemes

A common paradigm for a signature scheme is to instantiate a signature as a [NIZK](../Areas-of-Cryptography/zk.md#nizk) [PoK](../Areas-of-Cryptography/zk.md#pok) of the secret key (additionally incorporating the message). See the "Notes" section of the Schnorr signature scheme below for a discussion of how that scheme fits into this paradigm; another example is [Picnic](https://microsoft.github.io/Picnic/), a NIST [post-quantum cryptography](../Areas-of-Cryptography/pqc.md) candidate, which is essentially a [proof of knowledge](../Areas-of-Cryptography/zk.md#pok) of the preimage of a [one-way function](./other.md#owf).

!!! example "Digital Signature Algorithm (DSA)"
    === "Construction"
        DSA is an additive version of the Schnorr signature scheme (which can in turn be seen as a multiplicative version of DSA).

        Let $p,q$ be primes such that $q$ divides $p-1$ and $G$ be a group of order $p$ with generator $g$.
        Let $H$ be a [hash function](./hash.md).

        $\underline{\mathsf{Gen}}$: return the secret key $sk \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$ and the public key $pk := g^{sk} \mod{p}$.

        $\underline{\mathsf{Sign}(sk, m)}$: 

        - choose a one-time key $k \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$
        - compute a nonce $r := (g^k \mod{p}) \mod{q}$ (if $r=0$, start over with a different $k$)
        - compute $s := k^{-1} \cdot (H(m) + r \cdot sk) \mod{q}$ (if $s=0$, start over with a different $k$)
        - output the signature $\sigma := (s, r)$.

        $\underline{\mathsf{Vrfy}(pk,m, \sigma := (s,R))}$: 

        Check that the following hold:

        - $r,s \in \mathbb{Z}_q$
        - $r = (g^{u_1} {pk}^{u_2} \mod{p}) \mod{q}$, where $u_1 := H(m) \cdot s^{-1} \mod{q}$ and $u_2 := r \cdot s^{-1} \mod{q}$

    === "Assumptions"
        - [DLog](../assumptions.md#discrete-logarithm)

!!! example "ECDSA signatures"
    === "Construction"
        ECDSA is the [elliptic-curve](../Areas-of-Cryptography/ecc.md) version of DSA.

        Let $G$ be the base point of the elliptic curve, such that $G$ has prime order $p$. Use $\times$ to denote scalar multiplication of an elliptic curve point. We use lowercase variable names for scalars and uppercase variables for elliptic curve points.

        $\underline{\mathsf{Gen}}$: $sk \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_p$ and the public key $Q := {sk} \times G$.

        $\underline{\mathsf{Sign}(sk, m)}$:

        - choose a one-time key $k \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_p$
        - compute $R := k \times G$ (if $R=0$[^1], start over with a different $k$)
        - compute $S := k^{-1} \cdot (H(m) + sk \times R)$ (if $S=0$, start over with a different $k$)
        - output the signature $\sigma := (S, R)$.

        $\underline{\mathsf{Vrfy}(Q,m, \sigma := (S,R))}$:  

        Check that the following hold:

        - $Q,S,R$ are valid elliptic-curve points (and not equal to the identity)
        - compute $U_1 := H(m) S^{-1}$ and $U_2 := R S^{-1}$
        - $R = U_1 G + U_2 Q$

        [^1]: By this we mean the x-coordinate is 0 (the y-coordinate is uniquely defined -- up to reflection over the x-axis -- by the x-coordinate).

    === "Assumptions"
    - [DLog](../assumptions.md#discrete-logarithm) over elliptic curves

!!! example "Schnorr signatures"
    === "Construction" 
        Let $G$ be an elliptic curve group with generator $g$ and order $q$ and $H$ be a [hash function](./hash.md).

        $\underline{\mathsf{Gen}}$: return the secret key $sk \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$ and the public key $pk := g \cdot sk$.  

        $\underline{\mathsf{Sign}(sk, m)}$: 
        
        - choose a one-time key $k \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$
        - compute a nonce $r := g \cdot k$
        - compute $s := k + H(r || m ) \cdot sk \mod q$

        Return the signature $\sigma := (s, r)$.

        $\underline{\mathsf{Vrfy}(pk,m, \sigma := (s,r))}$: return the truth value of $s \cdot g =^? r + H(r || m) \cdot pk$.

    === "Assumptions"
        - [DLog](../assumptions.md#discrete-logarithm)

    === "Notes"
        Schnorr signatures can be viewed as a [NIZK](../Areas-of-Cryptography/zk.md#nizk) [PoK](../Areas-of-Cryptography/zk.md#pok) of the discrete logarithm of the public key (i.e., knowledge of the secret key). Note that the Schnorr signing algorithm is essentially a standard [sigma-protocol for DLog](../Areas-of-Cryptography/zk.md#sigma-protocols), made non-interactive with the [Fiat-Shamir transform](../techniques.md).

!!! example "EdDSA"
    EdDSA is a variant of the Schnorr signature scheme for twisted Edwards [elliptic curves](../Areas-of-Cryptography/ecc.md).

!!! example "BLS signatures"
    === "Construction" 
        Let $\mathbb{G}_1, \mathbb{G}_2$ be [elliptic curve](../Areas-of-Cryptography/ecc.md) groups of order $p$ generated by $P, Q$, respectively, and $e$ be an efficiently computable [bilinear map](../Areas-of-Cryptography/ecc.md#bilinear-map) on them. Let $H$ be a [hash function](./hash.md) onto $\mathbb{G}_1$.

        $\underline{\mathsf{Gen}}$: sample the secret key $x \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_p$ and compute the corresponding public key $V := xQ$.

        $\underline{\mathsf{Sign}(sk, m)}$: Output $\sigma := x H(m)$

        $\underline{\mathsf{Vrfy}(pk,m, \sigma := (s,r))}$: check $e(\sigma, Q) = e(H(m), V)$.

    === "Assumptions"
        - [co-Gap Diffie Hellman](../assumptions.md#co-gdh)

    === "Notes"
        The scheme extends straightforwardly to (a robust, t-out-of-n) [threshold signature](#threshold-sig). Parties receive [Shamir secret shares](../Areas-of-Cryptography/mpc.md#secret-sharing) $x_i$ of the secret key, and the public key and partial public keys $V_i := x_i Q$ are published for all $i$.

        To sign a message, parties that want to participate produce a partial signature (a share of the full signature) $\sigma_i$ by signing using their share of the secret key. That is, $\sigma_i = x_i H(m)$. The full signature is then 

        $$ \prod_i \lambda_i \sigma_i $$

        where the $\lambda_i$ is each party's Lagrange interpolation at 0. That is,

        $$ \sigma = \prod_i \lambda_i (x_i H(m)) = (\sum_i \lambda_i x_i) H(m) = x H(m) $$

        where Shamir reconstruction is happening homomorphically in the "exponent".

        This scheme is also **robust**: the validity of the signature share $\sigma_i$ can be checked by checking that $(Q, V_i, H(m), \sigma_i)$ is a [co-Diffie-Hellman](../assumptions.md#co-ddh) tuple (of the form $(Q, a Q, H, b H)$ where $a=b$).

<!-- TODO can be used to construct identity-based signatures? -->

!!! example "CL signatures"


## Other types

**Blind signatures**
: 
!!! example "Blind Schnorr signatures"

**Designated-verifier (DV) signatures**
: Instead of being publicly verifiable, a signature can only be verified by a specific party (the DV). [Message authentication codes (MACs)](./other.md#mac) can be thought of as DV-sigs, since a secret key is necessary to verify a MAC, so only parties that know the secret key can perform verification.

**Functional signatures**
: 

**Lockable signatures**
: 

**Structure-preserving signatures**
: 

**Threshold signatures** { #threshold-sig }
: signing/secret key is split into [secret shares](../Areas-of-Cryptography/mpc.md#secret-sharing); producing a signature requires some threshold number of shares. A threshold signature should be [indistinguishable](../general.md#indist) from an ordinary signature. Additionally, no single party should ever learn the secret key.

## Security Notions

**EUF-CMA**
: **E**xistential **U**n**F**orgeability under [adaptive](../general.md#adaptive) **C**hosen **M**essage **A**ttacks, aka "existential unforgeability".

    !!! info "EUF-CMA game"

        1. Challenger: $pk,sk \gets \mathsf{Gen}(1^n)$
        1. $\mathcal{A}(pk)$ interacts with $\mathsf{Sign}(sk,\cdot)$ (in polynomial time) – that is, it gets to see polynomially many valid signatures on _chosen_ messages
        1. $\mathcal{A}$ outputs a message-signature pair $m^*,\sigma^*$

        $\mathcal{A}$ *wins* if (1) $m^*$ wasn't one of the messages on which it queried the signing oracle and (2) $\mathsf{Vrfy}(pk,m^*,\sigma^*) = 1$; in this case, the game outputs 1.

    <!-- TODO diagram like CPA,CCA security -->

**SUF-CMA**
: **S**trong **U**n**F**orgeability under adaptive **C**hosen **M**essage **A**ttacks, aka "strong unforgeability".

    !!! info "SUF-CMA game"

        Same as the EUF-CMA game, only the winning condition changes:

        $\mathcal{A}$ *wins* if (1) **$(m^*,\sigma^*)$ wasn't one of the message-signature pairs** on which it queried the signing oracle and (2) $\mathsf{Vrfy}(pk,m^*,\sigma^*) = 1$; in this case, the game outputs 1.

    This is a stronger definition than EUF-CMA, since the attacker can win by forging a signature on a previously-queried message $m^*$ **as long as the signature is different**, for example by "mauling" a valid signature without changing its validity. 

    This might seem a bit odd -- what does it matter if the adversary produces a different signature? The message was already signed by an honest party, so the adversary isn't convincing anyone that the party signed something it *didn't* actually sign. However, this difference does end up being important in some applications where signatures are used as building blocks.

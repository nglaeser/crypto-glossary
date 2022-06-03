# Signatures

!!! summary
    Signatures are used to ensure integrity.

A digital signature scheme consists of three algorithms: a key generation algorithm $\mathsf{Gen}$ (or $\mathsf{KGen}$) that takes no input and outputs a key pair, an signing algorithm $\mathsf{Sign}$ that takes a private key and a message and outputs a signature, and a verification algorithm $\mathsf{Vrfy}$ that takes a public key, a message, and a signature and outputs 1 (the signature is a valid signature on that message) or 0 (the signature is not valid on that message).

!!! notation "Encryption scheme syntax"
    - $({\sf pk}, {\sf sk}) \gets \mathsf{Gen}(1^\lambda)$
    - $\sigma \gets \mathsf{Sign}({\sf sk}, m)$
    - $\{0, 1\} \gets \mathsf{Vrfy}({\sf pk}, m, \sigma)$

For correctness, we require that for all key (pairs) output by $\sf Gen$ we have $\mathsf{Vrfy}({\sf pk}, m, \mathsf{Sign}({\sf pk}, m)) = 1$.

It is known that OWFs imply (one-time) signatures.

!!! example "One-time signatures from OWFs"
<!-- Give construction -->

## Schemes

!!! example "Digital Signature Algorithm (DSA)"
    === "Scheme"
        DSA is an additive version of Schnorr (which can in turn be seen as a multiplicative version of DSA).

        Let $p,q$ be primes such that $q$ divides $p-1$ and $G$ be a group of order $p$ with generator $g$.
        Let $H$ be a hash function.

        $\underline{\mathsf{Gen}}$: return the secret key $sk \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$ and the public key $pk := g^{sk} \mod{p}$.

        $\underline{\mathsf{Sign}(sk, m)}$: 

        - choose a one-time key $k \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$
        - compute a nonce $r := (g^k \mod{p}) \mod{q}$ (if $r=0$, start over with a different $k$)
        - compute $s := k^{-1} \cdot (H(m) + r \cdot sk) \mod{q}$ (if $s=0$, start over with a different $k$)

        Return the signature $\sigma := (s, r)$.

        $\underline{\mathsf{Vrfy}(pk,m, \sigma := (s,R))}$: 

        Check that the following hold:

        - $r,s \in \mathbb{Z}_q$
        - $(g^{u_1} {pk}^{u_2} \mod{p}) \mod{q} = r$, where $u_1 := H(m) \cdot s^{-1} \mod{q}$ and $u_2 := r \cdot s^{-1} \mod{q}$

    === "Assumptions"
        - DLog

!!! example "ECDSA signatures"

!!! example "Schnorr signatures"
    === "Scheme" 
        Let $G$ be an elliptic curve group with generator $g$ and order $q$ and $H$ be a hash function.

        $\underline{\mathsf{Gen}}$: return the secret key $sk \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$ and the public key $pk := g \cdot sk$.  

        $\underline{\mathsf{Sign}(sk, m)}$: 
        
        - choose a one-time key $k \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$
        - compute a nonce $r := g \cdot k$
        - compute $s := k - H(r || m ) \cdot sk \mod q$

        Return the signature $\sigma := (s, r)$.

        $\underline{\mathsf{Vrfy}(pk,m, \sigma := (s,r))}$: return the truth value of $s \cdot g =^? r - H(r || m) \cdot pk$.

    === "Assumptions"
        - DLog

!!! example "CL signatures"


## Other types

**Blind signatures**
: 
!!! example "Blind Schnorr signatures"

**Designated-verifier (DV) signatures**
: Instead of being publicly verifiable, a signature can only be verified by a specific party (the DV). _Message authentication codes (MACs)_ can be thought of as DV-sigs, since a secret key is necessary to verify a MAC, so only parties that know the secret key can perform verification.

**Functional signatures**
: 

**Lockable signatures**
: 

**Structure-preserving signatures**
: 

**Threshold signatures**
: signing/secret key is split into _shares_; producing a signature requires some threshold number of shares. A threshold signature should be indistinguishable from an ordinary signature

## Security Notions

**EUF-CMA**
: **E**xistential **U**n**F**orgeability under adaptive **C**hosen **M**essage **A**ttacks, aka "existential unforgeability".
!!! info "EUF-CMA game"

    1. Challenger: $pk,sk \gets \mathsf{Gen}(1^n)$
    1. $\mathcal{A}(pk)$ interacts with $\mathsf{Sign}(sk,\cdot)$ (in polynomial time) – that is, it gets to see polynomially many valid signatures on _chosen_ messages
    1. $\mathcal{A}$ outputs a message-signature pair $m^*,\sigma^*$

    $\mathcal{A}$ *wins* if (1) $m^*$ wasn't one of the messages on which it queried the signing oracle and (2) $\mathsf{Vrfy}(pk,m^*,\sigma^*) = 1$; in this case, the game outputs 1.

**SUF-CMA**
: **S**trong **U**n**F**orgeability under adaptive **C**hosen **M**essage **A**ttacks, aka "strong unforgeability".
!!! info "SUF-CMA game"

    Same as the EUF-CMA game; only the winning condition changes:

    $\mathcal{A}$ *wins* if (1) **$(m^*,\sigma^*)$ wasn't one of the message-signature pairs** on which it queried the signing oracle and (2) $\mathsf{Vrfy}(pk,m^*,\sigma^*) = 1$; in this case, the game outputs 1.

: This is a stronger definition than EUF-CMA, since the attacker can win by forging a signature on a previously-queried message $m^*$ **as long as the signature is different**, for example by "mauling" a valid signature without changing its validity. 

: This might seem a bit odd -- what does it matter if the adversary produces a different signature? The message was already signed by an honest party, so the adversary isn't convincing anyone that the party signed something it *didn't* actually sign. However, this difference does end up being important in some applications where signatures are used as building blocks.

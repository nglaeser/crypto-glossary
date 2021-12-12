# Signatures

It is known that OWFs imply signatures.
<!-- Give construction -->

## Schemes

!!! info "CL signatures"

!!! info "ECDSA signatures"

!!! info "Schnorr signatures"
    === "Assumptions"
        - DLog
        
    === "Scheme" 
        Let $G$ be an elliptic curve group with generator $g$ and order $q$.

        - $KeyGen(G, g, q)$: choose a uniform element $sk \in Z_q$; set the public key $pk = sk \cdot g$.  
        - $Sign(sk, m)$: choose a uniform one-time key $k \in Z_q$; compute a nonce $R = k \cdot g$; the signature is $\sigma = (k - sk \cdot H(R || m ) \mod q), R)$, where $H$ is a hash function.  
        - $Verify(m, \sigma = (s,R))$: Check $s \cdot g =^? R - H(R || m) \cdot pk$.

## Other types

**Blind signatures**
: 
!!! info "Blind Schnorr signatures"

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

    1. Challenger: $pk,sk \gets Gen(1^n)$
    1. $\mathcal{A}(pk)$ interacts with $Sign_{sk}(\cdot)$ (in polynomial time) – that is, it gets to see polynomially many valid signatures on _chosen_ messages
    1. $\mathcal{A}$ outputs a message-signature pair $m^*,\sigma^*$

    $\mathcal{A}$ *wins* if (1) $m^*$ wasn't one of the messages on which it queried the signing oracle and (2) $Verify_{pk}(m^*,\sigma^*) = 1$; in this case, the game outputs 1.

**SUF-CMA**
: **S**trong **U**n**F**orgeability under adaptive **C**hosen **M**essage **A**ttacks, aka "strong unforgeability".
!!! info "SUF-CMA game"

    Same as the EUF-CMA game; only the winning condition changes:

    $\mathcal{A}$ *wins* if (1) **$(m^*,\sigma^*)$ wasn't one of the message-signature pairs** on which it queried the signing oracle and (2) $Verify_{pk}(m^*,\sigma^*) = 1$; in this case, the game outputs 1.

: This is a stronger definition than EUF-CMA, since the attacker can win by forging a signature on a previously-queried message $m^*$ **as long as the signature is different**, for example by "mauling" a valid signature without changing its validity. 

: This might seem a bit odd -- what does it matter if the adversary produces a different signature? The message was already signed by an honest party, so the adversary isn't convincing anyone that the party signed something it *didn't* actually sign. However, this difference does end up being important in some applications where signatures are used as building blocks.

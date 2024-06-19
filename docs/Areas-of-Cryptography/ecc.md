# Elliptic-Curve Cryptography

!!! tip "Further Reading"
    - ["A (Relatively Easy To Understand) Primer on Elliptic Curve Cryptography"](https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/) by Nick Sullivan
    - ["Elliptic Curve Cryptography: a gentle introduction"](https://andrea.corbellini.name/2015/05/17/elliptic-curve-cryptography-a-gentle-introduction/) by Andrea Corbellini

    <!-- https://crypto.stackexchange.com/questions/102887/what-are-the-structural-differences-between-bls12-381-and-bls12-377 (good links therein) -->
    <!-- https://hackmd.io/@benjaminion/bls12-381 -->
    <!-- https://neuromancer.sk/std/ -->
    <!-- https://hackmd.io/@jpw/bn254 -->

**Elliptic curve (EC)**
: In cryptography, we use ECs over finite fields (i.e., $\mathbb{F}_n$, which is unique for a given value of $n$). Often, we use a [prime field](../general.md#field) $\mathbb{F}_p$ where $p$ is prime. An EC over $\mathbb{F}_n$ is defined as a set of points $(x,y) \in \mathbb{F}_n^2$ satisfying some bivariate equation.

    | Type | Field | EC | Examples
    |:-----|:------|:--:|:--------
    | Weierstrass | $\mathbb{F}_p$ | $\{ (x,y): y^2 = x^3 + ax + b, 4a^3 + 27b^2 \neq 0\}$ | All curves can be written in Weierstrass form
    | Koblitz | $\mathbb{F}_{2^p}$ | $\{ (x,y) : y^2 + xy = x^3 + ax^2 + 1, a \in \{0,1\}\}$ | nistk163, nistk283, nistk571 (the number after `k` is the prime $p$)
    | Binary | $\mathbb{F}_{2^m}$ | $\{ (x,y) : x^2 + xy = x^3 + x^2 + b \}$ | nistb163, nistb283, nistb571
    | Edwards | | $\{ (x,y) : x^2 + y^2 = 1 + dx^2y^2, d \in \{0,1\}\}$ |
    | Montgomery || $\{ (x,y) : by^2 = x^3 + ax^2 + x, b(a^2-4) \neq 0 \}$ | Curve25519

    An EC may or may not be **[pairing](#pairing)-friendly**. Pairing-friendly curves [have all three of the common pairings](https://crypto.stackexchange.com/questions/70802/do-weil-tate-and-ate-pairings-exist-on-all-elliptic-curves) (Weil, Ate, and Tate).

    | Pairing-friendly     | No pairing |
    |:---------------------|:---------------------|
    | Baretto-Naehrig (e.g., BN254) | secp256k1            |
    | Barreto-Lynn-Scott (e.g., BLS12-381, BLS12-377) | NIST P-256 |
    | Kachisa-Schaefer-Scott (KSS)  | Curve25519 |
    | Miyaji-Nakabayashi-Takano (MNT) | |

    <!-- https://www.ietf.org/proceedings/105/slides/slides-105-cfrg-pairing-friendly-curves-00.pdf -->

    !!! tip "Resource"
        - The parameters for many elliptic curves used in practice can be found [here](https://safecurves.cr.yp.to/index.html).

## Pairing-Based Cryptography

(Bilinear) **Pairing** { #pairing }
: In its most common form in cryptography, a bilinear pairing is a map $e: G_1 \times G_2 \rightarrow G_T$, where $G_1, G_2$ are additive cyclic groups of prime order $q$ and $G_T$ is a *multiplicative* cyclic group of order $q$. The map $e$ is required to have the following properties:

    - **Bilinearity.** For any $a,b \in \mathbb{F}_q^*$ and $P, P_1, P_2 \in G_1$ and $Q, Q_1, Q_2 \in G_2$,
        - $e(aP, Q) = e(P, aQ) = e(P,Q)^a$[^1] and
        [^1]: Therefore $e(aP, bQ) = e(P,Q)^{ab}$.
        - $e(P_1 + P_2, Q) = e(P_1, Q) \cdot e(P_2, Q)$ and $e(P, Q_1 + Q_2) = e(P, Q_1) \cdot e(P, Q_2)$.
    - **Non-degeneracy.** $e(P, Q) \neq 1$ where $P, Q$ are generators of $G_1, G_2$, respectively.
    - **Computability.** There is an efficient algorithm for computing $e$.

    (A **bilinear map** is only required to meet the first property.)
    { #bilinear-map }

    The types of pairings are:

    - **Type-1** (symmetric pairing): $G_1 = G_2$. [DDH](../assumptions.md#diffiehellman-dh-assumptions) is easy in $G_1$ (and therefore $G_2$).  
    { #type-1 }
    - **Type-2**: $G_1 \neq G_2$ but there exists an efficiently computable homomorphism $\phi: G_2 \rightarrow G_1$. [DDH](../assumptions.md#diffiehellman-dh-assumptions) is easy in $G_2$ but thought to be hard in $G_1$, referred to as the [external Diffie-Hellman (XDH) assumption](../assumptions.md#diffiehellman-dh-assumptions).  
    { #type-2 }
    - **Type-3**: $G_1 \neq G_2$ and there is no efficiently computable homomorphism between $G_1$ and $G_2$. [DDH](../assumptions.md#diffiehellman-dh-assumptions) is thought to be hard in both $G_1$ and $G_2$, referred to as the [symmetric external Diffie-Hellman (SXDH) assumption](../assumptions.md#diffiehellman-dh-assumptions).  
    { #type-3 }

    Examples: [Weil pairing](https://crypto.stanford.edu/pbc/notes/ep/pairing.html), [Tate pairing](https://crypto.stanford.edu/pbc/notes/ep/tate.html), [Ate pairing](https://eprint.iacr.org/2006/110)
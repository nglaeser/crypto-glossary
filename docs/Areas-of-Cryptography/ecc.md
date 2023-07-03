# Elliptic-Curve Cryptography

!!! tip "Further Reading"
    ["A (Relatively Easy To Understand) Primer on Elliptic Curve Cryptography"](https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/) by Nick Sullivan

**Elliptic curve**
: 

**Pairing** { #pairing }
: In its most common form in cryptography, a pairing is a map $e: G_1 \times G_2 \rightarrow G_T$, where $G_1, G_2$ are additive cyclic groups of prime order $q$ and $G_T$ is a *multiplicative* cyclic group of order $q$. The map $e$ is required to have the following properties:

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
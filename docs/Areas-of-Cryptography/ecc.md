# Elliptic-Curve Cryptography

!!! tip "Further Reading"
    ["A (Relatively Easy To Understand) Primer on Elliptic Curve Cryptography"](https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/) by Nick Sullivan

<!-- **Bilinear map**
: A function $B: V \times W \rightarrow X$[^1] so that if the first entry is fixed while the second varies, the function is a linear operator, and vice versa. This means the map has the properties

- for all scalars $\lambda$ (see footnote), $B(\lambda v, w) = B(v, \lambda w) = \lambda B(v,w)$.
- $B$ is additive in both components: $B(v_1 + v_2, w) = B(v_1, w) + B(v_2, w)$ and $B(v, w_1 + w_2) = B(v, w_1) + B(v, w_2)$.

[^1]: where $V, W, X$ are vector spaces over a base field F or modules over a commutative ring R (one can also use a non-commutative ring). -->

**Elliptic curve**
: 

**Pairing**
: In its most common form in cryptography, a pairing is a map $e: G_1 \times G_2 \rightarrow G_T$, where $G_1, G_2$ are additive cyclic groups of prime order $q$ and $G_T$ is a *multiplicative* cyclic group of order $q$. The map $e$ is required to have the following properties:

    - **Bilinearity.** For any $a,b \in \mathbb{F}_q^*$ and $P \in G_1$ and $Q \in G_2$, $e(aP, Q) = e(P, aQ) = e(P,Q)^a$ (therefore $e(aP, bQ) = e(P,Q)^{ab}$).
    <!-- - $e(x_1 x_2, y) = e(x_1, y) + e(x_2, y)$ and $e(x, y_1 y_2) = e(x, y_1) + e(x, y_2)$   -->
    - **Non-degeneracy.** $e(P, Q) \neq 1$ where $P, Q$ are generators of $G_1, G_2$, respectively.
    - **Computability.** There is an efficient algorithm for computing $e$.

    (A **bilinear map** is only required to meet the first property.)

    The types of pairings are:

    - **Type-1** (symmetric pairing): $G_1 = G_2$. [DDH](../assumptions.md#diffiehellman-dh-assumptions) is easy in $G_1$ (and therefor $G_2$).  
    - **Type-2**: $G_1 \neq G_2$ but there exists an efficiently computable homomorphism $\phi: G_2 \rightarrow G_1$. [DDH](../assumptions.md#diffiehellman-dh-assumptions) is easy in $G_2$ but thought to be hard in $G_1$, referred to as the [external Diffie-Hellman (XDH) assumption](../assumptions.md#diffiehellman-dh-assumptions).  
    - **Type-3**: $G_1 \neq G_2$ and there is no efficiently computable homomorphism between $G_1$ and $G_2$. [DDH](../assumptions.md#diffiehellman-dh-assumptions) is thought to be hard in both $G_1$ and $G_2$, referred to as the [symmetric external Diffie-Hellman (SXDH) assumption](../assumptions.md#diffiehellman-dh-assumptions).  
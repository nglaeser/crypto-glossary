# Elliptic-Curve Cryptography

!!! tip "Further Reading"
    ["A (Relatively Easy To Understand) Primer on Elliptic Curve Cryptography"](https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/) by Nick Sullivan

**Elliptic curve**
: 

**Pairing**
: In its most common form, a pairing is a bilinear-map $e: G_1 \times G_2 \rightarrow G_T$ such that for any $a,b \in \mathbb{Z}$ and $x, x_1, x_2 \in G_1$ and $y, y_1, y_2 \in G_2$ (where $G_1, G_2$ are abelian multiplicative groups):  

- $e(x^a, y) = e(x, y^a) = e(x,y)^a$ (therefore $e(x^a, y^b) = e(x,y)^{ab}$)  
- $e(x_1 x_2, y) = e(x_1, y) + e(x_2, y)$ and $e(x, y_1 y_2) = e(x, y_1) + e(x, y_2)$  

The pairing is **non-degenerate** if $e(g_1, g_2) \neq 1$, where $g_1, g_2$ are generators of $G_1, G_2$, respectively.
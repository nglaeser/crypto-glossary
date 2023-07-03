# Commitment schemes

A commitment scheme consists of a commitment algorithm $\sf Com$ and an opening (decommitment) algorithm $\sf Open$.

- ${\sf Com}(m) \rightarrow ({\sf com}, {\sf decom})$: Commit to a message $m$ with the commitment $\sf com$; also output decommitment information $\sf decom$.
- ${\sf Open}({\sf com}, {\sf decom}) \rightarrow m$: Open the commitment.

!!! example "Pedersen commitments"

    === "Scheme"
        Given a group $\mathbb{G}$ of prime order $q$ and $g,h$ elements (generators) of $\mathbb{G}$:

        - $\underline{{\sf Com}(m)}:$ output ${\sf com} = g^m h^r$ where $r \gets^\$ \mathbb{Z}_q$; set ${\sf decom} = (m,r)$.
        - $\underline{{\sf Open}({\sf com}, {\sf decom})}:$ directly outputs ${\sf decom} = (m,r)$. The verifier can check that ${\sf com} = g^m h^r$.

    === "Properties"
        - unconditional hiding
        - computational binding (by DLog assumption)

## Properties

**Hiding** { #hiding }
: Seeing $\sf com$ should reveal no information about $m$.

**Binding** { #binding }
: It should be infeasible to open $\sf com$ to a different message $m' \neq m$ (i.e., find some other decommitment information ${\sf decom}' \neq {\sf decom}$ so that ${\sf Open}({\sf com}, {\sf decom}') \neq m$).

!!! info "Hiding vs. binding tradeoff"
    There is an inherent tradeoff between the strength of the hiding and binding properties of a scheme: if a scheme is [perfectly](../general.md#perfect-security) [hiding](#hiding), it can be only [computationally](../general.md#computational) [binding](#binding); and vice versa.

## Types of commitments

Besides the basic commitment functionality, there are additional "fancier" types of commitment schemes.

**Polynomial commitment** { #poly-com }
: Allows one to commit to a polynomial $f(x)$ and later open it at individual points, e.g. reveal $f(a)$.

    !!! example "Kate/KZG polynomial commitment"

        === "Scheme"
            Let $\mathbb{G}$ be an [elliptic curve group](../Areas-of-Cryptography/ecc.md) of prime order $p$ with generator $G$ (additive notation) and $d$ be the degree of the polynomial to commit to. Furthermore, let $e: \mathbb{G} \times \mathbb{G} \mapsto \mathbb{G}_T$ be a [bilinear pairing](../Areas-of-Cryptography/ecc.md#pairing).

            - $\underline{{\sf Setup}}$: output ${\sf crs} = \{G, aG, a^2 G, \dots, a^d G\}$ for a uniform $a \in \mathbb{Z}_p$.
            - $\underline{{\sf Com}({\sf crs}, f(x))}$: the commitment to the polynomial $f(x) = f_0 + f_1 x + \dots + f_d x^d$ is $f(a) \cdot G$, which can be computed from the $\sf crs$ as 

                $$C_f = f_0 {\sf crs}[0] + f_1 {\sf crs}[1] + \dots + f_d {\sf crs}[d]$$

                $$= f_0 G + f_1 a G + \dots f_d a^d G = f(a) \cdot G.$$

            - $\underline{{\sf EvalProof}({\sf crs}, C_f, b, c)}$: to prove that the commitment $C_f$ to $f$ opens to $c$ at $b$, i.e. that $f(b) = c$, send $C_q \gets {\sf Com}({\sf crs}, q(x))$, where 

                $$ q(x) = \frac{f(x) - f(b)}{x - b} = \frac{f(x) - c}{x - b} $$
            
                (this is a polynomial by [Little Bézout's Theorem](https://en.wikipedia.org/wiki/Polynomial_remainder_theorem)). The verifier checks that $e(C_q, aG - bG) = e(C_f - cG, G)$ holds.

        === "Properties"
            - The prover can do a "full open" and reveal the full polynomial by simply sending a candidate polynomial $f'$; the verifier checks that ${\sf Com}({\sf crs}, f'(x)) = C_f$. There is an [optimization [Feist-Khovratovich]](https://alinush.github.io/2021/06/17/Feist-Khovratovich-technique-for-computing-KZG-proofs-fast.html) that allows one to do this in $d\log{d}$ time instead of $d^2$.
            - There is also a "batch mode" in which the prover can open $t < d$ points, which the verifier can check with a single pairing. See "Further reading".
            - **Trusted setup**: the scheme relies on a trusted setup, i.e. a well-formed CRS. (On the plus side, the CRS is of the "power-of-tau" variant, which is fairly easy to generate via an [MPC](../Areas-of-Cryptography/mpc.md) protocol (e.g., [2022/1592](https://eprint.iacr.org/2022/1592)).)

        === "Further reading"
            For a more detailed description of the scheme, see [https://risencrypto.github.io/Kate/](https://risencrypto.github.io/Kate/).

**Shrinking commitment**
: <!-- used when we want the pk to be small? -->

**Vector commitment** { #vc }
: A vector commitment allows one to commit to a vector $\vec{v} = (v_1, \dots, v_n)$ and later individually open elements $v_i$. (Note that a [polynomial commitment](#poly-com) to a polynomial of degree $d$ can be thought of as a vector commitment to $d+1$ points.)

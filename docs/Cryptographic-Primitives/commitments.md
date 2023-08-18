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

**Vector commitment** { #vc }
: A vector commitment allows one to commit to a vector $\vec{v} = (v_1, \dots, v_n)$ and later individually open elements $v_i$. (Note that a [polynomial commitment](#poly-com) to a polynomial of degree $d$ can be thought of as a vector commitment to $d+1$ points.)

    !!! example "Libert-Yung VC [[LY10]](https://www.iacr.org/archive/tcc2010/59780496/59780496.pdf)"

        === "Scheme"
            This is a modified version of the original Libert-Yung VC, which was "mercurial", meaning it allowed both "hard" (normal) and "soft" (teasing open to any message a commitment originally made to "no message") openings.

            Let $\mathbb{G},\mathbb{G}_T$ be bilinear groups of prime order $p$ and $e: \mathbb{G} \times \mathbb{G} \rightarrow \mathbb{G}_T$ be a bilinear map. Let $g$ be a random generator of $\mathbb{G}$.

            - $\underline{{\sf Setup}(1^\lambda, q)}$: To set up a VC for vectors of length at most $q$, sample (a trapdoor) $z \stackrel{\$}{\gets} \mathbb{Z}_p^*$ and compute $h_i := g^{z^i}$ for $i = 1, \ldots, q, q+2, \ldots, 2q$.

            - $\underline{{\sf Com}({\sf pp}, \vec{v})}$: To commit to $\vec{v} = (m_1, \ldots, m_q)$, compute

            $$C := h_1^{m_1} h_2^{m_2} \dots h_q^{m_q}$$

            and output $C$ as the commitment.

            - $\underline{{\sf Open}({\sf pp}, i, m_i)}$: Compute $\Lambda_i := \prod_{j=1,j \neq i}^{q} g_{q+1-j+i}^{m_j}$.

            - $\underline{{\sf Vrfy}({\sf pp}, C, i, m_i, \Lambda_i)}$: Given an opening $(i, m_i)$ for the commitment $C$ and an opening proof $\Lambda_i$, a party can verify the correctness of the opening by checking that 
            
            $$e(C, h_{q+1-i}) = e(\Lambda_i, g) \cdot e(h_i^{}).$$



        === "Properties"

        === "Further reading"

    !!! example "(Updatable) VC from CDH [[CF13]](https://eprint.iacr.org/2011/495)"

        === "Scheme"
            Let $\mathbb{G},\mathbb{G}_T$ be bilinear groups of prime order $p$ and $e: \mathbb{G} \times \mathbb{G} \rightarrow \mathbb{G}_T$ be a bilinear map. Let $g$ be a random generator of $\mathbb{G}$.

            - $\underline{{\sf Setup}(1^\lambda, q)}$: To set up a VC for vectors of length at most $q$, sample (trapdoors) $z_1, \ldots, z_q \stackrel{\$}{\gets} \mathbb{Z}_p$. Compute $h_i := g^{z_i}$ and $h_{i,j} = g^{z_i z_j}$ for $i,j = 1, \ldots, q$ with $j \neq i$. Output ${\sf pp} := (g, \{h_i\}_{i \in [q]}, \{h_{i,j}\}_{i,j \in [q], i \neq j})$.

            - $\underline{{\sf Com}({\sf pp}, \vec{v})}$: To commit to $\vec{v} = (m_1, \ldots, m_q)$, compute

            $$C := h_1^{m_1} h_2^{m_2} \dots h_q^{m_q}$$

            (same as Libert-Yung VC) and output the commitment $C$ and auxiliary information ${\sf aux} := (m_1, \ldots, m_q)$.

            - $\underline{{\sf Open}({\sf pp}, i, m_i, {\sf aux})}$: Compute $\Lambda_i := \prod_{j=1,j\neq i}^{q} h_{i,j}^{m_j} = \prod_{j=1,j\neq i}^{q} \left( h_j^{m_j} \right)^{z_i}$.

            - $\underline{{\sf Vrfy}({\sf pp}, C, i, m_i, \Lambda_i)}$: Given an opening $(i, m_i)$ for the commitment $C$ and an opening proof $\Lambda_i$, a party can verify the correctness of the opening by checking that 
            
            $$e(C/h_i^{m_i}, h_i) = e(\Lambda_i, g).$$

            ---

            - $\underline{{\sf Update}({\sf pp}, C, i, m, m')}$: To update the $i$th entry $m$ to $m'$, compute an updated commitment $C' := C \cdot h_i^{m'-m}$ and updating information $U := (m, m', i)$.

            - $\underline{{\sf PfUpdate}({\sf pp}, C, \Lambda_j, m', U)}$: A proof for the opening of position $j$ which was valid w.r.t. $C$ can be updated for $C'$ as follows:
                - If $j \neq i$, $\Lambda_j' := \Lambda_j \cdot (h_i^{m'-m})^{z_j} = \Lambda_j \cdot h_{j,i}^{m'-m}$.
                - If $j = i$, the proof $\Lambda_i$ remains unchanged.

        === "Properties"

            - Security holds by the [CDH assumption](../assumptions.md#cdh) in bilinear groups
            - The scheme is updatable, so the commitment can be updated to reflect an update to one entry of the vector

        === "Further reading"

            - See [the paper](https://eprint.iacr.org/2011/495) for details as well as an additional updatable VC from the [RSA assumption](../assumptions.md#rsa-assumption).
# Commitment schemes

A commitment scheme consists of a commitment algorithm $\sf Com$ and an opening (decommitment) algorithm $\sf Open$. The opening can be checked via an algorithm $\sf Vrfy$.

- ${\sf Com}(m) \to {\sf com}$: Commit to a message $m$ with the commitment $\sf com$.
- ${\sf Open}({\sf com}) \to (m, \pi)$: Open the commitment to a message $m$, with a proof $\pi$ to show correctness of the opening.
- ${\sf Vrfy}({\sf com}, m, \pi) \to \{0,1\}$: Check that the opening is correct.

!!! example "Pedersen commitments"

    === "Scheme"
        **Parameters:** A group $\mathbb{G}$ of prime order $p$ and generators $g,h \in \mathbb{G}$.

        - $\underline{{\sf Com}(m) \to {\sf com}}$: output ${\sf com} = g^m h^r$ where $r \gets^\$ \mathbb{Z}_q$.
        - $\underline{{\sf Open}({\sf com}) \to (m, r)}$: Output $m$ and the randomness $r$ that was used to compute $\sf com$. 
        - $\underline{{\sf Vrfy}({\sf com}, m, r) \to \{0,1\}}$: The verifier checks that ${\sf com} = g^m h^r$.

    === "Properties"
        - unconditional hiding
        - computational binding (by DLog assumption)

## Properties

**Hiding** { #hiding }
: Seeing $\sf com$ should reveal no information about $m$.

**Binding** { #binding }
: It should be infeasible to open $\sf com$ to a different message $m' \neq m$ (i.e., find some other opening $(m', \pi') \neq (m, \pi)$ so that ${\sf Vrfy}({\sf com}, m', \pi') = 1$).

!!! info "Hiding vs. binding tradeoff"
    There is an inherent tradeoff between the strength of the hiding and binding properties of a scheme: if a scheme is [perfectly](../general.md#perfect-security) [hiding](#hiding), it can be only [computationally](../general.md#computational) [binding](#binding); and vice versa.

## Types of commitments

Besides the basic commitment functionality, there are additional "fancier" types of commitment schemes.

**Polynomial commitment** { #poly-com }
: Allows one to commit to a polynomial $f(X)$ and later open it at individual points, e.g., reveal $f(b)$.

    !!! example "KZG polynomial commitment [[KZG10]](https://www.iacr.org/archive/asiacrypt2010/6477178/6477178.pdf)"

        === "Scheme (multiplicative notation)"
            **Parameters:** Let $\mathbb{G}$ be an [elliptic curve group](../Areas-of-Cryptography/ecc.md) of prime order $p$ with generator $g$ and $d$ be the degree of the polynomial to commit to. Furthermore, let $e: \mathbb{G} \times \mathbb{G} \mapsto \mathbb{G}_T$ be a [bilinear pairing](../Areas-of-Cryptography/ecc.md#pairing).

            - $\underline{{\sf Setup}({\sf params}) \to {\sf crs}}$: Using the parameters, compute ${\sf crs} = \{{\sf crs}_0, {\sf crs}_1, {\sf crs}_2, \dots, {\sf crs}_d\} =$ $\{g, g^{\tau}, g^{\tau^2}, \dots, g^{\tau^d}\}$, where $\tau \stackrel{\$}{\gets} \mathbb{Z}_p$.
            - $\underline{{\sf Com}({\sf crs}, f(X)) \to {\sf com}}$: The commitment to the polynomial $f(X) = f_0 + f_1 X + \dots + f_d X^d$ is $g^{f(\tau)}$, which can be computed from the $\sf crs$ as 

                $$C_f = {\sf crs}_0^{f_0} \cdot {\sf crs}_1^{f_1} \cdots {\sf crs}_d^{f_d}$$

                $$= g^{f_0} \cdot g^{f_1 \tau} \cdots g^{f_d \tau^d} = g^{f(\tau)}.$$

                Output ${\sf com} := C_f$.

            - $\underline{{\sf Open}({\sf crs}, {\sf com}, b) \to (c, \pi)}$: to prove that the commitment $C_f$ to $f$ opens to $c$ at $b$, i.e. that $f(b) = c$, compute $C_q \gets {\sf Com}({\sf crs}, q(X))$, where 

                $$ q(X) = \frac{f(X) - f(b)}{X - b} = \frac{f(X) - c}{X - b} $$
            
                (this is a polynomial by [Little Bézout's Theorem](https://en.wikipedia.org/wiki/Polynomial_remainder_theorem)). Set $\pi := C_q$. 
                
            - $\underline{{\sf Vrfy}({\sf crs}, {\sf com}, (b, c), \pi)}$: Remember ${\sf com} = C_f$ and $\pi = C_q$. The verifier checks that 
            
                $$e(C_q, g^{\tau} / g^b) = e(C_f / g^c, g)$$ 
                
                (where $g^{\tau} = {\sf crs}_1$).

        === "Scheme (additive notation)"
            **Parameters:** Let $\mathbb{G}$ be an [elliptic curve group](../Areas-of-Cryptography/ecc.md) of prime order $p$ with generator $G$ and $d$ be the degree of the polynomial to commit to. Furthermore, let $e: \mathbb{G} \times \mathbb{G} \mapsto \mathbb{G}_T$ be a [bilinear pairing](../Areas-of-Cryptography/ecc.md#pairing).

            - $\underline{{\sf Setup}({\sf params}) \to {\sf crs}}$: Using the parameters, compute ${\sf crs} = \{{\sf crs}_0, {\sf crs}_1, {\sf crs}_2, \dots, {\sf crs}_d\} =$ $\{g, g^{\tau}, g^{\tau^2}, \dots, g^{\tau^d}\}$, where $\tau \stackrel{\$}{\gets} \mathbb{Z}_p$.
            - $\underline{{\sf Com}({\sf crs}, f(X)) \to {\sf com}}$: The commitment to the polynomial $f(X) = f_0 + f_1 X + \dots + f_d X^d$ is $f(\tau) \cdot G$, which can be computed from the $\sf crs$ as 

                $$C_f = f_0 {\sf crs}_0 + f_1 {\sf crs}_1 + \dots + f_d {\sf crs}_d$$

                $$= f_0 G + f_1 \tau G + \dots f_d \tau^d G = f(\tau) \cdot G.$$

                Output ${\sf com} := C_f$.

            - $\underline{{\sf Open}({\sf crs}, {\sf com}, b) \to (c, \pi)}$: to prove that the commitment $C_f$ to $f$ opens to $c$ at $b$, i.e. that $f(b) = c$, compute $C_q \gets {\sf Com}({\sf crs}, q(X))$, where 

                $$ q(X) = \frac{f(X) - f(b)}{X - b} = \frac{f(X) - c}{X - b} $$
            
                (this is a polynomial by [Little Bézout's Theorem](https://en.wikipedia.org/wiki/Polynomial_remainder_theorem)). Set $\pi := C_q$. 
                
            - $\underline{{\sf Vrfy}({\sf crs}, {\sf com}, (b, c), \pi)}$: Remember ${\sf com} = C_f$ and $\pi = C_q$. The verifier checks that 
            
                $$e(C_q, \tau G - bG) = e(C_f - cG, G)$$ 
                
                (where $\tau G = {\sf crs}_1$).

        === "Properties"
            - The prover can do a **full open** and reveal all the evaluations by simply sending a candidate polynomial $f'(X)$; the verifier checks that ${\sf Com}({\sf crs}, f'(X)) = {\sf com}$. There is an [optimization [FK20]](https://alinush.github.io/2021/06/17/Feist-Khovratovich-technique-for-computing-KZG-proofs-fast.html) to do this in $O(d\log{d})$ instead of $O(d^2)$.
            - There is also a **batch mode** in which the prover can open $t < d$ points, which the verifier can check with a single pairing. See "Further reading".
            - **Trusted setup**: the scheme relies on a trusted setup, i.e. a well-formed CRS. (On the plus side, the CRS is of the "powers-of-tau" variant, which is fairly easy to generate via an [MPC](../Areas-of-Cryptography/mpc.md) protocol (e.g., [2022/1592](https://eprint.iacr.org/2022/1592)).)

        === "Further reading"
            For a more detailed description of the scheme, see [https://risencrypto.github.io/Kate/](https://risencrypto.github.io/Kate/).

**Vector commitment** { #vc }
: A vector commitment allows one to commit to a vector $\vec{v} = (v_1, \dots, v_n)$ and later individually open elements $v_i$. (Note that a [polynomial commitment](#poly-com) to a polynomial of degree $d$ can be thought of as a vector commitment to $d+1$ points.)
    
    !!! example "Libert-Yung VC [[LY10]](https://www.iacr.org/archive/tcc2010/59780496/59780496.pdf)"

        === "Construction"
            This is a modified version of the original Libert-Yung VC, which was "mercurial", meaning it allowed both "hard" (normal) and "soft" (open _to any message_ a commitment originally made to "no message") openings.

            **Parameters:** Let $\mathbb{G},\mathbb{G}_T$ be bilinear groups of prime order $p$ and $e: \mathbb{G} \times \mathbb{G} \rightarrow \mathbb{G}_T$ be a bilinear pairing. Let $g \in \mathbb{G}$ be a random generator.

            - $\underline{{\sf Setup}(1^\lambda, q) \to {\sf crs}}$: To set up a VC for vectors of length at most $q$, sample (a trapdoor) $z \stackrel{\$}{\gets} \mathbb{Z}_p^*$ and compute $h_i := g^{z^i}$ for $i \in [2q] \setminus \{q+1\}$. Output ${\sf crs} := (h_1, \dots, h_q, h_{q+2}, \dots, h_{2q})$.

            - $\underline{{\sf Com}({\sf crs}, \vec{v}) \to {\sf com}}$: To commit to $\vec{v} = (m_1, \ldots, m_q)$, compute
            
                $$C := h_1^{m_1} h_2^{m_2} \dots h_q^{m_q}$$
            
                and output $C$ as the commitment.

            - $\underline{{\sf Open}({\sf crs}, {\sf com}, i) \to (m_i, \Lambda_i)}$: Compute $\Lambda_i := \prod_{j=1,j \neq i}^{q} g_{q+1-j+i}^{m_j}$.

            - $\underline{{\sf Vrfy}({\sf crs}, {\sf com}, (i, m_i), \Lambda_i) \to \{0,1\}}$: Given an opening $(i, m_i)$ for the commitment $\sf com$ and an opening proof $\Lambda_i$, a party can verify the correctness of the opening by checking that 
            
                $$e({\sf com}, h_{q+1-i}) = e(\Lambda_i, g) \cdot e(h_i^{m_i}, h_{q+1-i}).$$

        <!-- === "Properties" -->

        <!-- === "Further reading"  -->

    !!! example "(Updatable) VC from CDH [[CF13]](https://eprint.iacr.org/2011/495)"

        === "Construction"
            **Parameters:** Let $\mathbb{G},\mathbb{G}_T$ be bilinear groups of prime order $p$ and $e: \mathbb{G} \times \mathbb{G} \rightarrow \mathbb{G}_T$ be a bilinear pairing. Let $g \in \mathbb{G}$ be a random generator.

            - $\underline{{\sf Setup}(1^\lambda, q) \to {\sf pp}}$: To set up a VC for vectors of length at most $q$, sample (trapdoors) $z_1, \ldots, z_q \stackrel{\$}{\gets} \mathbb{Z}_p$. Compute $h_i := g^{z_i}$ and $h_{i,j} = g^{z_i z_j}$ for $i,j = 1, \ldots, q$ with $j \neq i$. Output ${\sf pp} := (g, \{h_i\}_{i \in [q]}, \{h_{i,j}\}_{i,j \in [q], i \neq j})$.

            - $\underline{{\sf Com}({\sf pp}, \vec{v}) \to {\sf com}}$: To commit to $\vec{v} = (m_1, \ldots, m_q)$, compute

                $$C := h_1^{m_1} h_2^{m_2} \dots h_q^{m_q}$$

                (same as Libert-Yung VC) and output $C$ as the commitment.

            - $\underline{{\sf Open}({\sf pp}, {\sf com}, i) \to (m_i, \Lambda_i)}$: Compute $\Lambda_i := \prod_{j=1,j\neq i}^{q} h_{i,j}^{m_j} = \prod_{j=1,j\neq i}^{q} \left( h_j^{m_j} \right)^{z_i}$.

            - $\underline{{\sf Vrfy}({\sf pp}, {\sf com}, (i, m_i), \Lambda_i) \to \{0,1\}}$: Given an opening $(i, m_i)$ for the commitment $\sf com$ and an opening proof $\Lambda_i$, a party can verify the correctness of the opening by checking that 
            
                $$e({\sf com}/h_i^{m_i}, h_i) = e(\Lambda_i, g).$$

            ---

            - $\underline{{\sf Update}({\sf pp}, {\sf com}, i, m, m') \to {\sf com}'}$: To update the $i$th entry $m$ to $m'$, compute an updated commitment ${\sf com}' := {\sf com} \cdot h_i^{m'-m}$.

            - $\underline{{\sf PfUpdate}({\sf pp}, {\sf com}, (i, m, m'), \Lambda_j) \to \Lambda_j'}$: A proof for the opening of position $j$ which was valid w.r.t. $\sf com$ can be updated for $\sf com'$ as follows:
                - If $j \neq i$, set $\Lambda_j' := \Lambda_j \cdot (h_i^{m'-m})^{z_j} = \Lambda_j \cdot h_{j,i}^{m'-m}$.
                - If $j = i$, the proof $\Lambda_i$ remains unchanged.

        === "Properties"

            - **Security** holds by the [CDH assumption](../assumptions.md#cdh) in bilinear groups
            - The scheme is **updatable**, so the commitment can be updated to reflect an update to one entry of the vector

        === "Further reading"

            - See [the paper](https://eprint.iacr.org/2011/495) for details as well as an additional updatable VC from the [RSA assumption](../assumptions.md#rsa-assumption).

**Functional commitment** { #func-com }
: 
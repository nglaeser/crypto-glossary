# Assumptions

This page lists common hardness assumptions upon which cryptographic schemes have been based. These range from standard (widely used and believed to hold) to newer assumptions (recently introduced and less well-tested).

<!-- Maybe color-code based on how standard they are? -->
<!-- Also give any implications -->

Computing the requested answer in each of these cases is believed to be hard. Since the assumptions useful in cryptography are largely _computational_ assumptions, "hard to compute" means computationally intractable (typically in polynomial time).

See also [Wikipedia](https://en.wikipedia.org/wiki/Computational_hardness_assumption#Common_cryptographic_hardness_assumptions) for a list of cryptographic hardness assumptions. Assumptions marked with "*" are thought to be [post-quantum secure](Areas-of-Cryptography/pqc.md).

## Types of Assumptions

**Subexponential assumptions**
: Instead of assuming hardness against any adversary running in polynomial time, we make the (stronger) assumption that the problem remains hard even against adversaries running in any _subexponential_ time (so we give the adversary more computational power).

**Average-case hardness**
: When a randomly selected instance of the problem is hard to solve.

**Worst-case hardness**
: When a randomly selected instance of the problem is not necessarily hard to solve, but rather only a carefully crafted "worst case" instance.

**Decisional vs. Computational (aka Search)**
: A decisional problem is of the form "given an input z of the form X or Y, decide whether X or Y was given". A computational problem is of the form "given some input, compute an output meeting some condition". (See the DDH and CDH assumptions below for an example.) In general, solving the computational variant of a problem implies solving the decisional variant; equivalently, the decisional variant is stronger: in general, decisional hardness &rArr; computational hardness.

## Assumptions

### **Discrete logarithm**

**Discrete Logarithm Problem (DLog/DLP/DL)**
:   === "Assumption"

        Let G be a group.  
        &emsp;**Given**: $a,b \in G$  
        &emsp;**Compute**: k such that $b^k=a$

    === "Applications"

        * Digital Signature Algorithm (DSA)
        * Schnorr signatures

### Diffie–Hellman (DH) assumptions

<!-- When must $g$ (or $G$) be uniformly chosen? -->

**Computational Diffie–Hellman (CDH)**
:   === "Assumption"

        Let $G$ be a cyclic group of order $q$. Choose a random generator $g$ and let $a,b$ be uniform and independent integers in ${0, ..., q-1}$:  
        &emsp;**Given**: $(g, g^a, g^b)$  
        &emsp;**Compute**: $g^{ab}$

    === "Applications"
    
        * Diffie–Hellman Key Exchange

**Computational co-Diffie–Hellman (co-CDH)** _(Variant of CDH)_
:   === "Assumption"
    
        Let $G_1$ and $G_2$ be cyclic groups.  
        &emsp;**Given**: $(g,g^a,h)$ where $g,g^a \in G_1$ and $h \in G_2$  
        &emsp;**Compute**: $h^a \in G_2$

**Decisional Diffie-Hellman (DDH)**
:   !!! warning
        Importantly, the DDH assumption is believed to hold only in [certain groups](https://en.wikipedia.org/wiki/Decisional_Diffie%E2%80%93Hellman_assumption#Groups_for_which_DDH_is_assumed_to_hold).

    === "Assumption"

        Let $G$ be a cyclic group of order $q$ with generator $g$. Let $a,b,c$ be uniform and independent integers in ${0, ..., q-1}$:  
        &emsp;**Given**: $(g,g^a,g^b,g^{ab})$[^1] or $(g,g^a,g^b,g^c)$  
        &emsp;**Output**: A decision about which type of tuple was given
    
        [^1]: This type of tuple is often called a "DDH tuple" (or a "DDH triple" if the generator is left out).

    === "Applications"

        - ElGamal
        - Cramer–Shoup cryptosystems

**Gap Diffie-Hellman (GDH)**
:   === "Assumption"

        Let G be a group in which the DDH problem is easy but the CDH problem is hard (gap group). The assumption is that CDH is still hard in these groups.
    
    === "Applications"

        - BLS digital signature

**External Diffie–Hellman (XDH)** (or **asymmetric XDH**)
:   === "Assumption"

        Assumes the existence of elliptic-curve subgroups $(G_1, G_2)$ such that

        1. DLog, CDH, and co-CDH are hard in both groups  
        1. DDH is hard in $G_1$  
        1. There is an efficiently computable bilinear map $e(\cdot, \cdot): G_1 \times G_2 \mapsto G_T$. 

    === "Applications"

        - [Elliptic-curve cryptography (ECC)](./Areas-of-Cryptography/ecc.md), specifically type-2 pairings

**Symmetric External Diffie–Hellman (SXDH)**
:   === "Assumption"

        The same as XDH, but additionally assumes in (2) that DDH is also hard in $G_2$. 

:   === "Applications"

        - [Elliptic-curve cryptography (ECC)](./Areas-of-Cryptography/ecc.md), specifically type-3 pairings
<!-- Implies XDH. -->

### Factoring

**RSA Assumption**
:   === "Assumption"

        This assumption corresponds exactly to finding the plaintext ($y$) of an RSA ciphertext ($x$) given only the public key $(n,e)$. Let $n=pq$ for two large primes $p,q$ and $2 < e < n$ (equivalently, $\gcd(e,n)=1$).

        &emsp;**Given**: $e,x,n$  
        &emsp;**Compute**: $y$ such that $y^e = x \pmod{n}$

    === "Applications"

        * RSA encryption

**Hardness of factoring large numbers**
:   === "Assumption"

        Given a "sufficiently large" composite number, there is no efficient algorithm for decomposing it into a product of smaller integers. (The hardest instances of this problem are of the form $n=pq$ for large random primes $p,q$ of similar magnitude.)

    === "Applications"

        * RSA encryption

### Lattice Assumptions

\***Learning With Errors (LWE)**
:   === "Assumption (computational)"

        Let $\mathbf{A}$ be a $m \times n$ matrix of (uniformly random) integers modulo $q$ and $\vec{e},\vec{s}$ be vectors of length $m$, where $\vec{e}$ is sampled according to some error distribution $\chi$ and $\vec{s}$ consists of uniform integers modulo $q$.  

        That is, $\mathbf{A} \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q^{m \times n}$, $\vec{s} \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q^m$, $\vec{e} \gets\!\!\tiny{\$}\normalsize\ \chi$.

        &emsp;**Given**: $\mathbf{A},\vec{b} := \mathbf{A} \cdot \vec{s} + \vec{e}$  
        &emsp;**Compute**: $\vec{s} \in \mathbb{Z}_q^n$ such that $\mathbf{A}\cdot \vec{s} + \vec{e} = \vec{b} \pmod{q}$

        <!-- Drawing of dimensions -->

    === "Assumption (decisional)"

        Let $\mathbf{A},\vec{s},\vec{e},\vec{b}$ be initialized as in the computational assumption.

        &emsp;**Given**: Either $(\mathbf{A},\vec{b})$ or $(\mathbf{A},\vec{u})$, where $\vec{u} \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q^m$  
        &emsp;**Decide**: Whether the given tuple was of the form $(\mathbf{A},\vec{b}:=\mathbf{A}\cdot \vec{s} + \vec{e})$ or $(\mathbf{A},\vec{u})$.

    === "Applications"

        * NIZK
        * Public-key encryption

\***Short Integer Solution (SIS)**
:   === "Assumption"

        The problem is parameterized by a "small" scalar $\beta$ (some discussion of bounds on $\beta$ can be found [here](https://en.wikipedia.org/wiki/Short_integer_solution_problem#SISn,m,q,%CE%B2)).

        &emsp;**Given**: $\mathbf{A} \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q^{n \times m}$  
        &emsp;**Compute**: $\vec{x} \in \mathbb{Z}_q^m$ such that $\lVert \vec{x} \rVert < \beta$ and $\mathbf{A} \cdot \vec{x} = \vec{0}$

    === "Applications"

        * Trapdoor functions (TDF) (and therefore signatures)

\***Shortest Vector Problem (SVP)**
: 

### Other

\***Learning Parity with Noise (LPN)**
: There are a few (equivalent) ways to phrase this assumption; two are given below.  
    === "Assumption (version 1)"

        Fix a secret $n$-bit string $k \in \{0,1\}^n$. Let $\mathcal{O}_{k,\epsilon}$ be an oracle that outputs independent samples $(x_i,y_i)$, where $x_i$ is a random $n$-bit string and $y_i := \langle x_i \mid k \rangle \oplus e_i$, where the bit $e_i$ is 1 with probability $\epsilon$ and 0 otherwise and $\langle \cdot \mid \cdot \rangle$ means inner product.  
        &emsp;**Given**: $q$ samples $(x_i,y_i)$ from $\mathcal{O}_{k,\epsilon}$  
        &emsp;**Compute**: $k$ (such that $y_i = \langle x_i \mid k \rangle \oplus e_i$ for all $(x_i,y_i), i=1\ldots q$)

    === "Assumption (version 2)"

        Let $\mathbf{A}$ be a $q \times n$ matrix of (uniformly random) bits and $\vec{e},\vec{y}$ be $q$-bit vectors (where $e_i = 1$ with probability $\epsilon$ and 0 otherwise).  
        &emsp;**Given**: $\mathbf{A},\vec{y}$  
        &emsp;**Compute**: $\vec{k} \in \{0,1\}^n$ such that $\mathbf{A}\cdot \vec{k} + \vec{e} = \vec{y} \pmod{2}$

    === "Applications"

        - PRGs
        - Perfectly binding commitment
        - PAKE

**One-way functions**
: 
    === "Assumption"

    === "Applications"

        - One-time signatures

<!-- [Version 1](https://perso.uclouvain.be/fstandae/PUBLIS/182.pdf) -->
<!-- [Version 2 and applications](http://yuyu.hk/files/LPN.pdf) -->
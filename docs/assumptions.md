# Assumptions

This page lists common hardness assumptions upon which cryptographic schemes have been based. These range from standard (widely used and believed to hold) to newer assumptions (recently introduced and less well-tested).

<!-- Maybe color-code based on how standard they are? -->
<!-- Also give any implications -->

Computing the requested answer in each of these cases is believed to be hard. Since the assumptions useful in cryptography are largely _computational_ assumptions, "hard to compute" means computationally intractable (typically in polynomial time).

See also [Wikipedia](https://en.wikipedia.org/wiki/Computational_hardness_assumption#Common_cryptographic_hardness_assumptions) for a list of cryptographic hardness assumptions.

**Subexponential assumptions**
: 

## **Discrete logarithm**

**Discrete Logarithm Problem (DLog/DLP/DL)**
:   === "Assumption"

        Let G be a group.  
        &emsp;**Given**: $a,b \in G$  
        &emsp;**Compute**: k such that $b^k=a$

    === "Applications"

        * Digital Signature Algorithm (DSA)
        * Schnorr signatures

## Diffie–Hellman (DH) assumptions

**Computational Diffie–Hellman (CDH)**
:   === "Assumption"

        Let $G$ be a cyclic group of order $q$ with generator $g$. Let $a,b$ be uniform and independent integers in ${0, ..., q-1}$:  
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
        &emsp;**Given**: $(g,g^a,g^b,g^{ab})$ or $(g,g^a,g^b,g^c)$  
        &emsp;**Output**: A decision about which type of tuple was given
    
        *[Given]: The first type of tuple is often called a "DDH tuple" (or a "DDH triple" if the generator is left out).

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

        - Elliptic-curve cryptography (ECC)

**Symmetric External Diffie–Hellman (SXDH)**
:   === "Assumption"

        The same as XDH, but additionally assumes in (2) that DDH is also hard in $G_2$. 
<!-- Implies XDH. -->

## Factoring

**RSA Assumption**
: 

## Lattice Assumptions

**Learning With Errors (LWE)**
: 

**Short Integer Solution (SIS)**
: 

**Shortest Vector Problem (SVP)**
: 
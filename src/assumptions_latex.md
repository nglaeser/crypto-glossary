# Assumptions

This page lists common hardness assumptions upon which cryptographic schemes have been based. These range from standard (widely used and believed to hold) to newer assumptions (recently introduced and less well-tested).

<!-- Maybe color-code based on how standard they are? -->
<!-- Also give any implications -->

Computing the requested answer in each of these cases is believed to be hard. Since the assumptions useful in cryptography are largely _computational_ assumptions, "hard to compute" means computationally intractable (typically in polynomial time).

See also [Wikipedia](https://en.wikipedia.org/wiki/Computational_hardness_assumption#Common_cryptographic_hardness_assumptions) for a list of cryptographic hardness assumptions.

### **Discrete logarithm problem (DLog/DLP/DL)**
> Let G be a group.
>
> &emsp;**Given**: a,b &in; G  <br/>
> &emsp;**Compute**: k such that $b^k=a$
> 
> Used in
> - Digital Signature Algorithm (DSA)
> - Schnorr signatures

## Diffie–Hellman (DH) assumptions

### **Computational Diffie–Hellman (CDH)**
> Let G be a cyclic group of order q with generator g. Let a,b be uniform and independent integers in {0, ..., q-1}:
>
> &emsp;**Given**: $(g, g^a, g^b)$  <br/>
> &emsp;**Compute**: $g^{ab}$
>
> Used in
> - Diffie–Hellman Key Exchange

### **Computational co-Diffie–Hellman (co-CDH)** _(Variant of CDH)_
> Let $G_1$ and $G_2$ be cyclic groups.
>
> &emsp;**Given**: $(g,g^a,h)$ where $g,g^a \in G_1$ and $h \in G_2$  <br/>
> &emsp;**Compute**: $h^a \in G_2$

### **Decisional Diffie-Hellman (DDH)**
> Let G be a cyclic group of order q with generator g. Let a,b,c be uniform and independent integers in {0, ..., q-1}:
> 
> &emsp;**Given**: $(g,g^a,g^b,g^{ab})$* or $(g,g^a,g^b,g^c)$  <br/>
> &emsp;**Output**: A decision about which type of tuple was given
> 
> Used in
> - ElGamal
> - Cramer–Shoup cryptosystems

<br/>

*This type of tuple is often called a **DDH tuple** (or a **DDH triple** if the generator is left out).

Importantly, the DDH assumption is believed to hold only in [certain groups](https://en.wikipedia.org/wiki/Decisional_Diffie%E2%80%93Hellman_assumption#Groups_for_which_DDH_is_assumed_to_hold).

### **Gap Diffie-Hellman (GDH)**
> Let G be a group in which the DDH problem is easy but the CDH problem is hard (gap group). (The assumption is that CDH is still hard in these groups.)
> 
> Used in
> - BLS digital signature

### **External Diffie–Hellman (XDH)** (or **asymmetric XDH**)
> Assumes the existence of elliptic-curve subgroups $(G_1, G_2)$ such that
> 1. DLog, CDH, and co-CDH are hard in both groups
> 1. DDH is hard in $G_1$
> 1. There is an efficiently computable bilinear map $e(\cdot, \cdot): G_1 \times G_2 \mapsto G_T$. <br/>
>
> <p>Used in</p>
> <li>Elliptic-curve cryptography (ECC)</li>

### **Symmetric External Diffie–Hellman (SXDH)**
> The same as XDH, but additionally assumes DDH is also hard in $G_2$. 
<!-- Implies XDH. -->

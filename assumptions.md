# Assumptions

This page lists common hardness assumptions upon which cryptographic schemes have been based. These range from standard (widely used and believed to hold) to newer assumptions (recently introduced and less well-tested).

<!-- Maybe color-code based on how standard they are? -->
<!-- Also give any implications -->

Computing the requested answer in each of these cases is believed to be hard. Since the assumptions useful in cryptography are largely _computational_ assumptions, "hard to compute" means computationally intractable (typically in polynomial time).

See also [Wikipedia](https://en.wikipedia.org/wiki/Computational_hardness_assumption#Common_cryptographic_hardness_assumptions) for a list of cryptographic hardness assumptions.

### **Discrete logarithm problem (DLog/DLP/DL)**

> Let G be a group.
>
>  **Given**: a,b ∈ G  <br/>
>  **Compute**: k such that <img alt="b^k=a" src="https://render.githubusercontent.com/render/math?math=b%5Ek%3Da" style="transform: translateY(20%);" />
>
> Used in
> * Digital Signature Algorithm (DSA)
> * Schnorr signatures
## Diffie–Hellman (DH) assumptions

### **Computational Diffie–Hellman (CDH)**

> Let G be a cyclic group of order q with generator g. Let a,b be uniform and independent integers in {0, ..., q-1}:
>
>  **Given**: <img alt="(g, g^a, g^b)" src="https://render.githubusercontent.com/render/math?math=%28g%2C%20g%5Ea%2C%20g%5Eb%29" style="transform: translateY(20%);" />  <br/>
>  **Compute**: <img alt="g^{ab}" src="https://render.githubusercontent.com/render/math?math=g%5E%7Bab%7D" style="transform: translateY(20%);" />
>
> Used in
> * Diffie–Hellman Key Exchange
### **Computational co-Diffie–Hellman (co-CDH)** _(Variant of CDH)_

> Let <img alt="G_1" src="https://render.githubusercontent.com/render/math?math=G_1" style="transform: translateY(20%);" /> and <img alt="G_2" src="https://render.githubusercontent.com/render/math?math=G_2" style="transform: translateY(20%);" /> be cyclic groups.
>
>  **Given**: <img alt="(g,g^a,h)" src="https://render.githubusercontent.com/render/math?math=%28g%2Cg%5Ea%2Ch%29" style="transform: translateY(20%);" /> where <img alt="g,g^a \in G_1" src="https://render.githubusercontent.com/render/math?math=g%2Cg%5Ea%20%5Cin%20G_1" style="transform: translateY(20%);" /> and <img alt="h \in G_2" src="https://render.githubusercontent.com/render/math?math=h%20%5Cin%20G_2" style="transform: translateY(20%);" />  <br/>
>  **Compute**: <img alt="h^a \in G_2" src="https://render.githubusercontent.com/render/math?math=h%5Ea%20%5Cin%20G_2" style="transform: translateY(20%);" />

### **Decisional Diffie-Hellman (DDH)**

> Let G be a cyclic group of order q with generator g. Let a,b,c be uniform and independent integers in {0, ..., q-1}:
>
>  **Given**: <img alt="(g,g^a,g^b,g^{ab})" src="https://render.githubusercontent.com/render/math?math=%28g%2Cg%5Ea%2Cg%5Eb%2Cg%5E%7Bab%7D%29" style="transform: translateY(20%);" />* or <img alt="(g,g^a,g^b,g^c)" src="https://render.githubusercontent.com/render/math?math=%28g%2Cg%5Ea%2Cg%5Eb%2Cg%5Ec%29" style="transform: translateY(20%);" /> **Output**: A decision about which type of tuple was given
>
> Used in
> * ElGamal
> * Cramer–Shoup cryptosystems
<br/>
*This type of tuple is often called a **DDH tuple** (or a **DDH triple** if the generator is left out).

Importantly, the DDH assumption is believed to hold only in [certain groups](https://en.wikipedia.org/wiki/Decisional_Diffie%E2%80%93Hellman_assumption#Groups_for_which_DDH_is_assumed_to_hold).

### **Gap Diffie-Hellman (GDH)**

> Let G be a group in which the DDH problem is easy but the CDH problem is hard (gap group). (The assumption is that CDH is still hard in these groups.)
>
> Used in
> * BLS digital signature
### **External Diffie–Hellman (XDH)** (or **asymmetric XDH**)

> Assumes the existence of elliptic-curve subgroups <img alt="(G_1, G_2)" src="https://render.githubusercontent.com/render/math?math=%28G_1%2C%20G_2%29" style="transform: translateY(20%);" /> such that
> 1. DLog, CDH, and co-CDH are hard in both groups
> 2. DDH is hard in <img alt="G_1" src="https://render.githubusercontent.com/render/math?math=G_1" style="transform: translateY(20%);" />
> 3. There is an efficiently computable bilinear map <img alt="e(\cdot, \cdot): G_1 \times G_2 \mapsto G_T" src="https://render.githubusercontent.com/render/math?math=e%28%5Ccdot%2C%20%5Ccdot%29%3A%20G_1%20%5Ctimes%20G_2%20%5Cmapsto%20G_T" style="transform: translateY(20%);" />. <br/>
> Used in
> * Elliptic-curve cryptography (ECC)
### **Symmetric External Diffie–Hellman (SXDH)**

> The same as XDH, but additionally assumes DDH is also hard in <img alt="G_2" src="https://render.githubusercontent.com/render/math?math=G_2" style="transform: translateY(20%);" />.
> <!-- Implies XDH. -->


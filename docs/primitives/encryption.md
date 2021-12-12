# Encryption

## Types of Schemes
### Asymmetric (public-key) encryption
One key (the recipient's public key) is used for encryption, while another key (the corresponding secret key) is used for decryption. The private and public keys form a key pair.  

Schemes: 

!!! info "ElGamal encryption"

    === "Scheme"
        For a cyclic group $G$ of order $q$ with generator $g$, the secret key is $x$, a uniformly chosen element of $G$; the public key is $(G, q, g, h:=g^x)$.

        - $Enc(m \in G)$: choose a uniform element $y \in G$; return $(c_1 := g^y, c_2 := m h^y = m g^{xy})$  
        - $Dec(c_1,c_2)$: let $s := c_1^x = g^{xy} = h^y$ and compute $s^{-1}$. Then $m$ is recovered as $c_2 s^{-1} = (m h^y) (h^y)^{-1} = m$.  

    === "Properties"
        - CPA-secure (by DDH assumption)
        - unconditionally malleable

!!! info "RSA encryption"

!!! info "Paillier encryption"

### Symmetric (secret-key) encryption
The same key is used for both decryption and encryption. This means the sender and recipient must somehow securely agree on a secret key; this is usually achieved either via _key agreement_ protocols or by encrypting the symmetric key using public-key encryption.  

Schemes:

!!! info "Advanced Encryption Standard (AES)"

!!! info "One-time Pad"

### Other

**Attribute-based encryption (ABE)**
: Policy-based access to encrypted data (general case of identity-based encryption (IBE)). The policy is public. A trusted third-party distributes keys to parties that meet the policy.

**Functional encryption (FE)**
: An encryption scheme in which it is possible to issue "function keys", e.g. a key $k_f$ that decrypts the ciphertext into a function $f(m)$ of the plaintext $m$.

**Identity-based encryption (IBE)**
: 
**Hierarchical IBE (HIBE)**
: 

**Registration-based encryption (RBE)**
:

**Rerandomizable encryption**
:  

**Structured encryption**
:  

**Witness encryption (WE)**
:
**Extractable witness encryption (EWE)**
:

## Security Notions

**Circular security**
: Usually, our security definitions say nothing about what happens when we encrypt _the secret key itself_ with the encryption scheme. If a scheme is circular secure, it is secure even when the message is (a function of) the secret key. This is also called **key-dependent message (KDM) security**.

**CPA security**
: Secure against chosen plaintext attacks (CPA). Again, this is indistinguishability-based, so the more specific name is IND-CPA security. This is equivalent to **semantic security** (semantic security &rArr; IND-CPA and IND-CPA &rArr; semantic security, so semantic security &iff; IND-CPA).

!!! info "IND-CPA game"

    1. Challenger: $k \gets Gen(1^n)$
    1. $\mathcal{A}(1^n)$ interacts with $Enc_k(\cdot)$ (in polynomial time)
    1. $\mathcal{A}$ outputs $m_0, m_1$ of same length
    1. Challenger: $b \gets \{0,1\}, c \gets Enc_k(m_b)$, send $c$ to $\mathcal{A}$
    1. $\mathcal{A}$ continues to interact with $Enc_k(\cdot)$ (in polynomial time)
    1. $\mathcal{A}$ outputs $b'$

    $\mathcal{A}$ *wins* if $b=b'$, and the game outputs 1.  

**CCA security**
: Secure against chosen ciphertext attacks (CCA); this is an indistinguishability-based notion, so it is more specifically IND-CCA security. There are two variants of IND-CCA security, and both are stronger than IND-CPA because the adversary is additionally given access to a _decryption_ oracle. "IND-CCA" (without a number) usually refers to IND-CCA2.  <br/>  
**IND-CCA1**
: Non-adaptive (lunchtime) chosen ciphertext attack. Weaker than IND-CCA2. 

!!! info "IND-CCA1 game"

    1. Challenger: $k \gets Gen(1^n)$
    1. $\mathcal{A}(1^n)$ interacts with $Enc_k(\cdot)$ **and $Dec_k(\cdot)$** (in polynomial time)
    1. $\mathcal{A}$ outputs $m_0, m_1$ of same length
    1. Challenger: $b \gets \{0,1\}, c \gets Enc_k(m_b)$, send $c$ to $\mathcal{A}$
    1. $\mathcal{A}$ can perform some operations (in polynomial time) <!-- does it have access to Enc_k(•)? -->
    1. $\mathcal{A}$ outputs $b'$

    $\mathcal{A}$ *wins* if $b=b'$, and the game outputs 1.

**IND-CCA2**
: Adaptive chosen ciphertext attack. In addition to its capabilities in the IND-CCA1 game, A now has access to the oracles _after_ seeing $c$.

!!! info "IND-CCA2 game"

    1. Challenger: $k \gets Gen(1^n)$
    1. $\mathcal{A}(1^n)$ interacts with $Enc_k(\cdot)$ and $Dec_k(\cdot)$ (in polynomial time)
    1. $\mathcal{A}$ outputs $m_0, m_1$ of same length
    1. Challenger: $b \gets \{0,1\}, c \gets Enc_k(m_b)$, send $c$ to $\mathcal{A}$
    1. $\mathcal{A}$ **continues to interact with $Enc_k(\cdot)$ and $Dec_k(\cdot)$** (in polynomial time) but can't query $Dec_k(\cdot)$ on $c$
    1. $\mathcal{A}$ outputs $b'$

    $\mathcal{A}$ *wins* if $b=b'$, and the game outputs 1.
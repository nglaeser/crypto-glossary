[&larr; Back to Glossary](../glossary.md)

# Encryption

## Asymmetric (public-key) encryption
One key (the recipient's public key) is used for encryption, while another key (the corresponding secret key) is used for decryption. The private and public keys for a key pair.  

Schemes: 

**ElGamal encryption**: For a cyclic group $G$ of order $q$ with generator $g$, the secret key is $x$, a uniformly chosen element of $G$; the public key is $(G, q, g, h:=g^x)$.
>  $Enc(m \in G)$: choose a uniform element $y \in G$; return $(c_1 := g^y, c_2 := m h^y = m g^{xy})$  
>  $Dec(c_1,c_2)$: let $s := c_1^x = g^{xy} = h^y$ and compute $s^{-1}$. Then $m$ is recovered as $c_2 s^{-1} = (m h^y) (h^y)^{-1} = m$.  

_Properties_: CPA-secure (by DDH assumption), unconditionally malleable.

**RSA encryption**:

**Paillier encryption**:

## Symmetric (secret-key) encryption
The same key is used for both decryption and encryption. This means the sender and recipient must somehow securely agree on a secret key; this is usually achieved either via _key agreement_ protocols or by encrypting the symmetric key using public-key encryption.  

Schemes:

**Advanced Encryption Standard (AES)**:

**One-time Pad**:

## Other types

**Structured encryption**:  

**Rerandomizable encryption**:  

**Attribute-based encryption (ABE)**: Policy-based access to encrypted data (general case of identity-based encryption (IBE)). The policy is public. A trusted third-party distributes keys to parties that meet the policy.

**Functional encryption (FE)**: An encryption scheme in which it is possible to issue "function keys", e.g. a key $k_f$ that decrypts the ciphertext into a function $f(m)$ of the plaintext $m$.

**Identity-based encryption (IBE)**:

[&larr; Back to Glossary](../glossary.md)

# Encryption

## Asymmetric (public-key) encryption
One key (the recipient's public key) is used for encryption, while another key (the corresponding secret key) is used for decryption. The private and public keys for a key pair.  

Schemes: 

**ElGamal encryption**: For a cyclic group G of order q with generator g, the secret key is _x_, a uniformly chosen element of G; the public key is _(G, q, g, h:=g^x)_.
>  Enc(m &isin; G): choose a uniform element _y &isin; G_; return _(c1 := g^y, c2 := m h^y = m g^(xy))_  
>  Dec(c1,c2): let _s := c1^x = g^(xy) = h^y_ and compute _s^(-1)_. Then _m_ is recovered as _c2 s^(-1) = m h^y (h^y)^(-1) = m_.  

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

**Functional encryption (FE)**: An encryption scheme in which it is possible to issue "function keys", e.g. a key _k_f_ that decrypts the ciphertext into a function _f(m)_ of the plaintext _m_.

**Identity-based encryption (IBE)**:

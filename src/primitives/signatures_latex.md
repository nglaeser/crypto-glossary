[&larr; Back to Glossary](../glossary.md)

# Signatures

**Schnorr signatures**: Based on DLog assumption. Let $G$ be an elliptic curve group with generator $g$ and order $q$.
> $KeyGen(G, g, q)$: choose a uniform element $sk \in Z_q$; set the public key $pk = sk \cdot g$.  
> $Sign(sk, m)$: choose a uniform one-time key $k \in Z_q$; compute a nonce $R = k \cdot g$; the signature is $\sigma = (k - sk \cdot H(R || m ) \mod q), R)$, where $H$ is a hash function.  
> $Verify(m, \sigma = (s,R))$: Check $s \cdot g =^? R - H(R || m) \cdot pk$.
- **Blind Schnorr signatures**:

<br/>

**ECDSA signatures**:

**Threshold signature**: signing/secret key is split into _shares_; producing a signature requires some threshold number of shares.
- a threshold signature should be indistinguishable from an ordinary signature

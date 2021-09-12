# Signatures

**Schnorr signatures**: Based on DLog assumption. Let _G_ be an elliptic curve group with generator _g_ and order _q_.
> KeyGen(G, g, q): choose a uniform element _sk &isin; Zq_; set the public key _pk = sk * g_.  
> Sign(sk, m): choose a uniform one-time key _k &isin; Zq_; compute a nonce _R = k * g_; the signature is _&sigma; = (k - sk * H(R || m ) (mod q), R)_, where _H_ is a hash function.  
> Verify(m, &sigma; = (s,R)): Check _s * g =? R - H(R || m) * pk_.

**ECDSA signatures**:

**Threshold signature**: signing/secret key is split into _shares_; producing a signature requires some threshold number of shares.
- a threshold signature should be indistinguishable from an ordinary signature

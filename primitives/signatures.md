[← Back to Glossary](../glossary.md)

# Signatures

**Schnorr signatures**: Based on DLog assumption. Let <img alt="G" src="https://render.githubusercontent.com/render/math?math=G" style="transform: translateY(20%);" /> be an elliptic curve group with generator <img alt="g" src="https://render.githubusercontent.com/render/math?math=g" style="transform: translateY(20%);" /> and order <img alt="q" src="https://render.githubusercontent.com/render/math?math=q" style="transform: translateY(20%);" />.

> <img alt="KeyGen(G, g, q)" src="https://render.githubusercontent.com/render/math?math=KeyGen%28G%2C%20g%2C%20q%29" style="transform: translateY(20%);" />: choose a uniform element <img alt="sk \in Z_q" src="https://render.githubusercontent.com/render/math?math=sk%20%5Cin%20Z_q" style="transform: translateY(20%);" />; set the public key <img alt="pk = sk \cdot g" src="https://render.githubusercontent.com/render/math?math=pk%20%3D%20sk%20%5Ccdot%20g" style="transform: translateY(20%);" />.<img alt="Sign(sk, m)" src="https://render.githubusercontent.com/render/math?math=Sign%28sk%2C%20m%29" style="transform: translateY(20%);" />: choose a uniform one-time key <img alt="k \in Z_q" src="https://render.githubusercontent.com/render/math?math=k%20%5Cin%20Z_q" style="transform: translateY(20%);" />; compute a nonce <img alt="R = k \cdot g" src="https://render.githubusercontent.com/render/math?math=R%20%3D%20k%20%5Ccdot%20g" style="transform: translateY(20%);" />; the signature is <img alt="\sigma = (k - sk \cdot H(R || m ) \mod q), R)" src="https://render.githubusercontent.com/render/math?math=%5Csigma%20%3D%20%28k%20-%20sk%20%5Ccdot%20H%28R%20%7C%7C%20m%20%29%20%5Cmod%20q%29%2C%20R%29" style="transform: translateY(20%);" />, where <img alt="H" src="https://render.githubusercontent.com/render/math?math=H" style="transform: translateY(20%);" /> is a hash function.<img alt="Verify(m, \sigma = (s,R))" src="https://render.githubusercontent.com/render/math?math=Verify%28m%2C%20%5Csigma%20%3D%20%28s%2CR%29%29" style="transform: translateY(20%);" />: Check <img alt="s \cdot g =^? R - H(R || m) \cdot pk" src="https://render.githubusercontent.com/render/math?math=s%20%5Ccdot%20g%20%3D%5E%3F%20R%20-%20H%28R%20%7C%7C%20m%29%20%5Ccdot%20pk" style="transform: translateY(20%);" />.

**ECDSA signatures**:

**Threshold signature**: signing/secret key is split into _shares_; producing a signature requires some threshold number of shares.
* a threshold signature should be indistinguishable from an ordinary signature


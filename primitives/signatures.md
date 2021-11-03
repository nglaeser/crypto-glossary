[← Back to Glossary](../glossary.md)

# Signatures

It is known that OWFs imply signatures.
<!-- Give construction -->

## Schemes

**CL signatures**:

**ECDSA signatures**:

**Schnorr signatures**: Based on DLog assumption. Let <img alt="G" src="https://render.githubusercontent.com/render/math?math=G" style="transform: translateY(20%);" /> be an elliptic curve group with generator <img alt="g" src="https://render.githubusercontent.com/render/math?math=g" style="transform: translateY(20%);" /> and order <img alt="q" src="https://render.githubusercontent.com/render/math?math=q" style="transform: translateY(20%);" />.

> * <img alt="KeyGen(G, g, q)" src="https://render.githubusercontent.com/render/math?math=KeyGen%28G%2C%20g%2C%20q%29" style="transform: translateY(20%);" />: choose a uniform element <img alt="sk \in Z_q" src="https://render.githubusercontent.com/render/math?math=sk%20%5Cin%20Z_q" style="transform: translateY(20%);" />; set the public key <img alt="pk = sk \cdot g" src="https://render.githubusercontent.com/render/math?math=pk%20%3D%20sk%20%5Ccdot%20g" style="transform: translateY(20%);" />.
> * <img alt="Sign(sk, m)" src="https://render.githubusercontent.com/render/math?math=Sign%28sk%2C%20m%29" style="transform: translateY(20%);" />: choose a uniform one-time key <img alt="k \in Z_q" src="https://render.githubusercontent.com/render/math?math=k%20%5Cin%20Z_q" style="transform: translateY(20%);" />; compute a nonce <img alt="R = k \cdot g" src="https://render.githubusercontent.com/render/math?math=R%20%3D%20k%20%5Ccdot%20g" style="transform: translateY(20%);" />; the signature is <img alt="\sigma = (k - sk \cdot H(R || m ) \mod q), R)" src="https://render.githubusercontent.com/render/math?math=%5Csigma%20%3D%20%28k%20-%20sk%20%5Ccdot%20H%28R%20%7C%7C%20m%20%29%20%5Cmod%20q%29%2C%20R%29" style="transform: translateY(20%);" />, where <img alt="H" src="https://render.githubusercontent.com/render/math?math=H" style="transform: translateY(20%);" /> is a hash function.
> * <img alt="Verify(m, \sigma = (s,R))" src="https://render.githubusercontent.com/render/math?math=Verify%28m%2C%20%5Csigma%20%3D%20%28s%2CR%29%29" style="transform: translateY(20%);" />: Check <img alt="s \cdot g =^? R - H(R || m) \cdot pk" src="https://render.githubusercontent.com/render/math?math=s%20%5Ccdot%20g%20%3D%5E%3F%20R%20-%20H%28R%20%7C%7C%20m%29%20%5Ccdot%20pk" style="transform: translateY(20%);" />.
* **Blind Schnorr signatures**:
## Other types

**Designated-verifier (DV) signatures**: Instead of being publicly verifiable, a signature can only be verified by a specific party (the DV). _Message authentication codes (MACs)_ can be thought of as DV-sigs, since a secret key is necessary to verify a MAC, so only parties that know the secret key can perform verification.

**Functional signatures**:

**Lockable signatures**:

**Threshold signature**: signing/secret key is split into _shares_; producing a signature requires some threshold number of shares.
* a threshold signature should be indistinguishable from an ordinary signature
## Security Notions

**EUF-CMA**: Existential UnForgeability under adaptive Chosen Message Attacks, aka "existential unforgeability".
* **EUF-CMA game**:
  1. Challenger: <img alt="pk,sk \gets Gen(1^n)" src="https://render.githubusercontent.com/render/math?math=pk%2Csk%20%5Cgets%20Gen%281%5En%29" style="transform: translateY(20%);" />
  2. <img alt="\mathcal{A}(pk)" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D%28pk%29" style="transform: translateY(20%);" /> interacts with <img alt="Sign_{sk}(\cdot)" src="https://render.githubusercontent.com/render/math?math=Sign_%7Bsk%7D%28%5Ccdot%29" style="transform: translateY(20%);" /> (in polynomial time) – that is, it gets to see polynomially many valid signatures on _chosen_ messages
  3. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> outputs a message-signature pair <img alt="m^*,\sigma^*" src="https://render.githubusercontent.com/render/math?math=m%5E%2a%2C%5Csigma%5E%2a" style="transform: translateY(20%);" />
<br/>

<img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> *wins* if (1) <img alt="m^*" src="https://render.githubusercontent.com/render/math?math=m%5E%2a" style="transform: translateY(20%);" /> wasn't one of the messages on which it queried the signing oracle and (2) <img alt="Verify_{pk}(m^*,\sigma^*) = 1" src="https://render.githubusercontent.com/render/math?math=Verify_%7Bpk%7D%28m%5E%2a%2C%5Csigma%5E%2a%29%20%3D%201" style="transform: translateY(20%);" />; in this case, the game outputs 1.

**SUF-CMA**: Strong UnForgeability under adaptive Chosen Message Attacks, aka "strong unforgeability".
* **SUF-CMA game**: Same as the EUF-CMA game.
<br/>

<img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> *wins* if (1) **<img alt="(m^*,\sigma^*)" src="https://render.githubusercontent.com/render/math?math=%28m%5E%2a%2C%5Csigma%5E%2a%29" style="transform: translateY(20%);" /> wasn't one of the message-signature pairs** on which it queried the signing oracle and (2) <img alt="Verify_{pk}(m^*,\sigma^*) = 1" src="https://render.githubusercontent.com/render/math?math=Verify_%7Bpk%7D%28m%5E%2a%2C%5Csigma%5E%2a%29%20%3D%201" style="transform: translateY(20%);" />; in this case, the game outputs 1.

This is a stronger definition than EUF-CMA, since the attacker can win by forging a signature on a previously-queried message <img alt="m^*" src="https://render.githubusercontent.com/render/math?math=m%5E%2a" style="transform: translateY(20%);" /> **as long as the signature is different**, for example by "mauling" a valid signature without changing its validity. This might seem a bit odd -- what does it matter if the adversary produces a different signature? The message was already signed by an honest party, so the adversary isn't convincing anyone that the party signed something it *didn't* actually sign. However, this difference does end up being important in some applications where signatures are used as building blocks.


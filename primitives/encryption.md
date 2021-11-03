[← Back to Glossary](../glossary.md)

# Encryption

## Types of Schemes

### Asymmetric (public-key) encryption

One key (the recipient's public key) is used for encryption, while another key (the corresponding secret key) is used for decryption. The private and public keys for a key pair.

#### Schemes:

**ElGamal encryption**: For a cyclic group <img alt="G" src="https://render.githubusercontent.com/render/math?math=G" style="transform: translateY(20%);" /> of order <img alt="q" src="https://render.githubusercontent.com/render/math?math=q" style="transform: translateY(20%);" /> with generator <img alt="g" src="https://render.githubusercontent.com/render/math?math=g" style="transform: translateY(20%);" />, the secret key is <img alt="x" src="https://render.githubusercontent.com/render/math?math=x" style="transform: translateY(20%);" />, a uniformly chosen element of <img alt="G" src="https://render.githubusercontent.com/render/math?math=G" style="transform: translateY(20%);" />; the public key is <img alt="(G, q, g, h:=g^x)" src="https://render.githubusercontent.com/render/math?math=%28G%2C%20q%2C%20g%2C%20h%3A%3Dg%5Ex%29" style="transform: translateY(20%);" />.

> * <img alt="Enc(m \in G)" src="https://render.githubusercontent.com/render/math?math=Enc%28m%20%5Cin%20G%29" style="transform: translateY(20%);" />: choose a uniform element <img alt="y \in G" src="https://render.githubusercontent.com/render/math?math=y%20%5Cin%20G" style="transform: translateY(20%);" />; return <img alt="(c_1 := g^y, c_2 := m h^y = m g^{xy})" src="https://render.githubusercontent.com/render/math?math=%28c_1%20%3A%3D%20g%5Ey%2C%20c_2%20%3A%3D%20m%20h%5Ey%20%3D%20m%20g%5E%7Bxy%7D%29" style="transform: translateY(20%);" />
> * <img alt="Dec(c_1,c_2)" src="https://render.githubusercontent.com/render/math?math=Dec%28c_1%2Cc_2%29" style="transform: translateY(20%);" />: let <img alt="s := c_1^x = g^{xy} = h^y" src="https://render.githubusercontent.com/render/math?math=s%20%3A%3D%20c_1%5Ex%20%3D%20g%5E%7Bxy%7D%20%3D%20h%5Ey" style="transform: translateY(20%);" /> and compute <img alt="s^{-1}" src="https://render.githubusercontent.com/render/math?math=s%5E%7B-1%7D" style="transform: translateY(20%);" />. Then <img alt="m" src="https://render.githubusercontent.com/render/math?math=m" style="transform: translateY(20%);" /> is recovered as <img alt="c_2 s^{-1} = (m h^y) (h^y)^{-1} = m" src="https://render.githubusercontent.com/render/math?math=c_2%20s%5E%7B-1%7D%20%3D%20%28m%20h%5Ey%29%20%28h%5Ey%29%5E%7B-1%7D%20%3D%20m" style="transform: translateY(20%);" />.
<br/>

_Properties_: CPA-secure (by DDH assumption), unconditionally malleable.

**RSA encryption**:

**Paillier encryption**:

### Symmetric (secret-key) encryption

The same key is used for both decryption and encryption. This means the sender and recipient must somehow securely agree on a secret key; this is usually achieved either via _key agreement_ protocols or by encrypting the symmetric key using public-key encryption.

#### Schemes:

**Advanced Encryption Standard (AES)**:

**One-time Pad**:

### Other

**Attribute-based encryption (ABE)**: Policy-based access to encrypted data (general case of identity-based encryption (IBE)). The policy is public. A trusted third-party distributes keys to parties that meet the policy.

**Functional encryption (FE)**: An encryption scheme in which it is possible to issue "function keys", e.g. a key <img alt="k_f" src="https://render.githubusercontent.com/render/math?math=k_f" style="transform: translateY(20%);" /> that decrypts the ciphertext into a function <img alt="f(m)" src="https://render.githubusercontent.com/render/math?math=f%28m%29" style="transform: translateY(20%);" /> of the plaintext <img alt="m" src="https://render.githubusercontent.com/render/math?math=m" style="transform: translateY(20%);" />.

**Identity-based encryption (IBE)**:
* **Hierarchical IBE (HIBE)**:
<br/>

**Registration-based encryption (RBE)**:

**Rerandomizable encryption**:

**Structured encryption**:

**Witness encryption (WE)**:
* **Extractable witness encryption (EWE)**:
## Security Notions

**Circular security**: Usually, our security definitions say nothing about what happens when we encrypt _the secret key itself_ with the encryption scheme. If a scheme is circular secure, it is secure even when the message is (a function of) the secret key. This is also called **key-dependent message (KDM) security**.

**CPA security**: Secure against chosen plaintext attacks (CPA). Again, this is indistinguishability-based, so the more specific name is IND-CPA security. This is equivalent to **semantic security** (semantic security ⇒ IND-CPA and IND-CPA ⇒ semantic security, so semantic security ⇔ IND-CPA).
* **IND-CPA game**:
  1. Challenger: <img alt="k \gets Gen(1^n)" src="https://render.githubusercontent.com/render/math?math=k%20%5Cgets%20Gen%281%5En%29" style="transform: translateY(20%);" />
  2. <img alt="\mathcal{A}(1^n)" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D%281%5En%29" style="transform: translateY(20%);" /> interacts with <img alt="Enc_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Enc_k%28%5Ccdot%29" style="transform: translateY(20%);" /> (in polynomial time)
  3. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> outputs <img alt="m_0, m_1" src="https://render.githubusercontent.com/render/math?math=m_0%2C%20m_1" style="transform: translateY(20%);" /> of same length
  4. Challenger: <img alt="b \gets \{0,1\}, c \gets Enc_k(m_b)" src="https://render.githubusercontent.com/render/math?math=b%20%5Cgets%20%5C%7B0%2C1%5C%7D%2C%20c%20%5Cgets%20Enc_k%28m_b%29" style="transform: translateY(20%);" />, send <img alt="c" src="https://render.githubusercontent.com/render/math?math=c" style="transform: translateY(20%);" /> to <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" />
  5. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> continues to interact with <img alt="Enc_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Enc_k%28%5Ccdot%29" style="transform: translateY(20%);" /> (in polynomial time)
  6. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> outputs <img alt="b'" src="https://render.githubusercontent.com/render/math?math=b%27" style="transform: translateY(20%);" />
<br/>

<img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> *wins* if <img alt="b=b'" src="https://render.githubusercontent.com/render/math?math=b%3Db%27" style="transform: translateY(20%);" />, and the game outputs 1.

**CCA security**: Secure against chosen ciphertext attacks (CCA); this is an indistinguishability-based notion, so it is more specifically IND-CCA security. There are two variants of IND-CCA security, and both are stronger than IND-CPA because the adversary is additionally given access to a _decryption_ oracle. "IND-CCA" (without a number) usually refers to IND-CCA2.
* **IND-CCA1**: Non-adaptive (lunchtime) chosen ciphertext attack. Weaker than IND-CCA2. Game:
  1. Challenger: <img alt="k \gets Gen(1^n)" src="https://render.githubusercontent.com/render/math?math=k%20%5Cgets%20Gen%281%5En%29" style="transform: translateY(20%);" />
  2. <img alt="\mathcal{A}(1^n)" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D%281%5En%29" style="transform: translateY(20%);" /> interacts with <img alt="Enc_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Enc_k%28%5Ccdot%29" style="transform: translateY(20%);" /> **and <img alt="Dec_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Dec_k%28%5Ccdot%29" style="transform: translateY(20%);" />** (in polynomial time)
  3. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> outputs <img alt="m_0, m_1" src="https://render.githubusercontent.com/render/math?math=m_0%2C%20m_1" style="transform: translateY(20%);" /> of same length
  4. Challenger: <img alt="b \gets \{0,1\}, c \gets Enc_k(m_b)" src="https://render.githubusercontent.com/render/math?math=b%20%5Cgets%20%5C%7B0%2C1%5C%7D%2C%20c%20%5Cgets%20Enc_k%28m_b%29" style="transform: translateY(20%);" />, send <img alt="c" src="https://render.githubusercontent.com/render/math?math=c" style="transform: translateY(20%);" /> to <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" />
  5. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> can perform some operations (in polynomial time) <!-- does it have access to Enc_k(•)? -->
  6. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> outputs <img alt="b'" src="https://render.githubusercontent.com/render/math?math=b%27" style="transform: translateY(20%);" />
<br/>

<img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> *wins* if <img alt="b=b'" src="https://render.githubusercontent.com/render/math?math=b%3Db%27" style="transform: translateY(20%);" />, and the game outputs 1.
* **IND-CCA2**: Adaptive chosen ciphertext attack. In addition to its capabilities in the IND-CCA1 game, A now has access to the oracles _after_ seeing <img alt="c" src="https://render.githubusercontent.com/render/math?math=c" style="transform: translateY(20%);" />. Game:
  1. Challenger: <img alt="k \gets Gen(1^n)" src="https://render.githubusercontent.com/render/math?math=k%20%5Cgets%20Gen%281%5En%29" style="transform: translateY(20%);" />
  2. <img alt="\mathcal{A}(1^n)" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D%281%5En%29" style="transform: translateY(20%);" /> interacts with <img alt="Enc_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Enc_k%28%5Ccdot%29" style="transform: translateY(20%);" /> and <img alt="Dec_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Dec_k%28%5Ccdot%29" style="transform: translateY(20%);" /> (in polynomial time)
  3. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> outputs <img alt="m_0, m_1" src="https://render.githubusercontent.com/render/math?math=m_0%2C%20m_1" style="transform: translateY(20%);" /> of same length
  4. Challenger: <img alt="b \gets \{0,1\}, c \gets Enc_k(m_b)" src="https://render.githubusercontent.com/render/math?math=b%20%5Cgets%20%5C%7B0%2C1%5C%7D%2C%20c%20%5Cgets%20Enc_k%28m_b%29" style="transform: translateY(20%);" />, send <img alt="c" src="https://render.githubusercontent.com/render/math?math=c" style="transform: translateY(20%);" /> to <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" />
  5. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> **continues to interact with <img alt="Enc_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Enc_k%28%5Ccdot%29" style="transform: translateY(20%);" /> and <img alt="Dec_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Dec_k%28%5Ccdot%29" style="transform: translateY(20%);" />** (in polynomial time) but can't query <img alt="Dec_k(\cdot)" src="https://render.githubusercontent.com/render/math?math=Dec_k%28%5Ccdot%29" style="transform: translateY(20%);" /> on <img alt="c" src="https://render.githubusercontent.com/render/math?math=c" style="transform: translateY(20%);" />
  6. <img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> outputs <img alt="b'" src="https://render.githubusercontent.com/render/math?math=b%27" style="transform: translateY(20%);" />
<br/>

<img alt="\mathcal{A}" src="https://render.githubusercontent.com/render/math?math=%5Cmathcal%7BA%7D" style="transform: translateY(20%);" /> *wins* if <img alt="b=b'" src="https://render.githubusercontent.com/render/math?math=b%3Db%27" style="transform: translateY(20%);" />, and the game outputs 1.


[← Back to Glossary](../glossary.md)

# Encryption

## Asymmetric (public-key) encryption

One key (the recipient's public key) is used for encryption, while another key (the corresponding secret key) is used for decryption. The private and public keys for a key pair.

Schemes:

**ElGamal encryption**: For a cyclic group <img alt="G" src="https://render.githubusercontent.com/render/math?math=G" style="transform: translateY(20%);" /> of order <img alt="q" src="https://render.githubusercontent.com/render/math?math=q" style="transform: translateY(20%);" /> with generator <img alt="g" src="https://render.githubusercontent.com/render/math?math=g" style="transform: translateY(20%);" />, the secret key is <img alt="x" src="https://render.githubusercontent.com/render/math?math=x" style="transform: translateY(20%);" />, a uniformly chosen element of <img alt="G" src="https://render.githubusercontent.com/render/math?math=G" style="transform: translateY(20%);" />; the public key is <img alt="(G, q, g, h:=g^x)" src="https://render.githubusercontent.com/render/math?math=%28G%2C%20q%2C%20g%2C%20h%3A%3Dg%5Ex%29" style="transform: translateY(20%);" />.

> <img alt="Enc(m \in G)" src="https://render.githubusercontent.com/render/math?math=Enc%28m%20%5Cin%20G%29" style="transform: translateY(20%);" />: choose a uniform element <img alt="y \in G" src="https://render.githubusercontent.com/render/math?math=y%20%5Cin%20G" style="transform: translateY(20%);" />; return <img alt="(c_1 := g^y, c_2 := m h^y = m g^{xy})" src="https://render.githubusercontent.com/render/math?math=%28c_1%20%3A%3D%20g%5Ey%2C%20c_2%20%3A%3D%20m%20h%5Ey%20%3D%20m%20g%5E%7Bxy%7D%29" style="transform: translateY(20%);" /><img alt="Dec(c_1,c_2)" src="https://render.githubusercontent.com/render/math?math=Dec%28c_1%2Cc_2%29" style="transform: translateY(20%);" />: let <img alt="s := c_1^x = g^{xy} = h^y" src="https://render.githubusercontent.com/render/math?math=s%20%3A%3D%20c_1%5Ex%20%3D%20g%5E%7Bxy%7D%20%3D%20h%5Ey" style="transform: translateY(20%);" /> and compute <img alt="s^{-1}" src="https://render.githubusercontent.com/render/math?math=s%5E%7B-1%7D" style="transform: translateY(20%);" />. Then <img alt="m" src="https://render.githubusercontent.com/render/math?math=m" style="transform: translateY(20%);" /> is recovered as <img alt="c_2 s^{-1} = (m h^y) (h^y)^{-1} = m" src="https://render.githubusercontent.com/render/math?math=c_2%20s%5E%7B-1%7D%20%3D%20%28m%20h%5Ey%29%20%28h%5Ey%29%5E%7B-1%7D%20%3D%20m" style="transform: translateY(20%);" />.

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

**Functional encryption (FE)**: An encryption scheme in which it is possible to issue "function keys", e.g. a key <img alt="k_f" src="https://render.githubusercontent.com/render/math?math=k_f" style="transform: translateY(20%);" /> that decrypts the ciphertext into a function <img alt="f(m)" src="https://render.githubusercontent.com/render/math?math=f%28m%29" style="transform: translateY(20%);" /> of the plaintext <img alt="m" src="https://render.githubusercontent.com/render/math?math=m" style="transform: translateY(20%);" />.

**Identity-based encryption (IBE)**:

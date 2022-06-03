# Encryption

!!! summary
    Encryption schemes are used to ensure confidentiality.

An encryption scheme consists of three algorithms: a key generation algorithm $\mathsf{Gen}$ (or $\mathsf{KGen}$) that takes no input and outputs a key (or key pair), an encryption algorithm $\mathsf{Enc}$ that takes a (public) key and a message and outputs a ciphertext, and a decryption algorithm $\mathsf{Dec}$ that takes a (private) key and a ciphertext and outputs a message. Some schemes with advanced properties may add additional algorithms.

## Basic Types of Encryption

**Asymmetric (public-key) encryption**
: One key (the recipient's public key) is used for encryption, while another key (the corresponding secret key) is used for decryption. The private and public keys form a key pair.  

!!! example "ElGamal encryption"

    === "Scheme"
        $\underline{\mathsf{Gen}}$: Choose a uniform cyclic prime-order group $\mathbb{G}$, where $q$ is the order and $g$ is the generator (these are announced publicly). Output the secret key $x \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$ and the public key $g^x \in \mathbb{G}$.

        $\underline{\mathsf{Enc}(pk, m)}$:

        - return $c := (g^r, m \cdot pk^r)$ where $r \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_p$

        $\underline{\mathsf{Dec}(sk, c := (c_1, c_2))}:$

        - return $m \gets c_2/c_1^{sk}$. Note this equals $m \cdot pk^r/(g^r)^{sk} = m \cdot g^{xr}/g^{rx} = m$

    === "Properties"
        - CPA-secure (by DDH assumption)
        - unconditionally malleable

!!! example "RSA encryption"

    === "Scheme"
        $\underline{\mathsf{Gen}}$: return the public key $(n,e)$ and private key $d$, where

        - $n:=pq$ for two random distinct prime numbers $p,q$
        - $1<e<\varphi(n)$ and $\gcd(e,\varphi(n))=1$[^1]
        - $d \equiv e^{-1}\pmod{\varphi(n)}$[^2]

        [^1]: $\varphi$ is Euler's totient function; as an optimization, many implementations use Carmicheal's totient function $\lambda$ instead. See the bottom of the [key generation paragraph on Wikipedia](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Key_generation) for more information.

        [^2]: e.g., using the extended Euclidean algorithm

        $\underline{\mathsf{Enc}(pk:=(n,e), m)}$ where $0 \le m < n$[^3]:  

        - return $c \equiv m^e \pmod{n}$

        [^3]: A message $M$ is turned into an integer $n$ satisfying this property using an agreed-upon reversible padding scheme.

        $\underline{\mathsf{Dec}(sk := d, c)}:$  

        - compute $c^d \equiv (m^e)^d \equiv m \pmod{n}$

    === "Properties"
        Assuming a [strong padding scheme](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Padding_schemes), RSA is

        - CCA-secure (by either the RSA assumption or the hardness of integer factorization; if either assumption is proven false the security of RSA is compromised)

!!! example "Paillier encryption"

**Symmetric (secret-key) encryption**
: The same key is used for both decryption and encryption. This means the sender and recipient must somehow securely agree on a secret key; this is usually achieved either via _key agreement_ protocols or by encrypting the symmetric key using public-key encryption.  

!!! example "Advanced Encryption Standard (AES)"

!!! example "One-time Pad"

## Advanced Encryption

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
: Usually, our security definitions say nothing about what happens when we encrypt _the secret key itself_ with the encryption scheme. If a scheme is circular secure, it is secure even when the message is (a function of) the secret key. This is also called **key-dependent message security**.

### CPA security
Secure against chosen plaintext attacks (CPA). The indistinguishability-based notion of CPA-security is IND-CPA security. IND-CPA is equivalent to **semantic security** (semantic security &rArr; IND-CPA and IND-CPA &rArr; semantic security, so semantic security &iff; IND-CPA).

!!! info "IND-CPA game"

    1. Challenger: $k \gets Gen(1^n)$
    1. $\mathcal{A}(1^n)$ interacts with $Enc_k(\cdot)$ (in polynomial time)
    1. $\mathcal{A}$ outputs $m_0, m_1$ of same length
    1. Challenger: $b \gets \{0,1\}, c \gets Enc_k(m_b)$, send $c$ to $\mathcal{A}$
    1. $\mathcal{A}$ continues to interact with $Enc_k(\cdot)$ (in polynomial time)
    1. $\mathcal{A}$ outputs $b'$

    $\mathcal{A}$ *wins* if $b=b'$, and the game outputs 1.  

**OW-CPA**
: 

### CCA security
Secure against chosen ciphertext attacks (CCA). The indistinguishability-based notion of CCA-security is IND-CCA security. There are two variants of IND-CCA security (IND-CCA1 and IND-CCA2), and both are stronger than IND-CPA because the adversary is additionally given access to a _decryption_ oracle. "IND-CCA" (without a number) usually refers to IND-CCA2.

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

**OW-CCA**
: 
# Encryption

!!! summary
    Encryption schemes are used to ensure confidentiality.

An encryption scheme consists of three algorithms: a key generation algorithm $\mathsf{Gen}$ (or $\mathsf{KGen}$) that takes as input a [security parameter](../general.md#secparam) and outputs a key (or key pair), an encryption algorithm $\mathsf{Enc}$ that takes a (public) key and a message and outputs a ciphertext, and a decryption algorithm $\mathsf{Dec}$ that takes a (private) key and a ciphertext and outputs a message. Some schemes with advanced properties may add additional algorithms.

!!! notation "Encryption scheme syntax"
    An encryption scheme $\Pi_\mathsf{E}$ is a triple of algorithms $(\mathsf{Gen}, \mathsf{Enc}, \mathsf{Dec})$:

    - $({\sf pk}, {\sf sk}) \gets \mathsf{Gen}(1^\lambda)$
    - $c \gets \mathsf{Enc}({\sf pk}, m)$
    - $m \gets \mathsf{Dec}({\sf sk}, c)$

In the case of a [symmetric (private-key) encryption](#symmetric-enc) scheme, the private and public key are the same.

**Correctness**
: For all key (pairs) output by $\sf Gen$ we have ${\sf Dec}({\sf sk}, {\sf Enc}({\sf pk}, m)) = m$. The correctness notions for the fancier encryption schemes below are extensions of this basic notion: basically, if everything is run honestly, a ciphertext should decrypt to its original message.

## Basic Types of Encryption

**Asymmetric (public-key) encryption** { #pke }
: One key (the recipient's public key) is used for encryption, while another key (the corresponding secret key) is used for decryption. The private and public keys form a key pair.  

    !!! example "ElGamal encryption"

        === "Scheme"
            $\underline{\mathsf{Gen}}$: Choose a uniform cyclic prime-order group $\mathbb{G}$, where $q$ is the order and $g$ is the generator (these are announced publicly). Output the secret key $x \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_q$ and the public key $g^x \in \mathbb{G}$.

            $\underline{\mathsf{Enc}(pk, m)}$:

            - return $c := (g^r, m \cdot pk^r)$ where $r \gets\!\!\tiny{\$}\normalsize\ \mathbb{Z}_p$

            $\underline{\mathsf{Dec}(sk, c := (c_1, c_2))}:$

            - return $m \gets c_2/c_1^{sk}$. Note this equals $m \cdot pk^r/(g^r)^{sk} = m \cdot g^{xr}/g^{rx} = m$

        === "Properties"
            - [CPA-secure](#cpa-security) (by [DDH assumption](../assumptions.md#ddh))
            - unconditionally malleable

    !!! example "RSA encryption"

        === "Scheme"
            $\underline{\mathsf{Gen}}$: return the public key $(n,e)$ and private key $d$, where

            - $n:=pq$ for two random distinct prime numbers $p,q$ (this is sometimes called a **semiprime**)
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

            - [CCA-secure](#cca-security) (by either the [RSA assumption](../assumptions.md#rsa-assumption) or the [hardness of integer factorization](../assumptions.md#factoring-assumption); if either assumption is proven false the security of RSA is compromised)

    !!! example "Paillier encryption"
        <!-- TODO -->

    !!! example "Cramer-Shoup cryptosystem"

**Symmetric (secret-key) encryption** { #symmetric-enc }
: The same key is used for both decryption and encryption. This means the sender and recipient must somehow securely agree on a secret key; this is usually achieved either via [key agreement](./key-exchange.md#key-agreement) protocols or by encrypting the symmetric key using [public-key encryption](#pke).  

    !!! example "Advanced Encryption Standard (AES)"

    !!! example "One-time Pad"

## Advanced Types of Encryption

**Attribute-based encryption (ABE)** { #abe }
: Policy-based access to encrypted data (general case of [identity-based encryption](#ibe)). The policy is not necessarily hidden. A trusted third party is required to distribute policy keys only to parties that meet the policy.

    !!! notation "ABE syntax"
        - $({\sf mpk}, {\sf msk}) \gets \mathsf{Setup}(1^\lambda)$: set up master keypair
        - ${\sf sk}_{f} \gets \mathsf{KGen}({\sf msk}, f)$: generate a secret key for some access control policy $f: \{0, 1\}^* \rightarrow \{0,1\}$
        - $c_a \gets \mathsf{Enc}({\sf mpk}, a, m)$: encrypt to all users with the attribute $a$
        - $\{m, \perp\} \gets \mathsf{Dec}(sk_f, c_a)$: decrypt with secret key for policy $f$ to get the plaintext; returns $\perp$ if $c$ was encrypted to an attribute $a$ which doesn't meet the policy, that is, $f(a) \neq 1$

**Broadcast encryption**
: 

**Functional encryption (FE)** { #fe }
: An encryption scheme in which it is possible to issue "function keys", e.g. a key $k_f$ that decrypts the ciphertext into a function $f(m)$ of the plaintext $m$.

    !!! notation "FE syntax"
        - $({\sf mpk}, {\sf msk}) \gets \mathsf{Setup}(1^\lambda)$: set up master keypair
        - ${\sf sk}_f \gets \mathsf{KGen}({\sf msk}, f)$: generate a function secret key
        - $c \gets \mathsf{Enc}({\sf mpk}, m)$: encrypt under master public key
        - $f(m) \gets \mathsf{Dec}({\sf sk}_f, c)$: decrypt with function secret key to obtain the function of the plaintext

**Fully homomorphic encryption (FHE)** { #fhe }
: 

    !!! tip "Further reading"
        [FHE.org Resources](https://fhe.org/resources)

**Identity-based encryption (IBE)** { #ibe }
: Identity-based access to encrypted data. A trusted third party is required to issue keys to identities. The reasoning behind the introduction of IBE was to avoid the complicated [public-key infrastructure (PKI)](https://en.wikipedia.org/wiki/Public_key_infrastructure), in particular the issue of public key distribution, by allowing encrypters to encrypt directly to an identifier (e.g. a party's name, email, or phone number) without having to obtain the party's public key.

    !!! notation "IBE syntax"
        - $({\sf mpk}, {\sf msk}) \gets \mathsf{Setup}(1^\lambda)$: set up master keypair
        - ${\sf sk}_{\sf id} \gets \mathsf{KGen}({\sf msk}, {\sf id})$: generate an identity's secret key
        - $c_{\sf id} \gets \mathsf{Enc}({\sf mpk}, {\sf id}, m)$: encrypt directly to an identity
        - $\{m, \perp\} \gets \mathsf{Dec}(sk_y, c_{\sf id})$: decrypt with identity secret key to get the plaintext; returns $\perp$ if $c$ was encrypted to an identity ${\sf id} \neq y$

    Note that IBE can be viewed as a specific case of [ABE](#abe) where $f(a) = \begin{cases}1 & a = {\sf id}\\ 0 & \text{otherwise}\end{cases}$.

    !!! example "Boneh-Franklin IBE"

**Hierarchical IBE (HIBE)** { #hibe }
: 

**Registration-based encryption (RBE)** { #rbe }
: Similar to [IBE](#ibe), but without a trusted third party; instead there is a transparent party called the "key curator" who is only responsible for accumulating keys of parties who register in the system, but does not hold any secrets.

    !!! notation "RBE syntax"

    !!! tip "Further Reading"
        - Introduced in [Registration-based encryption: removing private-key generator from IBE](https://eprint.iacr.org/2018/919) [GHMR18]
        - [Registration-based encryption from standard assumptions](https://eprint.iacr.org/2018/1030) [GHMRS19]
        - [Verifiable registration-based encryption](https://eprint.iacr.org/2019/1044) [GV20]
        - [Efficient registration-based encryption](https://eprint.iacr.org/2022/1505) [GKMR23]

**Rerandomizable encryption**
: An encryption scheme in which the ciphertext can be updated into a new and unrelated ciphertext while keeping the underlying plaintext the same.

    !!! notation "Rerandomizable encryption syntax"
        - $\sf Gen, Enc, Dec$ as usual
        - $c' \gets \mathsf{Rerand}(c, r)$: rerandomize the ciphertext using randomness $r$ without changing the underlying message ($\mathsf{Dec}({\sf sk}, c) = \mathsf{Dec}({\sf sk}, c')$)


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
CPA stands for "chosen *plaintext* attacks", and security against these attacks can be formulated in two (equivalent) ways. 

The indistinguishability-based notion of CPA security is called **IND-CPA security**, and requires that an adversary cannot distinguish between encryption of two different messages:

!!! info "IND-CPA game"
    === "Description"
        1. Challenger: $k \gets Gen(1^n)$
        1. $\mathcal{A}(1^n)$ interacts with $Enc_k(\cdot)$ (in polynomial time)
        1. $\mathcal{A}$ outputs $m_0, m_1$ of same length
        1. Challenger: $b \gets \{0,1\}, c \gets Enc_k(m_b)$, send $c$ to $\mathcal{A}$
        1. $\mathcal{A}$ continues to interact with $Enc_k(\cdot)$ (in polynomial time)
        1. $\mathcal{A}$ outputs $b'$

        $\mathcal{A}$ *wins* if $b=b'$, and the game outputs 1.  

    === "Diagram"
        ``` mermaid
        sequenceDiagram
            Note over Challenger: (1) Sample k #larr; Gen(1^n)
            Note over Adversary: (2) Query Enc oracle (in poly time)
            loop Enc oracle
                Adversary-->>Challenger: m
                Challenger-->>Adversary: Enc(k, m)
            end
            Adversary->>Challenger: (3) m_0, m_1
            Note over Challenger: (4) Sample b #larr; {0,1} <br/> c #larr; Enc(k, m_b)
            Challenger->>Adversary: c
            Note over Adversary: (5) Query Enc oracle (in poly time)
            loop Enc oracle
                Adversary-->>Challenger: m
                Challenger-->>Adversary: Enc(k, m)
            end
            %%loop Enc oracle
            %%    Adversary->>Adversary: query oracle (in poly time)
            %%end
            Adversary->>Challenger: (6) b'
            Note right of Challenger: Adversary wins if b=b'
        ```

The alternative formulation is the simulation-based **semantic security** (or **SIM-CPA**), which says that anything the adversary can compute from the ciphertext can also be computed (simulated) without the ciphertext. That is, the ciphertext does not reveal any new information to the adversary.

These two notions have been shown to be equivalent: semantic security &rArr; IND-CPA and IND-CPA &rArr; semantic security, therefore semantic security &iff; IND-CPA.

**OW-CPA**
: one-way CPA security. <!-- TODO -->

### CCA security
CCA stands for "chosen *ciphertext* attacks", and security against these attacks if normally formulated as an indistinguishability-based notion (IND-CCA). There are two variants of IND-CCA security: [IND-CCA1](#ind-cca1) and [IND-CCA2](#ind-cca2). Both are stronger than [IND-CPA security](#cpa-security) because the adversary is additionally given access to a _decryption_ oracle. **IND-CCA** (without a number) usually refers to [IND-CCA2](#ind-cca2).

**IND-CCA1** { #ind-cca1 }
: Security against *non-adaptive* ("lunchtime") chosen ciphertext attack. Weaker than [IND-CCA2](#ind-cca2). 

    !!! info "IND-CCA1 game"
        === "Description"
            1. Challenger: $k \gets Gen(1^n)$
            1. $\mathcal{A}(1^n)$ interacts with $Enc_k(\cdot)$ **and $Dec_k(\cdot)$** (in polynomial time)
            1. $\mathcal{A}$ outputs $m_0, m_1$ of same length
            1. Challenger: $b \gets \{0,1\}, c \gets Enc_k(m_b)$, send $c$ to $\mathcal{A}$
            1. $\mathcal{A}$ can perform some operations (in polynomial time) <!-- does it have access to Enc_k(•)? -->
            1. $\mathcal{A}$ outputs $b'$

            $\mathcal{A}$ *wins* if $b=b'$, and the game outputs 1.
        
        === "Diagram"
            ``` mermaid
            sequenceDiagram
                Note over Challenger: (1) Sample k #larr; Gen(1^n)
                Note over Adversary: (2) Query Enc and Dec oracles <br/> (in poly time)
                par Enc oracle
                    loop 
                        Adversary-->>Challenger: m
                        Challenger-->>Adversary: Enc(k, m)
                    end
                and Dec oracle
                    loop 
                        Adversary-->>Challenger: c
                        Challenger-->>Adversary: Dec(k, c)
                    end
                end
                Adversary->>Challenger: (3) m_0, m_1
                Note over Challenger: (4) Sample b #larr; {0,1} <br/> c #larr; Enc(k, m_b)
                Challenger->>Adversary: c
                Note over Adversary: (5) Perform any operations (in poly time)
                Adversary->>Challenger: (6) b'
                Note right of Challenger: Adversary wins if b=b'
            ```

**IND-CCA2** { #ind-cca2 }
: Security against *adaptive* chosen ciphertext attack. In addition to its capabilities in the [IND-CCA1](#ind-cca1) game, $\mathcal{A}$ now has access to the oracles _after_ seeing $c$.

    !!! info "IND-CCA2 game"
        === "Description"
            1. Challenger: $k \gets Gen(1^n)$
            1. $\mathcal{A}(1^n)$ interacts with $Enc_k(\cdot)$ and $Dec_k(\cdot)$ (in polynomial time)
            1. $\mathcal{A}$ outputs $m_0, m_1$ of same length
            1. Challenger: $b \gets \{0,1\}, c \gets Enc_k(m_b)$, send $c$ to $\mathcal{A}$
            1. $\mathcal{A}$ **continues to interact with $Enc_k(\cdot)$ and $Dec_k(\cdot)$** (in polynomial time) but can't query $Dec_k(\cdot)$ on $c$
            1. $\mathcal{A}$ outputs $b'$

            $\mathcal{A}$ *wins* if $b=b'$, and the game outputs 1.
        
        === "Diagram"
            ``` mermaid
            sequenceDiagram
                Note over Challenger: (1) Sample k #larr; Gen(1^n)
                Note over Adversary: (2) Query Enc and Dec oracles <br/> (in poly time)
                par Enc oracle
                    loop 
                        Adversary-->>Challenger: m
                        Challenger-->>Adversary: Enc(k, m)
                    end
                and Dec oracle
                    loop 
                        Adversary-->>Challenger: c
                        Challenger-->>Adversary: Dec(k, c)
                    end
                end
                Adversary->>Challenger: (3) m_0, m_1
                Note over Challenger: (4) Sample b #larr; {0,1} <br/> c #larr; Enc(k, m_b)
                Challenger->>Adversary: c
                Note over Adversary: (5) Continue querying Enc and Dec oracles <br/> (in poly time)
                par Enc oracle
                    loop 
                        Adversary-->>Challenger: m
                        Challenger-->>Adversary: Enc(k, m)
                    end
                and Dec oracle
                    loop 
                        Adversary-->>Challenger: c' #ne; c
                        Challenger-->>Adversary: Dec(k, c')
                    end
                end
                Adversary->>Challenger: (6) b'
                Note right of Challenger: Adversary wins if b=b'
            ```

**OW-CCA**
: one-way CCA security. <!-- TODO -->

**replayable CCA (RCCA)**
: <!-- TODO -->
# Multi-Party Computation

Sometimes also referred to as secure multi-party computation (SMC), multi-party computation (MPC) is a functionality in which two or more parties with secret inputs want to compute a joint function _f_ on those inputs. More explicitly, for _N_ parties with inputs _x1_, ..., _xN_, an MPC protocol takes those inputs and outputs _y := f(x1, ..., xN)_.

The protocol should meet a couple of conditions to be interesting/useful:
- None of the parties learn anything about the other parties' inputs (except what they can deduce from the output)
- _y_ should be correct. That is, _y_ should in fact be the function _f_ applied to the parties' inputs – no errors.

Why is this useful? A simple example is Yao's Millionaries' Problem. Two millionaires want to know who's richer, but they don't want to reveal exactly how rich they are. They can run an MPC protocol where the inputs are their net worths and the function _f_ computes the sign of _x1 - x2_. (For example _f(x1, x2) =_ {1 if _x1 > x2_, 0 if _x1 = x2_, and -1 if _x1 < x2_}.)

There are more serious real-world applications for this too. You could imagine using this to let hospitals collaborate on health analytics without sharing their patient records and other similar use cases.

## Building Blocks
**Oblivious Transfer (OT)**: Functionality in which one party holds two strings and the other a selection bit _b_. The second party learns the string corresponding to its selection bit and nothing more, while the first party learns nothing about the selection bit.
![Diagram of the OT functionality](./img/OT.png)

OTs with different numbers exist, such as 1-out-of-4 OT (P2 selects one of four choices) or more generally 1-out-of-_n_ OT for some parameter _n_.

**Secret-sharing**: Splitting a secret between parties so that none of the parties know the secret, but they each have a piece of the information, and if they work together they can recover the secret. Here's a visual intuition:

<a title="Blokhead at English Wikipedia, Public domain, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Visual_crypto_animation_demo.gif"><img width="256" alt="Visual crypto animation demo" src="https://upload.wikimedia.org/wikipedia/commons/0/0e/Visual_crypto_animation_demo.gif"></a>

Schemes:
- **Exclusive OR (XOR) secret-sharing**: For a secret _s_, set Party _i_'s share to some random value _r_i_, except for a designated party which gets _s_ XOR _r1_ XOR ... XOR _rN_. The shares XOR together to _s_, but each individual share looks random.
- **Shamir secret-sharing**: This is a form of (_t_+1)-out-of-_n_ secret-sharing, i.e., at least _t_+1 out of _n_ parties must work together to recover the secret. Shamir secret-sharing gives every party a point on a degree-_t_ polynomial. Because _t_+1 points define a unique polynomial, _t_+1 parties can work together to recover it. The secret is the value when the polynomial is evaluated at 0. Interactive demo [here](./ShamirSS.ipynb).

Secret-sharing schemes with additional properties also exist, but basic secret sharing usually suffices for MPC.
- **Homomorphic secret sharing**:
- **Robust secret sharing**: Does not consider a corrupt dealer. ...
- **Verifiable secret sharing (VSS)**: Protects against a corrupt dealer. During the sharing phase, the parties who receive shares from the dealer also run a verification function to confirm that the shares they received are well-formed (will reconstruct properly).

**Cut-and-choose**: This is an idea to turn a semi-honest secure MPC protocol into malicious-secure one. ...

## Properties

**Guaranteed output delivery (GOD)**: The strongest type of correctness guarantee. In a protocol with GOD, an adversary cannot even carry out a denial-of-service attack; the (correct) output will always be learned by the participants.

**Security with abort**:

## Protocols

Most MPC protocols turn the function to compute into a circuit representation (yes, like in electrical engineering with AND gates and whatnot). 

**Yao's Garbled Circuits (GC)**: One party (the garbler) "garbles" the circuit by successively encrypting wire keys. The other party (the evaluator) follows the path of correct decriptions through the circuit until it obtains the keys corresponding to the output value.  
- _Assumptions:_ Secure OT  
- _Optimizations:_ Point-and-permute, PRF for encryption, garbled row reduction, half-gates, free XOR.

**Goldreich–Micali–Wigderson (GMW)** (semi-honest version): Construct gates so that parties can step through the circuit using XOR-shares of wires. Multiplication gates require 1-out-of-4 OT to communicate the correct output shares.  
- _Assumptions:_ Secure OT

**Goldreich–Micali–Wigderson (GMW)** (malicious version): Same as semi-honest, but use zero-knowledge proofs to ensure well-formedness.  
- _Assumptions:_ Secure OT, ZK

**Ben-Or–Goldwasser–Wigderson (BGW)**: Same structure as GMW but over arithmetic circuits (where wires carry field elements). So, instead of using XOR-shares, use (t+1)-out-of-n Shamir secret-sharing. Multiplication gates use a degree-reduction step to maintain the invariant that parties hold well-formed wire value shares.  
- _Assumptions:_ None!

**Chaum–Crepeau–Damgård (CCD)**: 

**Beaver–Micali–Rogaway (BMR)**: This can be viewed as an adaptation of Yao's garbled circuit approach to more than two parties while keeping its low round complexity. Use GMW to compute a garbled circuit for the function to evaluate; then, one party evaluates the garbled circuit.
- _Assumptions:_ Secure OT

---
### Tabular Summary

`n`: number of circuit gates  
`d`: depth of circuit  

Year | Name | Number of parties | Threat Model | Round Complexity | Communication Complexity | Function Representation
:----|:-----|:-----------------:|:-------------|:----------------:|:-----------------------:|:-----------
1986 | Yao's GC | 2    | semi-honest       | O(1) | O(n) | Boolean circuit
1987 | GMW      | many | < n semi-honest   | O(d) | O(1) | Boolean circuit
&#8203;        || many | < n malicious     |      |      | Boolean circuit
1988 | BGW      | many | < n/2 semi-honest | O(d) | O(d) | Arithmetic circuit
&#8203;        || many | < n/3 malicious   | O(d) |      | Arithmetic circuit
1988 | CCD      | many |                   |      |      |
1990 | BMR      | many | < n               | O(1) |     | Boolean circuit

## References

**Yao's GC**: [Original paper](https://ieeexplore.ieee.org/document/4568207)

**GMW**: 

**BGW**: Original paper, [full proof](https://eccc.weizmann.ac.il//report/2011/036/)

**BMR**: [Original paper](https://dl.acm.org/doi/pdf/10.1145/100216.100287?casa_token=jgHhj-wpD88AAAAA:17nxjtduFXBZwYyyvRd9sVKdnPBXZ-vaBxXxzmHFQwhZy_dRc1UGxRnmoXj6WlNRflZ-wRlQA0v-iA), [Rogaway's Thesis](https://www.cs.ucdavis.edu/~rogaway/papers/thesis.pdf), [Pragmatic Introduction to MPC, Section 3.5](https://securecomputation.org/)
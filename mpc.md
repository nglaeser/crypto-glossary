# Multi-Party Computation

Sometimes also referred to as secure multi-party computation (SMC), multi-party computation (MPC) is a functionality in which two or more parties with secret inputs want to compute a joint function _f_ on those inputs. More explicitly, for _N_ parties with inputs _x1_, ..., _xN_, an MPC protocol takes those inputs and outputs _y := f(x1, ..., xN)_.

The protocol should meet a couple of conditions to be interesting/useful:
- None of the parties learn anything about the other parties' inputs (except what they can deduce from the output)
- _y_ should be correct. That is, _y_ should in fact be the function _f_ applied to the parties' inputs – no errors.

Why is this useful? A simple example is Yao's Millionaries' Problem. Two millionaires want to know who's richer, but they don't want to reveal exactly how rich they are. They can run an MPC protocol where the inputs are their net worths and the function _f_ computes the sign of _x1 - x_2_. (For example _f(x1, x2) =_ {1 if _x1 > x2_, 0 if _x1 = x2_, and -1 if _x1 < x2_}.)

There are more serious real-world applications for this too. You could imagine using this to let hospitals collaborate on health analytics without sharing their patient records and other similar use cases.

## Building Blocks
**Oblivious Transfer (OT)**:

**Secret-sharing**:
- **XOR secret-sharing**: 
- **Shamir secret-sharing**:

## Protocols

Most MPC protocols turn the function to compute into a circuit representation (yes, like in electrical engineering with AND gates and whatnot). 

**Yao's Garbled Circuits (GC)**: One party (the garbler) "garbles" the circuit by successively encrypting wire keys. The other party (the evaluator) follows the path of correct decriptions through the circuit until it obtains the keys corresponding to the output value.  
_Assumptions:_ Secure OT  
_Optimizations:_ Point-and-permute, PRF for encryption, garbled row reduction, half-gates, free XOR.

**Goldreich–Micali–Wigderson (GMW)** (semi-honest version): Construct gates so that parties can step through the circuit using XOR-shares of wires. Multiplication gates require 1-out-of-4 OT to communicate the correct output shares.  
_Assumptions:_ Secure OT

**Goldreich–Micali–Wigderson (GMW)** (malicious version): Same as semi-honest, but use zero-knowledge proofs to ensure well-formedness.  
_Assumptions:_ Secure OT, ZK

**Ben-Or–Goldwasser–Wigderson (BGW)**: Same structure as GMW but over arithmetic circuits (where wires carry field elements). So, instead of using XOR-shares, use (t+1)-out-of-n Shamir secret-sharing. Multiplication gates use a degree-reduction step to maintain the invariant that parties hold well-formed wire value shares.  
_Assumptions:_ None!

**Chaum-Crepeau-Damgård (CCD)**: 

**Beaver-Micali-Rogaway (BMR)**: 

---

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
1990 | BMR      | many | < n               | O(1) | 

## References

Yao's GC: [Original paper](https://ieeexplore.ieee.org/document/4568207)

GMW: 

BMR: [Original paper](https://dl.acm.org/doi/pdf/10.1145/100216.100287?casa_token=jgHhj-wpD88AAAAA:17nxjtduFXBZwYyyvRd9sVKdnPBXZ-vaBxXxzmHFQwhZy_dRc1UGxRnmoXj6WlNRflZ-wRlQA0v-iA), [Rogaway's Thesis](https://www.cs.ucdavis.edu/~rogaway/papers/thesis.pdf), [Pragmatic Introduction to MPC, Section 3.5](https://securecomputation.org/)

BGW: Original paper, [full proof](https://eccc.weizmann.ac.il//report/2011/036/)
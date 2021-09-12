[← Back to Glossary](../glossary.md)

# Multi-Party Computation

Sometimes also referred to as secure multi-party computation (SMC), multi-party computation (MPC) is a functionality in which two or more parties with secret inputs want to compute a joint function <img alt="f" src="https://render.githubusercontent.com/render/math?math=f" style="transform: translateY(20%);" /> on those inputs. More explicitly, for <img alt="N" src="https://render.githubusercontent.com/render/math?math=N" style="transform: translateY(20%);" /> parties with inputs <img alt="x_1, \ldots, x_N" src="https://render.githubusercontent.com/render/math?math=x_1%2C%20%5Cldots%2C%20x_N" style="transform: translateY(20%);" />, an MPC protocol takes those inputs and outputs <img alt="y := f(x_1, \ldots, x_N)" src="https://render.githubusercontent.com/render/math?math=y%20%3A%3D%20f%28x_1%2C%20%5Cldots%2C%20x_N%29" style="transform: translateY(20%);" />.

The protocol should meet a couple of conditions to be interesting/useful:
* None of the parties learn anything about the other parties' inputs (except what they can deduce from the output)
* <img alt="y" src="https://render.githubusercontent.com/render/math?math=y" style="transform: translateY(20%);" /> should be correct. That is, <img alt="y" src="https://render.githubusercontent.com/render/math?math=y" style="transform: translateY(20%);" /> should in fact be the function <img alt="f" src="https://render.githubusercontent.com/render/math?math=f" style="transform: translateY(20%);" /> applied to the parties' inputs – no errors.
Why is this useful? A simple example is Yao's Millionaries' Problem. Two millionaires want to know who's richer, but they don't want to reveal exactly how rich they are. They can run an MPC protocol where the inputs are their net worths and the function <img alt="f" src="https://render.githubusercontent.com/render/math?math=f" style="transform: translateY(20%);" /> computes the sign of <img alt="x_1 - x_2" src="https://render.githubusercontent.com/render/math?math=x_1%20-%20x_2" style="transform: translateY(20%);" />. (For example

<p align="center"><img alt="
f(x_1, x_2) = \begin{cases}
1 	& x_1 > x_2\\
0 	& x_1 = x_2\\
-1 	& x_1 < x_2
\end{cases}
" src="https://render.githubusercontent.com/render/math?math=%0Af%28x_1%2C%20x_2%29%20%3D%20%5Cbegin%7Bcases%7D%0A1%20%09%26%20x_1%20%3E%20x_2%5C%5C%0A0%20%09%26%20x_1%20%3D%20x_2%5C%5C%0A-1%20%09%26%20x_1%20%3C%20x_2%0A%5Cend%7Bcases%7D%0A"/></p>

<!-- <img alt="f(x_1, x_2) = {1 \text{ if } x_1 > x_2, 0 \text{ if } x_1 = x_2, \text{ and } -1 \text{ if } x_1 < x_2}" src="https://render.githubusercontent.com/render/math?math=f%28x_1%2C%20x_2%29%20%3D%20%7B1%20%5Ctext%7B%20if%20%7D%20x_1%20%3E%20x_2%2C%200%20%5Ctext%7B%20if%20%7D%20x_1%20%3D%20x_2%2C%20%5Ctext%7B%20and%20%7D%20-1%20%5Ctext%7B%20if%20%7D%20x_1%20%3C%20x_2%7D" style="transform: translateY(20%);" />.) -->

There are more serious real-world applications for this too. You could imagine using this to let hospitals collaborate on health analytics without sharing their patient records and other similar use cases.

## Building Blocks

**Oblivious Transfer (OT)**: Functionality in which one party holds two strings and the other a selection bit <img alt="b" src="https://render.githubusercontent.com/render/math?math=b" style="transform: translateY(20%);" />. The second party learns the string corresponding to its selection bit and nothing more, while the first party learns nothing about the selection bit.
![Diagram of the OT functionality](./img/OT.png)

OTs with different numbers exist, such as 1-out-of-4 OT (P2 selects one of four choices) or more generally 1-out-of-<img alt="n" src="https://render.githubusercontent.com/render/math?math=n" style="transform: translateY(20%);" /> OT for some parameter <img alt="n" src="https://render.githubusercontent.com/render/math?math=n" style="transform: translateY(20%);" />.

**Secret-sharing**: Splitting a secret between parties so that none of the parties know the secret, but they each have a piece of the information, and if they work together they can recover the secret. Here's a visual intuition:

<a title="Blokhead at English Wikipedia, Public domain, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Visual_crypto_animation_demo.gif"><img width="256" alt="Visual crypto animation demo" src="https://upload.wikimedia.org/wikipedia/commons/0/0e/Visual_crypto_animation_demo.gif"></a>

Schemes:
* **Exclusive OR (XOR) secret-sharing**: For a secret <img alt="s" src="https://render.githubusercontent.com/render/math?math=s" style="transform: translateY(20%);" />, set Party <img alt="i" src="https://render.githubusercontent.com/render/math?math=i" style="transform: translateY(20%);" />'s share to some random value <img alt="r_i" src="https://render.githubusercontent.com/render/math?math=r_i" style="transform: translateY(20%);" />, except for a designated party which gets <img alt="s" src="https://render.githubusercontent.com/render/math?math=s" style="transform: translateY(20%);" /> XOR <img alt="r_1" src="https://render.githubusercontent.com/render/math?math=r_1" style="transform: translateY(20%);" /> XOR <img alt="\ldots" src="https://render.githubusercontent.com/render/math?math=%5Cldots" style="transform: translateY(20%);" /> XOR <img alt="r_N" src="https://render.githubusercontent.com/render/math?math=r_N" style="transform: translateY(20%);" />. The shares XOR together to <img alt="s" src="https://render.githubusercontent.com/render/math?math=s" style="transform: translateY(20%);" />, but each individual share looks random.
* **Shamir secret-sharing**: This is a form of <img alt="(t+1)" src="https://render.githubusercontent.com/render/math?math=%28t%2B1%29" style="transform: translateY(20%);" />-out-of-<img alt="n" src="https://render.githubusercontent.com/render/math?math=n" style="transform: translateY(20%);" /> secret-sharing, i.e., at least <img alt="t+1" src="https://render.githubusercontent.com/render/math?math=t%2B1" style="transform: translateY(20%);" /> out of <img alt="n" src="https://render.githubusercontent.com/render/math?math=n" style="transform: translateY(20%);" /> parties must work together to recover the secret. Shamir secret-sharing gives every party a point on a degree-<img alt="t" src="https://render.githubusercontent.com/render/math?math=t" style="transform: translateY(20%);" /> polynomial. Because <img alt="t+1" src="https://render.githubusercontent.com/render/math?math=t%2B1" style="transform: translateY(20%);" /> points define a unique polynomial, <img alt="t+1" src="https://render.githubusercontent.com/render/math?math=t%2B1" style="transform: translateY(20%);" /> parties can work together to recover it. The secret is the value when the polynomial is evaluated at 0. Interactive demo [here](./ShamirSS.ipynb).
Secret-sharing schemes with additional properties also exist, but basic secret sharing usually suffices for MPC.
* **Homomorphic secret sharing**:
* **Robust secret sharing**: Does not consider a corrupt dealer. ...
* **Verifiable secret sharing (VSS)**: Protects against a corrupt dealer. During the sharing phase, the parties who receive shares from the dealer also run a verification function to confirm that the shares they received are well-formed (will reconstruct properly).
**Cut-and-choose**: This is an idea to turn a semi-honest secure MPC protocol into malicious-secure one. ...

## Properties

**Guaranteed output delivery (GOD)**: The strongest type of correctness guarantee. In a protocol with GOD, an adversary cannot even carry out a denial-of-service attack; the (correct) output will always be learned by the participants.

**Security with abort**:

## Protocols

Most MPC protocols turn the function to compute into a circuit representation (yes, like in electrical engineering with AND gates and whatnot).

**Yao's Garbled Circuits (GC)**: One party (the garbler) "garbles" the circuit by successively encrypting wire keys. The other party (the evaluator) follows the path of correct decriptions through the circuit until it obtains the keys corresponding to the output value.
* _Assumptions:_ Secure OT
* _Optimizations:_ Point-and-permute, PRF for encryption, garbled row reduction, half-gates, free XOR.
**Goldreich–Micali–Wigderson (GMW)** (semi-honest version): Construct gates so that parties can step through the circuit using XOR-shares of wires. Multiplication gates require 1-out-of-4 OT to communicate the correct output shares.
* _Assumptions:_ Secure OT
**Goldreich–Micali–Wigderson (GMW)** (malicious version): Same as semi-honest, but use zero-knowledge proofs to ensure well-formedness.
* _Assumptions:_ Secure OT, ZK
**Ben-Or–Goldwasser–Wigderson (BGW)**: Same structure as GMW but over arithmetic circuits (where wires carry field elements). So, instead of using XOR-shares, use (t+1)-out-of-n Shamir secret-sharing. Multiplication gates use a degree-reduction step to maintain the invariant that parties hold well-formed wire value shares.
* _Assumptions:_ None!
**Chaum–Crepeau–Damgård (CCD)**:

**Beaver–Micali–Rogaway (BMR)**: This can be viewed as an adaptation of Yao's garbled circuit approach to more than two parties while keeping its low round complexity. Use GMW to compute a garbled circuit for the function to evaluate; then, one party evaluates the garbled circuit.
* _Assumptions:_ Secure OT
### Tabular Summary

`n`: number of circuit gates`d`: depth of circuit

YearNameNumber of partiesThreat ModelRound ComplexityCommunication ComplexityFunction Representation1986Yao's GC2semi-honestO(1)O(n)Boolean circuit1987GMWmany< n semi-honestO(d)O(1)Boolean circuit​many< n maliciousBoolean circuit1988BGWmany< n/2 semi-honestO(d)O(d)Arithmetic circuit​many< n/3 maliciousO(d)Arithmetic circuit1988CCDmany1990BMRmany< nO(1)Boolean circuit## References

**Yao's GC**: [Original paper](https://ieeexplore.ieee.org/document/4568207)

**GMW**:

**BGW**: Original paper, [full proof](https://eccc.weizmann.ac.il//report/2011/036/)

**BMR**: [Original paper](https://dl.acm.org/doi/pdf/10.1145/100216.100287?casa_token=jgHhj-wpD88AAAAA:17nxjtduFXBZwYyyvRd9sVKdnPBXZ-vaBxXxzmHFQwhZy_dRc1UGxRnmoXj6WlNRflZ-wRlQA0v-iA), [Rogaway's Thesis](https://www.cs.ucdavis.edu/~rogaway/papers/thesis.pdf), [Pragmatic Introduction to MPC, Section 3.5](https://securecomputation.org/)

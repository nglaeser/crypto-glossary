# Types of Security Proofs

**Black-box** versions of each of these techniques are the strongest proofs in each category. "Black-box" means that the adversary is treated as a "black box" (its inner workings are unknown), that is, the approach must work for any adversary. This affects the order of quantifiers in a proof ("There exists [some technique] such that for all adversaries, the scheme is secure" instead of "for all adversaries, there exists [some technique] such that the scheme is secure".)

## Game-based proofs

Security is defined by a [security game](./general.md) in which an attacker should have _negligible_ _advantage_. For example, [CPA-security](primitives/encryption.md#cpa-security).

<!-- Table of security games. 
Columns: name, primitive (Enc, MAC, etc.), weaker/stronger than -->

**Hybrid argument**
: Often used in game-based proofs, but a similar technique is also used to break down the various changes between the simulator in the real-world protocol in simulation-based proofs (see below).
<!-- "standard" hybrid argument -->

!!! tip "Further Reading"
    ["Sequences of Games: A Tool for Taming Complexity in Security Proofs"](https://eprint.iacr.org/2004/332.pdf) by Victor Shoup

## Proof by Simulation

**Black-box simulation**
: 

!!! tip "Further Reading"  
    [How to Simulate It – A Tutorial on the Simulation Proof Technique](https://link.springer.com/chapter/10.1007%2F978-3-319-57048-8_6) by Yehuda Lindell

## Proof by Reduction

We reduce the security of some scheme B to an [assumption](assumptions.md) A, that is, we wish to show that the security of A implies the security of B (A &rArr; B). 

This is done by contradiction: we instead prove the contrapositive, that if B is insecure, so is A (&not;B &rArr; &not;A). Specifically, we assume the existence of an adversary $A_1$ that breaks the security properties of B, and use it to construct an adversary $A_2$ that can run $A_1$'s code as a subroutine to break the security of A.
<!-- LaTeX examples or exercises of simple schemes -->

<!-- drawing -->

**Reduction tightness**
: A reduction is called _tight_ if...

## Rewinding

cf. **Straight-line proof**
:  

## Universal Composability (UC) Framework

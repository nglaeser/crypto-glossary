# Security Proofs: Types and Techniques

[**Black-box**](./general.md#black-box) versions of each of these techniques (_black-box reduction_, _black-box simulation_, etc.) are the strongest proofs. In a _black-box proof_, the [adversary](./general.md#adversary) is treated as a "black box" (its inner workings are unknown), that is, the approach must work for any adversary. This affects the order of quantifiers in a proof ("There exists &lang;some technique&rang; such that for all adversaries, the scheme is secure" instead of "for all adversaries, there exists &lang;some technique&rang; such that the scheme is secure".)

**Hybrid argument** { #hybrid-arg }
: Often used in [game](./general.md#game)-based proofs, but a similar technique is also used to break down the various changes between the simulator in the real-world protocol in [simulation-based proofs](#proof-by-simulation). We start with a [security game](./general.md#game), then slowly replace pieces of the game (each modified game is a _hybrid game/experiment_) in a way that is induistinguishable to the adversary. Eventually we arrive at a simple game in which the adversary clearly has [negligible](./general.md#negligible) [advantage](./general.md#advantage) (or where this can be shown via a [reduction](#reduction)).

    !!! tip "Further Reading"
        ["Sequences of Games: A Tool for Taming Complexity in Security Proofs"](https://eprint.iacr.org/2004/332.pdf) by Victor Shoup

**Reduction**
: We reduce the security of some scheme B to an [assumption](assumptions.md) A, that is, we wish to show that the assumption A implies the security of scheme B (A &rArr; B). 

    This is done by contradiction: we instead prove the contrapositive, that if B is insecure, A does not hold (&not;B &rArr; &not;A). Specifically, we assume the existence of an adversary $A_1$ that breaks the security properties of B, and use it to construct an adversary $A_2$ that can run $A_1$'s code as a subroutine to break the security of A.
    <!-- LaTeX examples or exercises of simple schemes -->

    <!-- drawing -->

    !!! info "Reduction tightness"
        A reduction is called _tight_ if...

## Proof by Simulation

!!! tip "Further Reading"  
    [How to Simulate It – A Tutorial on the Simulation Proof Technique](https://link.springer.com/chapter/10.1007%2F978-3-319-57048-8_6) by Yehuda Lindell

<!-- TODO -->

<!-- **Black-box simulation**
:  -->

<!-- Types of simulators: extractors, ... -->

**Rewinding**
: When a simulator "rewinds" the [adversary](./general.md#adversary) to a previous step in its execution. A good way to think about this is to remember that the adversary is a (usually [PPT](./general.md#ppt)) algorithm, and even if it is [probabilstic](./general.md#probabilistic) the randomness can be programmed as an input. This means that the simulator can just re-run $\mathcal{A}$ with the same inputs up until a certain point, when it can "branch" from the previous run and try a new response. An example is the proof of [knowledge soundness](./Areas-of-Cryptography/zk.md#knowledge-soundness) of a [Sigma protocol](./Areas-of-Cryptography/zk.md#sigma-protocols).   
A simulator which does not use rewinding is called a **straight-line**.

## Universal Composability (UC) Framework

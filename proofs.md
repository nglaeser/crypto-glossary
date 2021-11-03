# Proof Techniques

**Black-box** versions of each of these techniques are the strongest proofs in each category.

## Proof by Simulation

**Black-box simulation**:

## Proof by Reduction

We reduce the security of some scheme B to an [assumption](assumptions.md) A, that is, we wish to show that the security of A implies the security of B (A ⇒ B).

This is done by contradiction: we instead prove the contrapositive, that if B is insecure, so is A (¬B ⇒ ¬A). Specifically, we assume the existence of an adversary <img alt="A_1" src="https://render.githubusercontent.com/render/math?math=A_1" style="transform: translateY(20%);" /> that breaks the security properties of B, and use it to construct an adversary <img alt="A_2" src="https://render.githubusercontent.com/render/math?math=A_2" style="transform: translateY(20%);" /> that can run <img alt="A_1" src="https://render.githubusercontent.com/render/math?math=A_1" style="transform: translateY(20%);" />'s code as a subroutine to break the security of A.
<!-- LaTeX examples or exercises of simple schemes -->

<!-- drawing -->

**Reduction tightness**: A reduction is called _tight_ if...

## Rewinding

## Universal Composability (UC) Framework

## References
* [How to Simulate It – A Tutorial on the Simulation Proof Technique](https://link.springer.com/chapter/10.1007%2F978-3-319-57048-8_6) by Yehuda Lindell


# Proof Techniques

**Black-box** versions of each of these techniques are the strongest proofs in each category.

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

## Universal Composability (UC) Framework

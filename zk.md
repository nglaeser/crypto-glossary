# Zero-Knowledge

Zero-knowledge (ZK) protocols occur between two parties: a _prover_ and a _verifier_. The prover's goal is to convince the verifier that it knows some witness _w_ for a statement _x_ in some language _L_. The verifier's goal is to be sure the prover knows such a witness.

ZK protocols are only interesting if the prover doesn't want to reveal its witness. (If we didn't care about revealing the witness, the prover could simply send the witness to verifier and we'd be done.)

## Properties

**Argument of knowledge**: 

**Proof of knowledge (PoK)**: Secure against a dishonest prover.

**Witness indistinguishable (WI)**:

**Zero-knowledge (ZK)**: Secure against a dishonest verifier.

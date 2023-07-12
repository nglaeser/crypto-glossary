# Other

**Message authentication code (MAC)** { #mac }
: 

**One-way function (OWF)** { #owf }
: In a way this is also [an assumption](../assumptions.md#other), since we don't know of any function that is provably hard to invert.

**Pseudo-random function (PRF)** { #prf }
: A function that maps inputs to outputs so that the outputs appear randomly distributed. The function is deterministic in the sense that querying it on the same input always returns the same (random-looking) output.

    !!! info "PRF security game"
        <!-- TODO -->

    !!! example "Construction: PRF from PRG [GGM]"
        Given a length-doubling PRG $G: \{0, 1\}^\lambda \rightarrow \{0,1\}^{2\lambda}$, we can construct a PRF $F: \{0, 1\}^\lambda \times \{0,1\}^n \rightarrow \{0,1\}^\lambda$ which takes a $\lambda$-bit key $k$ and $n$-bit input $x$ and outputs a pseudorandom $\lambda$-bit value. The construction is described in [this note](../assets/notes/PRF-from-PRG.png). The idea is to construct a height-$n$ tree of calls to $G$ using $k$ as the root. The output of $F(k,x)$ is determined by following the path given by the bits of $x$.

        Moreover, this construction is in fact a *puncturable* PRF: we can puncture out points by removing the PRG seeds in the tree along the path to that point.

**Pseudo-random generator (PRG)** { #prg }
: 
    !!! info "PRG security game"
        <!-- TODO -->

**Pseudo-random permutation (PRP)** { #prp }
: 

**Time-Lock Puzzle (TLP)** { #tlp }
: 

**Trapdoor function (TDF)** { #tdf }
: 
!!! example "Construction: TDF from SIS"

**Lossy trapdoor function**
: 

## Accumulators

A **cryptographic accumulator** is a primitive that (succinctly) commits to a set of elements. It should also be possible to provide short proofs of (non-)membership of elements in the set. An accumulator is the unordered sibling of a _vector commitment_.

Some accumulator constructions are described below.

**Merkle tree**
: 
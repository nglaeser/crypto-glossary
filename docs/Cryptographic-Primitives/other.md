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
    
    **Puncturable PRF [[SW14]](https://eprint.iacr.org/2013/454)**
    : 

**Pseudo-random generator (PRG)** { #prg }
: 
    !!! info "PRG security game"
        <!-- TODO -->

**Pseudo-random permutation (PRP)** { #prp }
: 

**Time-Lock Puzzle (TLP) [[RSW96]](https://dl.acm.org/doi/abs/10.5555/888615)** { #tlp }
: This is a sort of time-locked [commitment](../Cryptographic-Primitives/commitments.md), which can be opened via some puzzle solving operation that takes at least time $T$ (even up to parallelization, i.e., it solving a puzzle should be a sequential operation).

    Existing constructions:

    - In groups of unknown order (RSA groups [RSW96], class groups [TCLM21])
    - From [indistinguishability obfuscation](../Areas-of-Cryptography/other.md) [BGJ+16]
    - From extractable [witness encryption](../Cryptographic-Primitives/encryption.md#witness-enc)
    - Post-quantum from LWE [[AMZ24](https://eprint.iacr.org/2025/047)]

    Compared to TLPs, **time-lock encryption** enables *immediate*/"automatic" decryption as soon as time $T$ has elapsed (though of course one option for realizing this is to put the decryption key in a TLP and outsource the solving to a third party who will reliably publish the solution as soon as it is found).

**Trapdoor function (TDF)** { #tdf }
: 
    !!! example "Construction: TDF from SIS"

<!-- **Lossy trapdoor function**
    :  -->

# Standard Notation

$\gets$
: Delcare initialize the contents of a variable to the output of an algorithm. e.g., $c \gets \mathsf{Enc}(pk, x)$.

$\gets\!\!\tiny{\$}$
: sample uniformly at random. e.g., $x \gets\!\!\tiny{\$}\ \normalsize\mathcal{X}$ means to sample $x$ uniformly at random from the set (or distribution) $\mathcal{X}$.

$:=$
: Used to declare/initialize the contents of a variable (unless they are output by an algorithm, in which case we use $\gets$). e.g., $y := g^x$

$\{0,1\}^*$ and $\{0,1\}^n$
: The set of binary strings of arbitrary length and length $n$, respectively.

$\mathsf{td}$
: Trapdoor

$\mathbb{Z}_p$
: The group of integers modulo a prime $p$ (sometimes $q$ is used instead), namely $\{0,\dots,p-1\}$. This is a cyclic group, and in fact also a ring, and (since $p$ is prime) it is also a finite field. 

$\mathbb{Z}_n^\times$
: The multiplicative subgroup of $\mathbb{Z}_n$, which consists of all elements of $\mathbb{Z}_n$ that are coprime with $n$. This means that they all have multiplicative inverses modulo $n$ and thus this group is a commutative multiplicative group.
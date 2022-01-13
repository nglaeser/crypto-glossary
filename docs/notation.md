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

$\mathbb{Z}_n$
: The additive group of integers modulo $n$, namely $\{0,\dots,n-1\}$. This is a cyclic group, and in fact also a ring. When $n$ is a prime $p$, all non-identity elements are generators of the group. In that case, the set is also a finite field (since all nonzero elements have multiplicative inverses). 

$\mathbb{Z}_n^\times$ or $\mathbb{Z}_n^*$
: The multiplicative subgroup of $\mathbb{Z}_n$, which consists of all elements of $\mathbb{Z}_n$ that are coprime with $n$. This means that they all have multiplicative inverses modulo $n$ and thus this group is a commutative multiplicative group. When $n$ is a prime $p$, the order of the group is not prime (for $p>3$) and computing the order of any element in the group is efficient if the factorization of $\lvert \mathbb{Z}_p^*\rvert = p-1$ is known. For more number theory/algebra basics, see [David Wu's factsheet](https://www.cs.utexas.edu/~dwu4/courses/fa21/static/algebra.pdf).
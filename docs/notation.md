# Standard Notation

$:=$
: Used to declare/initialize the contents of a variable (unless they are output by an algorithm, in which case we use $\gets$), e.g., $y := g^x$

$\gets$
: Initialize the contents of a variable to the output of an algorithm. e.g., $c \gets \mathsf{Enc}(pk, x)$.

<!-- $\gets\!\!\tiny{\$}$ -->
$\stackrel{\$}{\gets}$ or $\stackrel{R}{\gets}$
: sample [uniformly at random](./general.md#uniform). For example, $x \stackrel{\$}{\gets} \mathcal{X}$ means to sample $x$ uniformly at random from the set (or distribution) $\mathcal{X}$.

$\{0,1\}^*$ and $\{0,1\}^n$
: The set of binary strings of arbitrary length and length $n$, respectively.

$\mathcal{A}$
: [Adversary](./general.md#adversary)

$\mathbb{G}$
: A group

i.i.d.
: [Independent and identically distributed](general.md#iid)

$\mathsf{td}$
: Trapdoor

w.h.p.
: With high probability.

$\mathbb{Z}_n$
: The *additive* [group](./general.md#group) of integers modulo $n$, namely $\{0,\dots,n-1\}$. This is a cyclic group, and in fact also a [ring](./general.md#ring)). When $n$ is a prime $p$, all non-identity elements are generators of the group. In that case, the set is also a finite field (since all nonzero elements have multiplicative inverses). 

$\mathbb{Z}_n^\times$ or $\mathbb{Z}_n^*$
: The multiplicative subgroup of $\mathbb{Z}_n$, which consists of all elements of $\mathbb{Z}_n$ that are coprime with $n$. This means that they all have multiplicative inverses modulo $n$ and thus this [group](./general.md#group) is a commutative multiplicative group. By the definition of [Euler's totient function](https://en.wikipedia.org/wiki/Euler%27s_totient_function), this means that the order of the group is $\lvert \mathbb{Z}_n^* \rvert = \phi(n)$.  
When $n$ is a prime $p$, $\lvert \mathbb{Z}_p^* \rvert = \phi(p) = p-1$ is not prime (for $p>3$). Thus, computing the order of any element in the group is efficient if the factorization of $p-1$ is known.  
For more number theory/algebra basics, see [David Wu's factsheet](https://www.cs.utexas.edu/~dwu4/courses/fa21/static/algebra.pdf).

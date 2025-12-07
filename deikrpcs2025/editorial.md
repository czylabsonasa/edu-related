## deik-rpcs 2025 editorial

### digits-3

- maximum search through different intervals.
- large numbers: it is impossible to precomputate everything. But considering the actual bounds:
  - relatively small number of steps needed (about $30$)
  - small length intervals are of small lengths (max $10^5$)
  - caching/memoization
    - assuming that no more than 30 steps required the upper bound for the complexity of one case (both memory and time) is $30*10^5$.

- [io](digits-3.tgz)
- [html](digits-3.html)


<hr>

###  digits-1
- searching for closest same digit-sum number.
- the brute-force "Loop until you find it" approach is ok for small numbers.
- for $1\_000\_000\_000$ the next number is $10\_000\_000\_000$, which is $O(10^{9})$ steps away $\longrightarrow$ TLE
- an $\mathcal{O}(\text{number of digits})$ approach similar to the **next permutation** algo can be used: 
  - for right neighbour: search for the rightmost (weakest) digit that can be increased by 1. The *can be increased* means it is smaller than 9 and there is a positive digit to its right:
    - $890\_000\_ 000 ~~\longrightarrow~~ 900\_000\_008$
    - right friend is always exist
  - finding a left neighbour is similar: find the rightmost digit that *can be decreased*
    - for $99$ there is no left friend
- [io](digits-1.tgz)
- [html](digits-1.html)

<hr>


### exam-1

- only administration needed to solve it
  - rational arithmetic is not a must.
- the princple of *Linearity of the expectation* is used 
- $\mathcal{O}(Q*N)$
- [io](exam-1.tgz)
- [html](exam-1.html)

<br>

<hr>

### lattice-1
- two nested loops with early break will do the job
- no optimization needed
- [io](lattice-1.tgz)
- [html](lattice-1.html)

<hr>


### optimize-1
- $f$ is an (at most) second order polynomial
- evaluate it at points of $L,R$
- if $\frac{-b}{2a} \in [L,R]$ then, eval $f$ at it and adjust the $min/max$ appropriately 
- $\mathcal{O}(Q+N)$
- it seems trivial, but it not about evaluate $f$ at integer points (and it would too slow)
  - consider $3x^2-x+10$ on $[-3,3]$ it has a minimizer at $-\frac{1}{6}$ and the value is 
  $10.25$. 
  - $f$ is continous!!! Bolzano IVT...
- [io](optimize-1.tgz)
- [html](optimize-1.html)


<hr>

### optimize-2
- $f$ is a piecewise linear function whose breakpoints at $B_k$-s. (and they are different)
- we need its values only at ${1, B_1,\ldots, B_N, M}$
- a single sweep through the values needed to get the maximal profit.
- $\mathcal{O}(N^2) with naive function evaluation:
$N$ operations per location
- it can be lowered to $\mathcal{O}(N)$, but we do not need it
- [io](optimize-2.tgz)
- [html](optimize-2.html)


<hr>


### permutation-1
- first you have to decide about the existence of topological ordering 
  - it can be done with BFS+appropriate administration
- you can get the $K$-th smallest by *recursion/backtracking* 
  - always choose the smallest possible zero indegree node, modify its neighbours indegree, 
  recurse and restore the original indegrees.
  - you wont stuck during the backtracking
  - one ordering can be generated in $\mathcal{O}(N^2)$
- [io](permutation-1.tgz)
- [html](permutation-1.html)

<hr>

### game-1
- smart administration
- [io](game-1.tgz)
- [html](game-1.tgz)

<hr>


### escape-1
- *BFS* with restrictions
- the many bfs will get TLE (probably)
- we need only one BFS but in a reversed way
- [io](escape-1.tgz)
- [html](escape-1.html)
<hr>


### matrix-1
- there is an implicit graph in the background which is a DAG.
- largest to smallest direction
- sort the indices by the values in $M$, then loop through in a reversed way, for each element examine its neighbours in the matrix...
- $\mathcal{O}(RC)$
- [io](matrix-1.tgz)
- [html](matrix-1.html)

<hr>

### primes-1
$a^6<ab^2c^3\le N$<br>
$2b^5<ab^2c^3\le N$<br>
$2~3^2c^3<ab^2c^3\le N$
- we need the primes under $(\frac{N}{2~3^2})^\frac{1}{3}$
- brute-force nested loop approach, several aproaches are possible...
- [io](primes-1.tgz)
- [html](primes-1.html)
<hr>



### lattice-2

- inclusion-exclusion principle
- the popular iterative implementation will TLE
  - pruning is possible
- or one can use the at "most 5" bound and generate all combinations.
- the recursive approach with pruning is fast within the given bounds
- $\mathcal{O}(5*binomial(N,5))$
- [io](lattice-2.tgz)
- [html](lattice-2.html)
<hr>

### github
- i'll put the stuff here [github.com/czylabsonasa/edu-related/deikrpcs2025](github.com/czylabsonasa/edu-related/deikrpcs2025)
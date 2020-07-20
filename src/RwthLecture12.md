_(summary)_

**Base types:** flat domains Z<sub>⊥</sub>, B<sub>⊥</sub>, ...  
**Product domains:** D<sub>1</sub>× ... × D<sub>n</sub>     
**Functions:** D<sub>1</sub> → D<sub>2</sub>. But not all functions are computable → restriction to **monotonic** funtions

---
**Semantics:** the most intresting case: the semantics of recursively defined functions will be defined as lub of a chain of functions.     
**Domains:** E should be complete (i.e., it should be a complete partial ordering) → every chain has a lub.

---

**Thm 2.1.13 (Completeness of Domains)**

Let D<sub>1</sub>, ..., D<sub>n</sub> be domains.
- (a) Every reflexive partial order that has a smallest element and where all chains are finite is complete. Thus, D<sub>Z<sub>⊥</sub></sub>, D<sub>B<sub>⊥</sub></sub>, ... are cpo's.
- (b) If E<sub>D<sub>i</sub></sub> is a cpo for all i then E<sub>D<sub>1</sub>× ... × D<sub>n</sub></sub> is also a cpo.
- (c) If E<sub>D<sub>i</sub></sub> is a cpo, then E<sub>D<sub>1</sub> → D<sub>2</sub></sub> is also a cpo.

**Proof (of (a) + (b). (c) is similar to (b))**

- (a) Let S = { d<sub>1</sub>, ..., d<sub>n</sub> } with d<sub>1</sub> E d<sub>2</sub> E ... E d<sub>n</sub>. Least upper bound exists: it's d<sub>n</sub>!     
    - upper bound, since d<sub>i</sub> E d<sub>n</sub> by transitivity.
    - least upper bound: if e is also an upper bound of S, then d<sub>n</sub> E e, since d<sub>n</sub> ∈ S.
- (b) Smallest element of D<sub>1</sub>× ... × D<sub>n</sub> is (⊥<sub>D<sub>1</sub></sub>, ..., ⊥<sub>D<sub>n</sub></sub>)     
Let S ⊆ D<sub>1</sub> × ... × D<sub>n</sub> be a chain. S = { (d<sub>1</sub><sup>1</sup>, ..., d<sub>n</sub><sup>1</sup>), (d<sub>1</sub><sup>2</sup>, ..., d<sub>n</sub><sup>2</sup>), ... } where (d<sub>1</sub><sup>1</sup>, ..., d<sub>n</sub><sup>1</sup>) E<sub>D<sub>1</sub>× ... × D<sub>n</sub></sub> (d<sub>1</sub><sup>2</sup>, ..., d<sub>n</sub><sup>2</sup>) E<sub>D<sub>1</sub>× ... × D<sub>n</sub></sub> ...   
Thus: d<sub>i</sub><sup>1</sup> E<sub>D<sub>i</sub></sub> d<sub>i</sub><sup>2</sup> E<sub>D<sub>i</sub></sub> ... for all i.    
So S<sub>i</sub> = { d<sub>i</sub><sup>1</sup>, d<sub>i</sub><sup>2</sup>, ... } is a chain for all i.


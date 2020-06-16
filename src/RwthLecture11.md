_(continue)_

Functions with f(⊥) ≠ ⊥ and f(d) ≠ f(⊥) for some d + ⊥ are never computable.    
=> restrict the set of functions that can be use in the definition of the semantics, exclude such "non-monotonic" functions which are not computable.

**Def 2.1.7 (Monotonic functions)**

Let E<sub>D<sub>1</sub></sub>, E<sub>D<sub>2</sub></sub> be orders on D<sub>1</sub> and D<sub>2</sub> respectively. A function f: D<sub>1</sub> → D<sub>2</sub> is monotonic iff

d E<sub>D<sub>1</sub></sub> d' implies f(d) E<sub>D<sub>2</sub></sub> f(d')

*(If the argument becomes more defined than the result of f also becomes more defined. Converse is not true)*

All computable funcitons are monotonic.

Ex.:

    id :: Int -> Int
    id x = x

Semantics of **id** function:
    
    f(x) = x for all x ∈ Z
    f(⊥) = ⊥    otherwise it is not monotonic (not computable)

**Lemma 2.1.8 (Strictness ↷ Monotonicity)**

Let D<sub>1</sub>, ..., D<sub>n</sub>, D domains where D<sub>1</sub>, ..., D<sub>n</sub> are flat. Let f: D<sub>1</sub> × ... × D<sub>n</sub> → D be strict.  
Then f is monotonic.

**Proof:**

(d<sub>1</sub>, ..., d<sub>n</sub>) E<sub>D<sub>1</sub>× ... ×D<sub>n</sub></sub> (d'<sub>1</sub>, ..., d'<sub>n</sub>). To show: f(d<sub>1</sub>, ..., d<sub>n</sub>) E<sub>D<sub>1</sub>× ... ×D<sub>n</sub> → D</sub> f(d'<sub>1</sub>, ..., d'<sub>n</sub>)

- Case 1: (d<sub>1</sub>, ..., d<sub>n</sub>) = (d'<sub>1</sub>, ..., d'<sub>n</sub>). Then clearly f(d<sub>1</sub>, ..., d<sub>n</sub>) E<sub>D<sub>1</sub>× ... ×D<sub>n</sub> → D</sub> f(d'<sub>1</sub>, ..., d'<sub>n</sub>).

- Case 2: otherwise d<sub>i</sub> ≠ d'<sub>i</sub> for some i.  
Since d<sub>i</sub> E d'<sub>i</sub>, d<sub>i</sub> ≠ d'<sub>i</sub>, and D<sub>i</sub> is flat ↷ d<sub>i</sub> = ⊥.    
Since f is strict: f(d<sub>1</sub>, ..., d<sub>i</sub>, ..., d<sub>n</sub>) = ⊥ E f(d<sub>1</sub>, ..., d<sub>n</sub>).  

    _Strictness implies monotonicity._

Since Haskell uses lazy evaluation we also need non-strict (but monotonic) functions in our semantics (Ex. semantics of function "one").

**Def 2.1.9 (Chain)**

Let E an order on a set D. A non-empty subset { d<sub>1</sub>, d<sub>2</sub>, ... } of countably many elements of D is a chain iff d<sub>1</sub> E d<sub>2</sub> E d<sub>3</sub>.

Ex.:    
Z<sub>⊥</sub>   {⊥, 3} - max length 2   
Z<sub>⊥</sub>× Z<sub>⊥</sub>  {(⊥, ⊥), (⊥, 3), (3, 3)} - max length 3   
Z<sub>⊥</sub>→ Z<sub>⊥</sub>  {fact<sub>0</sub>, fact<sub>1</sub> ...} - max length is infinite

fact<sub>n</sub> is an approximation to the factorial function fact

- fact<sub>n</sub> E fact<sub>n+1</sub>   
where fact<sub>n</sub> defined for x < n & fact<sub>n+1</sub> defined for x < n+1

This is because of real factorial function is defined for all natural numbers.

![evaluation of expression](/static/chainfunc.png)

**Def 2.1.10 (Least upper bound)**

Let E an order on a set D, let S ⊆ D. An element d ∈ D is an upper bound of S if d' E d for all d' ∈ S. An element d is the least upper bound (calls _lub_ or _supremum_) if moreover, we have d E e for all other upper bounds e. We denote of lub of S by ⎵ S

For a chain the supremum is the element that is "approximated" by the chain (it must be an element which is bigger or equal than all the elements of this chain and moreover it should be the smallest):

- ⎵ { (⊥, ⊥), (⊥, 3), (3, 3) } = (3, 3)   

![evaluation of expression](/static/least-upper-bound.png)

**Goal:** 
    
    Defined the semantics of recursively defined functions as a lub of a sutable chain.
    Does this lub always exist? Is it always unique?

**Def 2.1.11 (Least upper bounds for products and functions)**

Let D<sub>1</sub>, ..., D<sub>n</sub>, D, D'.

- **(a)** Let S ⊆ D<sub>1</sub> × ... × D<sub>n</sub>. For all 1 ≤ i ≤ n S<sub>i</sub> = { d<sub>i</sub> | there exists (d<sub>1</sub>, ..., d<sub>i</sub>, ...,  d<sub>n</sub>) ∈ S }     
    Then:
    - ⎵ S exists iff all ⎵ S<sub>i</sub> exist  
    - if ⎵ S exists, then ⎵ S = ( ⎵ S<sub>1</sub>, ..., ⎵ S<sub>n</sub>)

For example:

S = { (⊥, ⊥), (⊥, 5), (5, 8) } = (3, 3)   
_(then the S<sub>1</sub> is a projection on the first argument)_   
    
S<sub>1</sub> = { ⊥, 5 }    
S<sub>2</sub> = { ⊥, 8 }    
⎵ S<sub>1</sub> = 5   
⎵ S<sub>2</sub> = 8     
⎵ S = (5, 8)    

- **(b)** Let S be a set of functions from D to D'. _(Now projection means we build set for every argument)_ For all i ∈ D, let S<sub>i</sub> = { f(i) | f ∈ S }.   
    Then:
    - ⎵ S exists iff all ⎵ S<sub>i</sub> exist  
    - if ⎵ S exists, then ( ⎵ S )(i) = ⎵ S<sub>i</sub> for all i ∈ D.

    _(Functions are like (possibly infinite) tuples)_

**Proof (a):**  
_((b) is analogous)_

"<=" To show: if all ⎵ S<sub>i</sub> exist, then ⎵ S = ( ⎵ S<sub>1</sub>, ..., ⎵ S<sub>n</sub>)
    
- **1.** Show that ( ⎵ S<sub>1</sub>, ..., ⎵ S<sub>n</sub>) is an upper bound of S.  
Let (d<sub>1</sub>, ..., d<sub>n</sub>) ∈ S ↷ d<sub>i</sub> ∈ S<sub>i</sub> for all i ↷ d<sub>i</sub> E ⎵ S<sub>i</sub> for all i ↷ (d<sub>1</sub>, ..., d<sub>n</sub>) E ( ⎵ S<sub>1</sub>, ..., ⎵ S<sub>n</sub>)  
- **2.** Show that for all other upper bounds (e<sub>1</sub>, ..., e<sub>n</sub>) of S, we have ( ⎵ S<sub>1</sub>, ..., ⎵ S<sub>n</sub>) E (e<sub>1</sub>, ..., e<sub>n</sub>)  
(e<sub>1</sub>, ..., e<sub>n</sub>) upper bound of S ↷ e<sub>i</sub> is an upper bound of S<sub>i</sub> for all i ↷ ⎵ S<sub>i</sub> E e<sub>i</sub> ↷ ( ⎵ S<sub>1</sub>, ..., ⎵ S<sub>n</sub>) E (e<sub>1</sub>, ..., e<sub>n</sub>)

"=>" Let ⎵ S exists, ⎵ S = (u<sub>1</sub>, ..., u<sub>n</sub>).

To show: u<sub>i</sub> is lub of S<sub>i</sub> (in other words ⎵ S<sub>i</sub> = u<sub>i</sub>)

- **1.** Show that u<sub>i</sub> is upper bound of S<sub>i</sub>.   
    Let d<sub>i</sub> ∈ S<sub>i</sub> ↷ (d<sub>1</sub>, ..., d<sub>i</sub>, ..., d<sub>n</sub>) ∈ S. Since (d<sub>1</sub>, ..., d<sub>i</sub>, ..., d<sub>n</sub>) E (u<sub>1</sub>, ..., u<sub>i</sub>, ..., u<sub>n</sub>), we have d<sub>i</sub> E u<sub>i</sub>.
- **2.** Show that for all other upper bounds e<sub>i</sub> of S<sub>i</sub>, where u<sub>i</sub> E e<sub>i</sub>.  
    e<sub>i</sub> upper bound of S<sub>i</sub> ↷ (u<sub>1</sub>, ..., e<sub>i</sub>, ..., u<sub>n</sub>) upper bound of S.

**Proof schema**: _(if you want to proof that something is least upper bound you can do this in two steps)_     
**1.** Show that element is upper bound     
**2.** Show that element is least upper bound   
_(do this by taking another upper bound and showing that this upper bound is bigger than your least upper bound)_

Essential property which is needed for domains is **compliteness**.

**Def 2.1.12 (Complete partial orders, cpo)**

Reflexive (partial) order E on a set D is called **complete** iff:
- (1) D has a smallest element (denoted ⊥<sub>D</sub>)
- (2) every chain S ⊆ D has a least upper bound ⎵ S ∈ D
---
For those domains D that we looked up to now, E<sub>D</sub> is indeed complete. (Formally a **domain** is a set with a complete partial ordering E<sub>D</sub> and some editional technical properties - needed to prove that Dom<sub>τ</sub> also exists for user-defined data structures).

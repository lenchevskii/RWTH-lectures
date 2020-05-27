##   – 2. Semantics of FP (denotation semantics)
                                ↑ define the semantics by a function
                                from Haskell-expressions
                                to mathematical objects
### - 2.1 Complete partial orders and fixpoints
#### 2.1.1 Partially defined values
Defined the semantics by a fuction
    
                Val: Exp -> Dom
               set of ↑      ↑ set of
    Haskell-expressions      mathematical objects
                             (called "Domain")
---
    Val(5) = 5

    Val(square) = funtion on integers which computes the square of a number
where "square" is a Haskell-expression (square funtion)

    Val(non_term) = function on integers which maps every number to the value ⊥("bottom") - special value which stands for undefined

Domain (domain needed for semantics) should include Z, ⊥, functions, tuples, ...

Since Haskell has types, for every type τ there should be a separate domain Dom<sub>τ</sub>
(expression of type τ are mapped to values Dom<sub>τ</sub>).

    Dom = ∪ Domτ
        τ is a type

Function only regard monomorphic types (i.e., no polymorphism/ no type variables).
Then every Haskell-expression has a unique type.

- Domain for expressions of type Int:
    
    Z<sub>⊥</sub> = {⊥<sub>Z<sub>⊥</sub></sub>, 0, 1, -1, ...}
    
    Val(non_term 0) = ⊥<sub>Z<sub>⊥</sub></sub>,    
    Val(square 5) = 25

- Domain for expressions of type Bool:
    
    B<sub>⊥</sub> = {⊥<sub>B<sub>⊥</sub></sub>, True, False}

Similarly for other base types (Char, Float).   
To compare elements of a domain D by their "definedness", we introduce a relation:  
E<sub>D</sub>("less defined or equal").

"x E<sub>D</sub> y" means x is less defined or equal to y

- Domains like B<sub>⊥</sub>, Z<sub>⊥</sub> are called "flat" (one value is undefined, everything else is defined):

    ⊥<sub>Z<sub>⊥</sub></sub> E<sub>Z<sub>⊥</sub></sub> 0

    ⊥<sub>Z<sub>⊥</sub></sub> E<sub>Z<sub>⊥</sub></sub> 1

    but: 0 ¬E<sub>Z<sub>⊥</sub></sub> 1

(index of E<sub>Z<sub>⊥</sub></sub> is omitted if clear from context)

**Properites of E<sub>D</sub>:**

- Reflexivity: x E<sub>D</sub> x

- Transativity: x E<sub>D</sub> y E<sub>D</sub> z ↷ x E<sub>D</sub> z

- Antisymmetry: x E<sub>D</sub> y and y E<sub>D</sub> x ↷ x = y

**Def. 2.1.1 (E on base domains)**

Let D be a base domain (i.e., Z<sub>⊥</sub>, B<sub>⊥</sub>, C<sub>⊥</sub> (Char), F<sub>⊥</sub>(Float)).    

Then we define for all d, d' ∈ D d E<sub>D</sub> d' iff d = ⊥<sub>D</sub> or d = d'.

Such domains and such orders are called "flat".

---
Expressions of tuple types:

Val((square 5, non_term 0)) = (25, ⊥<sub>Z<sub>⊥</sub></sub>)   
where (25, ⊥<sub>Z<sub>⊥</sub></sub>) is a Cartesian product: Z<sub>⊥</sub>× Z<sub>⊥</sub>

(⊥, ⊥) E<sub>Z<sub>⊥</sub>× Z<sub>⊥</sub></sub> (⊥, 25) E<sub>Z<sub>⊥</sub>× Z<sub>⊥</sub></sub> (25, 25)

**Def. 2.1.2 (Product Domain)**

Let D<sub>1</sub>, ..., D<sub>n</sub> be domains with n ≥ 2. Then D<sub>1</sub> × ... × D<sub>n</sub> is also a domain. We define E<sub>D<sub>1</sub> × ... × D<sub>n</sub></sub> as follows:

(d<sub>1</sub>, ..., d<sub>n</sub>) E<sub>D<sub>1</sub> × ... × D<sub>n</sub></sub> (d'<sub>1</sub>, ..., d'<sub>n</sub>) iff d<sub>i</sub> E<sub>D<sub>i</sub></sub> d'<sub>i</sub> for all i ∈ {1, ..., n}

The **smallest element** (⊥<sub>D<sub>1</sub></sub>, ... ⊥<sub>D<sub>n</sub></sub>) is also defined ⊥<sub>D<sub>1</sub> × ... × D<sub>n</sub></sub>.

**Lemma 2.1.3**

If all E<sub>D<sub>i</sub></sub> are reflexive orders, then E<sub>D<sub>1</sub> × ... × D<sub>n</sub></sub> is also a reflexive order.

**Def 2.1.4 (E on functions)**

Let D<sub>1</sub>, D<sub>2</sub> be domains and f: D<sub>1</sub> → D<sub>2</sub>, g: D<sub>1</sub> → D<sub>2</sub>.

(Formally, the set D<sub>1</sub> → D<sub>2</sub> is not a domain: it would include non-computable functions, which would not correspond to any Haskell program.     
Domain of functions will be a subset of D<sub>1</sub> → D<sub>2</sub>)

We define:

f E<sub>D<sub>1</sub> → D<sub>2</sub></sub> g iff f(d) E<sub>D<sub>2</sub></sub> g(d) for all d ∈ D<sub>1</sub>

The **smallest element** (⊥<sub>D<sub>1</sub> → D<sub>2</sub></sub>) is also defined (d) = ⊥<sub>D<sub>2</sub></sub> for all d ∈ D<sub>1</sub>.

Val(non_term) = ⊥<sub>Z<sub>⊥</sub></sub>→ <sub>Z<sub>⊥</sub></sub>

f<sub>i</sub> : Z<sub>⊥</sub>→ Z<sub>⊥</sub> :

f<sub>0</sub>(⊥) = ⊥    
f<sub>0</sub>(x) = x for x ∈ {0}    
f<sub>0</sub>(x) = ⊥ for x ∉ {0}    


f<sub>1</sub>(⊥) = ⊥    
f<sub>1</sub>(x) = x for x ∈ {0,1}    
f<sub>1</sub>(x) = ⊥ for x ∉ {0,1}

f<sub>2</sub>(⊥) = ⊥    
f<sub>2</sub>(x) = x for x ∈ {0,1,2}    
f<sub>2</sub>(x) = ⊥ for x ∉ {0,1,2}

...

f<sub>0</sub> E<sub>Z<sub>⊥</sub></sub>→ <sub>Z<sub>⊥</sub></sub> f<sub>1</sub> E<sub>Z<sub>⊥</sub></sub>→ <sub>Z<sub>⊥</sub></sub> f<sub>2</sub> E<sub>Z<sub>⊥</sub></sub>→ <sub>Z<sub>⊥</sub></sub>f<sub>3</sub> ... infinite chain, values get more and more define

**Lemma 2.1.5 If E<sub>D<sub>2</sub></sub> is a reflexive order, then E<sub>D<sub>1</sub> → D<sub>2</sub></sub> is also a reflexive order**

Proof: Transitivity: f E<sub>D<sub>1</sub> → D<sub>2</sub></sub> g E<sub>D<sub>1</sub> → D<sub>2</sub></sub> h

↷ f(d) E<sub>D<sub>2</sub></sub> g(d) E<sub>D<sub>2</sub></sub> h(d) for all d ∈ D<sub>1</sub>

↷ f(d) E<sub>D<sub>2</sub></sub> h(d) for all d ∈ D<sub>1</sub>    
↑ by transitivity   
of E<sub>D<sub>i</sub></sub>

↷ f E<sub>D<sub>1</sub> → D<sub>2</sub></sub> h

Antisymmetry and reflexivity work analogous.

**2.1.2 Monotonic and continuous Functions**

Define which functions from D<sub>1</sub> → D<sub>2</sub> can be used when defining the semantics of Haskell.   
We only use total funtions (but fns may have the result ⊥). Since our domain include ⊥, functions often have to be the extended to operate on ⊥ as well.

**Def 2.1.6 (Extention + Strictness of Functions)**

Let f : A → B be a function. Any function f' : A<sub>⊥</sub> → B is an extension of f if A<sub>⊥</sub> = A ∪ {⊥<sub>Z<sub>⊥</sub></sub>} and f(d) = f'(d) for all d ∈ A.

A function g D<sub>1</sub> × ... × D<sub>n</sub> → D for domains  D<sub>1</sub> ..., D<sub>n</sub>, D is **strict** if g(d<sub>1</sub>, ..., d<sub>n</sub>) = ⊥<sub>D</sub> whenever d<sub>i</sub> = ⊥<sub>D<sub>i</sub></sub> for some i ∈ {1, ... n}.

    Strict means if some argument is undefined then the result is undefined.

Otherwise, g is **non-strict**.


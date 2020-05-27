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

Since Haskell has types, for every type τ there should be a separate domain Domτ
(expression of type τ are mapped to values Dom<sub>τ</sub>).

    Dom = ∪ Domτ
        τ is a type

Function only regard monomorphic types (i.e., no polymorphism/ no type variables).
Then every Haskell-expression has a unique type.

- Domain for expressions of type Int:
    
    Z<sub>⊥</sub> = {⊥<sub>Z</sub>, 0, 1, -1, ...}

### 1.1.4 Types

    HASKELL-types
        • type          : (tyconstr type1…typen), n ≥ 0
                        Bool, Int, Float, Char
        (Don’t confuse them with data constructors: True, False)
        • [ ]           : this is (pre-defined) unary type-constructor
                        [Int]   (list of elements of type Int)
        • →             : type constructor of arity 2
                        [Int] → Int
        • (…)           : type constructor of arbitrary arity
                        (Int, Int → Bool, [Char])
        • var           : type variable:

**Parametric polymorphism**

Polymorphic functions are functions which are be applied to arguments of different types.

    • Parametric polymorphism: use the same implementation of the function for all types of arguments
    • Ad-hoc polymorphism: different implementation of the same function, depending of the types of the arguments

In general, a function of type *type<sub>1</sub> → type<sub>2</sub>* can be applied to an expression of type *type* if there is a substitution  **σ** of type variables such that  *σ(type<sub>1</sub>) = σ(type)*. The result has the type *σ(type)*:

            [True]  ++      [ ]	σ([Bool]) = σ([a])  Unification:    σ = [a/Bool, b/Bool]
    Type:	[Bool]  Type:   [b] σ([b]) = σ([a])		The result has type σ([a]) =  [Bool]

**Declaration of new types (a type constructors)**

Only on top level, not in local declarations.

    • type          : type synonym (abbreviation of existing types)
        type Position = (Float, Float)
            - “Position” is a new type constructor of arity 0
        type String = [Char]
        type Pair a b = (a, b)

**Type synonyms a not recursive**: newly defined type constructor may not appear of its **rhs** of its definition.

    • data          : introduction of new data structures

Describe how objects of the new data type are constructed using a kind of EBNF-like (context free grammar).     
Data declaration lists all data constructors of the new data types.
    
    data Color = Red | Yellow | Green


**Definition of natural numbers**

    data Nats = Zero | Succ Nats    
                             ↑ this is argument type of the function Succ
    Zero :: Nats
    Succ :: Nats → Nats

**Definition of lists**

    data List a = Nil | Cons a (List a)

**Typeclasses**

Is a set of types. Its elements are called **instances** of the class. Typically, the instances have the same functions, but with different implementations (overloading) → ad-hoc polymorphism.

    class Eq a where 
        (==), (/=) :: a → a → Bool
        x /= y = not x == y
    
    Default implementations of every type which is a member of Eq, one has the functions == and /=.
---
    HASKELL-classes and instances
        • cdecl         : | class tyconstr var [where {cdecl1:…:cdecln}], n ≥ 1
                        | instance tyconstr instype [where {cdecl1:…:cdecln}]

        • cdecl         : typedecl | fundecl | infixdecl | var rhs
        • instype       : (tyconstr var1 … varn), n ≥ 0
                        | [var]
                        | (var1 → var2)
                        | (var1,…, varn), n ≥ 2

    instance Eq Int where 
        (==) = primEqInt
---
    HASKELL-context
        • context       : (tyconstr1 var1,…, tyconstrn varn), n ≥ 1
        • typedecl      : var1,…, varn :: [context ⇒] type, n ≥ 1
        • topdecl       : data [context ⇒] tyconstr var1…varn =
                            tyconstr1 type1,1 … type1,n1 |
                            tyconstrk typek,1… typek,nk, n ≥ 0, k ≥ 1,  ni ≥ 1
                        | class [context ⇒] tyconstr var [where {cdecl1:…:cdecln}]
                        | instance [context ⇒] tyconstr instype
                                    | [where {cdecl1:…:cdecln}]

    instance Eq a ⇒ Eq [a] where
                ↑ context (if a is a member of Eq, then list of a should been also be the member of Eq)
            [ ] == [ ] = True
            (x:xs) == (y:ys) = x == y && xs == ys
     equality depends on the type↑	         ↑ equality on type [a]

This is **ad-hoc polymorphism**.

### 1.1.3 Patterns
Patterns are special terms which describe the form of arguments to a function.  
Most patterns are terms from variables and data constructors.

**Evaluation** with pattern matching:

        append :: [Int] → [Int] → [Int]
        append [ ] ys       = ys
        append (x : xs) ys  = x : append xs ys      this is a pre-defined function: ‘++’
Ex:

        len (append [1] [2] )
        = len (1 : append [ ] [2])
        = 1 + len (append [ ] [2])
        = 1 + len [2]
        = 1 + 1 + len [ ]
        = 1 + 1 + 0
---
    Pattern matching in pattern declaration:
	    let x:xs = [1, 2, 3] in xs
Pattern must be linear (no variable may occur more than once).

    HASKELL-patterns
        • var               : matches every expression
        • ‘_’               : matches every expression, no variable is instantiated (may appear several times on the lhs of an equation)
        • integers, strings : patterns only match themselves
        • constr pat1 … patn: matches values that start with the same data constructor constr, provided that pati matches the i-th argument
            len [ ]         = …
            len (:) x xs    = …
        • var @ pat         : matches those expression that pat matches, but moreover,variable is instantiated by the whole expression
            f [ ]       = [ ]
            f (x : xs)  = x : x : xs
        can be rewrite as following:
            f [ ]           = [ ]
            f ys @ (x : xs) = x : ys        (where ys = (x : xs))
        • var + integer     : var + k, k ≥ n, var is instantiated with n – k
            sub7 :: Int → Int
            sub7 (x + 7) = x
        • [pat1, … patn]
            has_length_three :: [Int] → Bool
            has_length_three [x, y, z]  = True
            has_length_three _          = False
        • (pat1, … patn)    : matches tuples with n components, if pati matches the i-th component

Patterns are essentially linear terms of variables and data constructors.   
Pattern matching works from left to right.

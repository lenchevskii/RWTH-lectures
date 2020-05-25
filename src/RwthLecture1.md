## – Introduction in Functional Programming (RWTH Aachen University)

### Properties:
    • No loops, just recursion
    • Parametric polymorphism – polymorphic type system in Haskell
    • Referential transparency – the same result of the functions
    • Automatic memory management 
    • High-order functions – functions are first-class citizens
    • Lazy evaluation – only evaluate those parts of an expression which are needed to compute the result

### Advantages:
    • Programs shorter, cleaner
    • Less bugs during programming, hence, more reliable
    • Faster development programs
## – 1. Introduction in Functional Programming Language Haskell

### - 1.1 Basic constructs of Haskell (programming technics in functional languages)

#### 1.1.1 Declarations
The functional program is a sequence of declarations, below each other without indents.     
Easiest declarations describe functions.    
Define Haskell syntax by a context-free grammar.    
Type declarations: describe types of arguments and results of a function.
Function declaration: describe what function does.

    • Type declaration: 	    square :: Int → Int
    • Function declaration:	    square x = x * x
    				              lhs       rhs
where **lhs** is a left hand side, and **rhs** is a right hand side, **x** is a ‘pattern’
    
    • Evaluation of expression

Evaluation strategy does not determine the result (the result always the same), but it determines the termination behavior and efficiency.

    • Innermost evaluation: always evaluate as far to the inside as possible (evaluate the argument first) – call-by-value / eager-evaluation
    • Outermost evaluation: only evaluate arguments if necessary – call-by-name

Advantages of the outermost evaluation: only evaluate sub-expressions that are necessary to compute the result.     
Disadvantages of the innermost evaluation: identical sub-expressions are evaluated many times.

Haskell: **Lazy evaluation = leftmost outermost evaluation**, but one keeps track of duplicated arguments to avoid repeated evaluation of identical subexpressions.

Termination behavior depends on evaluation strategy:

If any evaluation terminates, then outermost evaluation terminates as well:

        non_term :: Int → Int			three :: Int → Int
        non_term x = non_term (x + 1)	three x = 3

The question is: what happens if we evaluate the following term:

    three (non_term 0)
    Innermost eval: = three (non_term 0 + 1) = …
    Outermost eval: = 3
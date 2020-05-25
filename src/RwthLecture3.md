_(continue)_

    • Patterns declaration:

Like function declaration:

        var pat1, pat1, pat1… = exp | …, n ≥ 1
        pat1 = exp (pattern = just expression)

variables

        pi :: Float
        pi = 3,1416

        suc :: Int → Int
        suc = plus 1    (successor)	(this notation form can exist because of currying)

tuples

        x0, y0 :: Int
        (x0, y0) = (1, 2)

Patterns are special terms such that: if one assigns a value to a pattern, then it is clear which value each variable in this pattern has.

Terms built using data constructors:

        x1, y1 :: Int
        [x1, y1] = [1, 2]

        x2 :: Int
        y2 :: [Int]
        x2 : y2 = [1, 2]
Inside a declaration one can define local declaration (keyword `where`).

    • Local declaration

    HASKELL-declarations
    decl        →   typedecl | fundecl | patdecl

    typedecl    →   var1 … varn :: type, n ≥ 1

    var         →   string starting with lower case symbol

    fundecl     →   funlhs rhs

    funlhs      →   var pat1 … patn, n ≥ 1

    rhs         →   exp | condrhs1 … condrhsn, n ≥ 1
    condrhs     →   | exp = exp

    patdecl     →   pat rhs [where decls]
    decls       →   {decl1 … decln}, n ≥ 1

Notation: offside-rules for denoting declarations:

    1. The fist symbol in a sequence of declarations determines the left border of declaration block.
    2. A new line, which starts at the same left border is a new declaration of the same block.
    3. A new line, which starts right to the left border belongs to the same declaration as a line above.
    4. A new line, which starts to the left of the left border means that current declaration block has ended, and this line doesn’t below …
---

    • Operators and infix-declaration:
Such infix-function symbols are called operators.   
Infix symbols:
    
    var: sequences with special symbols (no letters, no numbers), not starting with ‘:’ (like +, –, ==, …)
    cons: ––––––––––––––– / –––––––––––––––, starting with ‘:’

Every infix symbol can be turned into a prefix symbol by using ( ).     
Every prefix symbol can be turned into an infix symbol by using \` `.

**Problems with infix-declaration:**
    
    1. Association
        divide :: Float → Float → Float
        divide x y = x/y    ?: what is the result: 36 `divide` 6 `divide` 2

One has to determine whether \`divide\` associates to the left or to the right or not at all (one means program).   

Add the following infix declaration:
	
        infixl `divide` → means (36 `divide` 6) `divide` 2 (default association)
        infixr `divide` → means 36 `divide` (6 `divide` 2)
        infix `divide`  → expression “36 `divide` 6 `divide` 2”  would be an error
---

    2. Binding priority
        (%%) :: Int → Int → Int     (@@) :: Int → Int → Int 
        x %% y = x + y              x @@ y = x * y

Add infix-declaration:

    infixl 9 %%     – operators with higher binding priority are executed first
    infixl 8 @@     – if the operators have the same binding priority then execution starts with the leftmost operator
		9 is the default.

#### 1.1.2 Expressions

Every expression has a type and expression can be evaluated.    
**Evaluation:** first check weather expression is a well-typed and only then evaluate it.

    HASKELL-expressions:
        • var                   (x, square, +, …)
        • constr                data constructors, used to build objects of a data type (True, False, :, [ ]…)
        • integer               (type Int)
        • float                 (type Float)
        • char                  (type Char)
        • [exp1, … expn], n ≥ 0	list of expressions. Every expression has to be the same type 
        • strings               list of characters (type String = [Char])
        • (exp1, … expn), n ≥ 0 tuples
        • (exp1 … expn), n ≥ 2  this means application (exp1 applied to the exp2)
    Parentheses can be dropped if there is no ambiguity.
        • if exp1 then exp2 else exp3
    maxi(x, y)  | x >= y    = x
                | otherwise = y
        • let decls in exp
        • case exp of {pat1 → exp1; … patn → expn}, n ≥ 1 	– patlast : pattern matching inside the declaration
        und True y  = y
        und False y = False
    can rewrite as following:
        und x y = case x of
                    True → y
                    False → False
        • \ pat1 … patn → exp	represent the function that takes n arguments of the form pat1 … patn and then return exp
        (\ x → 2 * x) 5 – apply function to 5
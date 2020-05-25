**Typeclass Show**

The class Show is defined like this:

        class Show a where
            show :: a → String 
        
If an expression is evaluated in the interpreter, then afterword, the function show is called to convert the result into a string, which is printed on the screen.

        data List a = Nil | Cons a (List a) deriving Show
    (deriving gets us default implementation)

instance Show a ⇒ Show (List a) where
	show Nil = “[ ]”
	show (Cons x xs) = show x ++ “ : “ ++ show xs
				  ↑ implementation depends on type a

**Hierarchical organization of type classes**

Ex.: Type class Ord types with functions <, >, <=, >=, …     
Only types that are in Eq may also be in Ord. Hence, Ord is a subclass of Eq.

        class Eq a ⇒ Ord a where 
            (>), (<) :: a → a → Bool
            x < y = x <= y && x /= y
---
### - 1.2 Higher-order functions

HO is a function with argument or result is again a function.

        square  :: Int → Int            : First-order function
        plus    :: Int → (Int → Int)    : HO

    Function composition
        (.) :: (b → c) → (a → b) → a → c
        f . g = \x → f (g x)    : where g x – b, f (g x) – c, x – a
                        (half . square) 4 = 4*4/2 = 8

Use of HO-functions for programming: HO-functions can implement certain recursion structures. They can be reused many times for different specific applications => Readability, reusability etc. are increased.

#### 1.2.1 Map, filter, fold

The function **map**:

        map :: (a → b) → [a] → [b]      : g should be an additional input to f 
        map g [] = []                 g :: a → b
        map g (x:xs) = g x : map g xs

The function **filter**:

        dropEven :: [Int] → [Int]
        dropEven [] = []
        dropEven (x:xs) | odd x     = x : dropEven xs
                        | otherwise = dropEven xs
	
        filter :: (a → Bool) → [a] → [a]
        filter g []     = []
        filter g (x:xs)
                        | g x       = x : filter g xs
                        | otherwise = filter g xs

The function **fold**:

        add :: (List Int) → Int             prod :: (List Int) → Int
        add Nil         = 0                 prod Nil            = 1
        add (Cons x xs)	= plus x (add xs)   prod (Cons x xs)    = times x (prod xs)

    add Cons 1 (Cons 2 Nil) = 3
                  ↑ [1,2] 

        fold :: (a → b → b) → b (List a) → b
        fold g e Nil            = e
        fold g e (Cons x xs)    = g x (fold g e xs)

The idea of fold function on any data type is **replace the data constructors** by new functions.

    For an arg:	Cons x1 (Cons x2 (Cons xn Nil)
    add gives:	plus x1 (plus x2 (plus xn 0)
    prod gives:	times x1 (times x2 (times xn 1)
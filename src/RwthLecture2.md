_(continue)_

    • Conditional defining equations:
        maxi :: (Int, Int) → Int
        maxi (x, y)     | x >= y    = x
                        | otherwise = y
    • Currying:
        plus :: Int → (Int → Int)
	    plus x y = x + y
    
    which can also write Int → Int → Int (because of right associativity)
    
    • Function definition by pattern matching:
        und :: Bool → Bool → Bool
        und	True 	y	= y
        und	False 	y 	= False

Patterns can describe the potential form of the argument using data-constructors of the respective data type.   
Constructors always start with a capital letter.

Checking works from left to right from top equation to bottom.

        unclear :: Int → Bool
        unclear x = not (unclear x)

Interesting question: what happens if evaluate the following term:
    
        und False (unclear 0)   = False

on the other hand:

        und (unclear 0) False 	= doesn’t terminate

because first argument will be evaluated infinitely. 

    • Pattern matching for lists:
        [data] → [] | data : [data]     List constructors: [ ], (:)

Potential arguments can be described by terms just containing variables and constructors.

_(**n+k** pattern have been removed from the language)_
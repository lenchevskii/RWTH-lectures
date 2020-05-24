module RwthLecture8(hamming, putString, echo) where

import Text.Printf(printf)
-- import Text.Format(format)
-- 1.3 Programming with lazy evaluation
-- Hamming numbers

-- if a non-function variable occurs in right hand side of its definition => circular data object

-- merge two lists removing duplicates
mer :: Ord a => [a] -> [a] -> [a]
mer (x:xs) (y:ys)   | x < y     = x : mer xs (y:ys)
                    | x == y    = x : mer xs ys
                    | otherwise = y : mer (x:xs) ys

-- circular data object (calculate Hamming's numbers list)
hamming :: [Integer]
hamming = 1 : mer (map (2*) hamming) (mer (map (3*) hamming) (map (5*) hamming))

-- 1.4 Monads
-- (>>) - (double greater) pronounced 'then'. This operation is used to composed actions.
-- The result is the action.
putString :: String -> IO ()
putString []       = return ()
putString (x:xs)   = putChar x >> putString xs

-- Type IO() only contains output actions. For input actions: IO a.
-- IO a - is an action which encapsulates (computes) an object of type a.
-- "return" can be used to obtain empty actions for all type IO a.
-- return '!' - it is an action which does nothing but it encapsulates '!'.

--      (>>) :: (IO a) -> (IO b) -> (IO b)

-- In the expression
--      getChar >> return ()
-- we don't get the character because it is obtained and immediately forgotten

-- To compose actions, where action 2 can access the value computed by action 1:
--      (>>=) :: IO a -> (a -> IO b) - IO b     -- function which called "bind"

echo :: IO ()
echo = getChar >>= putChar

gets :: Int -> IO String
gets 0      = return []
gets (n)  = getChar >>= \x -> 
                gets (n-1) >>= \xs -> 
                    return (x:xs)
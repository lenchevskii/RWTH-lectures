module RwthLecture7(primes, qsort) where
-- 1.2.2 List comprehensions
-- Mathematics:	{x*x | x ∈ {1,…, 5}, odd(x)} = {1, 9, 25}
-- Haskell:	[x*x | x ← [1..5], odd x] = [1, 9, 25]

-- General form of list comprehensions: [exp | qual1,…, qualn]
-- where qual is a qualifier:
--  2 forms of qualifiers:
-- 		Generators:     var ← exp
-- 		Guards:         Boolean expression, restrict the values

-- Formal definition is as follows (list comprehensions are just abbreviations for expressions, which use the higher-order function map):
--     • [exp | var ← exp`, Q] = concat (map f exp`)
-- where f var = [exp | Q]
--     • [exp | exp`, Q] = if exp then [exp | Q] else [ ]
--     • if Q is empty then [exp | Q] stands for [exp]

-- map with list comprehensions:
--      map g xs = [g x | x ← xs]
-- quicksort:
qsort :: Ord a => [a] -> [a]
qsort []        = []
qsort (x:xs)    = qsort l1 ++ [x] ++ qsort l2
                    where   l1 = [y | y <- xs, y < x]
                            l2 = [y | y <- xs, y >= x]

--   1.3 Programming with lazy evaluation
-- Evaluation in Haskell:
--     • in general: leftmost outermost evaluation
--     • pre-defined arithmetic operators and comparison operators require that their arguments are first evaluated completely
--     • for pattern matching, arguments are only evaluated as much as needed
-- Ex.:
--      infinity :: Int             mult :: Int → Int → Int         mult 0 y = 0
--      infinity = infinity + 1     mult 0 y = 0
--                                  mult (x + 1) y = y + mult x y

-- Sieve of Eratosthenes
drop_mult :: Int -> [Int] -> [Int]
drop_mult x xs = [n | n <- xs, n `mod` x /= 0]

drop_all :: [Int] -> [Int]
drop_all (x:xs) = x : drop_all (drop_mult x xs)

primes :: [Int]
primes = drop_all [2..]

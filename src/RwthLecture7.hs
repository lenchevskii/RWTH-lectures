module RwthLecture7(primes) where
--   1.3 Programming with lazy evaluation

-- Sieve of Eratosthenes
drop_mult :: Int -> [Int] -> [Int]
drop_mult x xs = [n | n <- xs, n `mod` x /= 0]

drop_all :: [Int] -> [Int]
drop_all (x:xs) = x : drop_all (drop_mult x xs)

primes :: [Int]
primes = drop_all [2..]

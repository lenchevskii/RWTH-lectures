module RwthLecture8(hamming) where
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

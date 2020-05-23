module Main where

import RwthLecture7(primes)
import RwthLecture8(hamming)

main :: IO ()
main = do
    print (take 10 hamming)
    print (take 100 primes)
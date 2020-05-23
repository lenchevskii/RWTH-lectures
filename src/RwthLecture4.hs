module RwthLecture4 where
--   1.1 Basic constructs of Haskell 
-- 1.1.3 Patterns

-- var @ pat		        : matches those expression that pat matches, but moreover, variable
--                          is instantiated by the whole expression
f []        = []
f (x:xs)    = x:x:xs
-- can be rewrite as following:
f []            = []
f ys @ (x:xs)   = x:ys        -- (where ys = (x : xs))
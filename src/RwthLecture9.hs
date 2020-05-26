module RwthLecture9() where
-- Monads encapsulate values (e.g., IO a).
--                                  ↑ An object of type a is encapsulated in the
--                                  object of type IO a. Access to the a-object
--                                  only via certain operations (e.g., >>=)
-- "do"-Notation to ease readability of programs with monads.

-- Instead of       p >>= \x ->      one can write       do  x <- p
--                           q                               q

-- Instead of       p >>= \x ->      can be written      do  x <- p
--                      q >>= \y ->                          y <- q
--                             r                             r

-- Defenition of "do":
-- 1. do x <- p     = p >>= \x ->
--            s             do s
-- 2. do p          = p >> do s
--       s
-- 3. do p          = p

-- Advantages of I/O with monads:
-- • clear separation between i\o-parts of the program and between the rest
-- (without side effects)
-- → Values which depends on the outside world are encapsulated in (IO a)-objects
-- and they can never be taken out of such objects. → The values of Haskell-
-- expressions never depend on outside referenctiol transparency
-- => There is no function of the form:
-- result :: IO Char -> Char        which would give the encapsulated value
--           IO a -> a              of an (IO a)-object as its result
-- But monads can also be useful for other proposes then I/O.

-- 1.4.2 Programming with Monads
-- Monads are pre-defined in Haskell:
-- class Monad m where
--      return :: a  -> m a
--      (>>=) :: m a -> (a -> m b) -> m b
-- • "Monad" is not a type class, but "constructor class".
-- => "m a" is a type (m is a unary type constructor)

-- instance Monad IO where
--      return  = ...
--      ...

-- In Haskell every unary type constructor that implements return, >>= ...
-- can be an instance of Monad.
-- But this implementations should satisfy the following 3 Monad laws:

--      1. p >>= return         = p        (return is right-mutual with >>=)
--         ↑ m a    ↑ a → m a     ↑ m a

--      2. return x >>= f       = f m

--      3. (p >>= \x -> q) >>= \y -> r    =     p >>= \x -> (q >>= \y -> r)
--          ↑ m a  ↑ a  ↑ m b   ↑ r  ↑ m c
--      (>>= is assotiative)

-- Advantage of monads (in addition to IO):
--      modularity of programs, programs which are especially easy to modify
-- Ex: Evaluator for arithmetic terms
-- Without monads stepwise improvement of the program requires many changes,
-- whereas with monads it requires only very few changes at certain points,
-- which can be identified clearly.

data Term = Con Float | Div Term Term deriving (Show)

-- 1. Simple evaluation (without monads):
-- Func eval1 takes a Term and returns an object of a type which can be printed
-- on the screen (e.g., the result type should be a member of Show)

data Value a = Result a

instance Show a => Show (Value a) where
    show (Result x) = "Result: " ++ show x

-- With the implementation of show for type Value a, the object (Result 6) would
-- be printed as "Result: 6"

t1 = Div (Con 6) (Con 3)    -- stands for 6/3
t2 = Div (Con 1) (Con 0)    -- stands for 1/0

eval1 :: Term -> Value Float
eval1 (Con x)   = Result x
eval1 (Div t u) = Result (x/y)
                    where   Result x = eval1 t
                            Result y = eval1 u

-- eval1 t1 ↷ Result: 2.0
-- eval1 t1 ↷ Error, Division by zero

-- 2. Evaluation with exception handling (without monads):
-- Maybe is like Value ("Result" = "Just"), but there is another data constructor
-- "Nothing" to represent exceptions.

eval2 :: Term -> Maybe Float
eval2 (Con x)   = Just x
eval2 (Div t u) = case eval2 t of
                    Nothing -> Nothing
                    Just x  -> case eval2 u of
                                Nothing -> Nothing
                                Just y  -> if y == 0
                                              then Nothing
                                              else Just (x/y)

-- => requires a lot of changes in the eval-function (would be even worse if we 
-- also had terms built with Plus, Minus, Times, ...)

-- 1. Simple evaluation (with monads)
-- Value is the identity monad.

instance Functor Value where  
    fmap f (Result x) = Result (f x)  

instance Applicative Value where
    pure                        = Result
    (Result f) <*> something    = fmap f something

instance Monad Value where
    return          = Result
    Result x >>= q  = q x

eval1M :: Term -> Value Float
eval1M (Con x)      = return x
eval1M (Div t u)    = do x <- eval1M t
                         y <- eval1M u
                         return (x/y)

-- Advantage: main program (eval) almost the same when performing changes, only
-- the implementation of return and >>= changes.

-- 2. Evaluation with exception handling (with monads)
-- Maybe is the error monad.

data Matrix a = Empty | Cons a [a] [a] (Matrix a)
  deriving (Eq,Show)

--   1 2
--   3 4
m1 :: Matrix Integer
m1 = Cons 1 [2] [3] (Cons 4 [] [] Empty)

--   42 1 -2
--    3 1  2
--   -9 3  4
m2 :: Matrix Integer
m2 = Cons 42 [1,-2] [3,-9] m1

--   2.0  1.0    3.2    4.1
--   3.2  9.9    5.323 56.4123
--   1.4 15.323  0      0
--   1.0  7.4993 0      1 
m3 :: Matrix Double
m3 = Cons 2.0 [1.0,3.2,4.1] [3.2,1.4,1.0]
         (Cons 9.9 [5.323,56.4123] [15.323,7.4993]
               (Cons 0 [0] [0] (Cons 1 [] [] Empty)))

matrixToList :: Matrix a -> [[a]]
matrixToList Empty = []
matrixToList (Cons a r c m) = [a:r]
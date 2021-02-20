data Matrix a = Empty | Cons a [a] [a] (Matrix a)
  deriving (Eq,Show)

matrixToList :: Matrix a -> [[a]]
matrixToList Empty = []
--case with a single row matrix
matrixToList (Cons a r [] Empty) = [a:r]
--case with a single column matrix
matrixToList (Cons a [] c Empty) = [a] : map (: []) c
matrixToList (Cons a r c m) = (a:r) : zipWith (:) c (matrixToList m)

listToMatrix :: [[a]] -> Matrix a
listToMatrix [] = Empty
listToMatrix (x:xs) 
-- to cover the case where we have a list of empty lists ex. [[],[]]
  | null x = Empty
  | otherwise = 
    Cons (head x) (tail x) (map head xs) (listToMatrix (map tail xs))

mapMatrix :: (a -> b) -> Matrix a -> Matrix b
mapMatrix _ Empty = Empty
-- mapMatrix f (Cons a r c Empty) = Cons (f a) (map f r) (map f c) Empty
mapMatrix f (Cons a r c m) = Cons (f a) (map f r) (map f c) (mapMatrix f m)

negMatrix :: Num a => Matrix a -> Matrix a
negMatrix = mapMatrix (\x -> - x)

scalarMul :: Num a => a -> Matrix a -> Matrix a
scalarMul a = mapMatrix (a *)

addMatrix :: Num a => Matrix a -> Matrix a -> Matrix a
addMatrix Empty Empty = Empty
addMatrix (Cons a1 r1 c1 m1) (Cons a2 r2 c2 m2) 
  = Cons (a1 + a2) (zipWith (+) r1 r2) (zipWith (+) c1 c2) (addMatrix m1 m2)

subMatrix :: Num a => Matrix a -> Matrix a -> Matrix a
subMatrix m n = addMatrix m (negMatrix n)

mulColRow :: Num a => [a] -> [a] -> Matrix a
mulColRow [] [] = Empty
mulColRow (x:xs) (y:ys) =
  Cons (x * y) (map (* x) ys) (map (* y) xs) (mulColRow xs ys)

detRec :: Integral a => a -> Matrix a -> a
detRec d Empty = d
detRec d (Cons a r c m) = d

det :: Integral a => Matrix a -> a
det m = detRec 1 m

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

--   1 2 3 4
m4 :: Matrix Integer
m4 = Cons 1 [2,3,4] [] Empty

--   1
--   2
--   3
--   4
m5 :: Matrix Integer
m5 = Cons 1 [] [2,3,4] Empty

--   1 2
--   3 4
--   5 6
m6 :: Matrix Integer
m6 = Cons 1 [2] [3,5] (Cons 4 [] [6] Empty)
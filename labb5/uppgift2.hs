applyList :: [a -> a] -> a -> a
-- Fold with a function that applies functions from a list
applyList arr val = foldr (\x y -> x y) val arr

-- Returns f1(a) and f2(b)
pairFun :: (a -> b, c -> d) -> ((a, c) -> (b, d))
pairFun (f1, f2) (a, b) = (f1 a, f2 b)
applyList :: [a -> a] -> a -> a
applyList arr val = foldr (\x y -> x y) val arr

pairFun :: (a -> b, c -> d) -> ((a, c) -> (b, d))
pairFun (f1, f2) (a, b) = (f1 a, f2 b)
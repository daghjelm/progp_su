import Data.List
import Data.Maybe

f :: [Int] -> [Int]
f arr = map (\x -> fromMaybe 0 (elemIndex x arr)) (filter (>= 24) arr)

-- Without imports
f2 :: [Int] -> [Int]
f2 arr = fhelp arr 0 []

fhelp :: [Int] -> Int -> [Int] -> [Int]
fhelp [] _ _ = []
fhelp (x:xs) n arr | x >= 24 = n : fhelp xs (n + 1) arr
                   | otherwise = fhelp xs (n + 1) arr
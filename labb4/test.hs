fact :: Int -> Int
fact 0 = 1
fact n = n * fact (n - 1)

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

reverseString :: String -> String
reverseString "" = ""
reverseString (x:xs) = reverseString xs ++ [x]

mulString :: Integer -> String -> String
mulString 0 _ = ""
mulString _ "" = ""
mulString n str | n > 0 = str ++ mulString (n - 1) str
                | otherwise = ""

-- rev :: Foldable t => t [a] -> [a]
-- rev :: String -> String
rev :: String -> String
rev = foldl (flip (:)) []
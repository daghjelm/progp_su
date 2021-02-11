mulString :: Integer -> String -> String
mulString 0 _ = ""
mulString _ "" = ""
mulString n str | n > 0 = str ++ mulString (n - 1) str
                | otherwise = ""
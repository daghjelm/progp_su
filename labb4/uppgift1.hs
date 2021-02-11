reverseString :: String -> String
reverseString "" = ""
reverseString (x:xs) = reverseString xs ++ [x]

main :: IO ()
main = do
  let s = "!looc os si 3004AD"
  putStrLn (reverseString s)
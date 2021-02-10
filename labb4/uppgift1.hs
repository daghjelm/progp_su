reverseString :: String -> String
reverseString [] = []

main :: IO ()
main = do
  let s = "!looc os si 3004AD"
  putStrLn (reverseString s)



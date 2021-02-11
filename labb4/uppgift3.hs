main :: IO ()
main = do
  let secret = 63
  lastLine <- play secret
  putStrLn lastLine

play :: Int -> IO String
play secret = do 
  putStrLn "Guess a number between 1 and 99:"
  input <- getLine 
  let guess = read input :: Int
  let output = getOutput guess secret
  if snd output then do 
    return (fst output)
  else do
    putStrLn (fst output)
    play secret

getOutput :: Int -> Int -> (String, Bool)
getOutput x y | x < 1 || x > 99 = ("You must guess a number between 1 and 99!", False)
              | x < y = ("Too low!", False)
              | x > y = ("Too high!", False)
              | x == y = ("Correct!", True)

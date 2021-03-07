data IntExpr = Const Int
             | Var String
             | Add IntExpr IntExpr
             | Mul IntExpr IntExpr
  deriving (Eq,Show)

data Instr = Assign String IntExpr
           | If BoolExpr [Instr] [Instr]
           | While BoolExpr [Instr]
  deriving (Eq,Show)

data BoolExpr = IntEq IntExpr IntExpr
              | BoolNot BoolExpr
  deriving (Eq,Show)

evalIntExpr :: IntExpr -> [(String,Int)] -> Int
evalIntExpr (Const x) _ = x
evalIntExpr (Var s) arr = findVar s arr
evalIntExpr (Add x y) arr = evalIntExpr x arr + evalIntExpr y arr
evalIntExpr (Mul x y) arr = evalIntExpr x arr * evalIntExpr y arr

evalBoolExpr :: BoolExpr -> [(String,Int)] -> Bool
evalBoolExpr (IntEq x y) xs = evalIntExpr x xs == evalIntExpr y xs
evalBoolExpr (BoolNot expr) xs = not (evalBoolExpr expr xs)

findVar :: String -> [(String,Int)] -> Int
findVar s arr = snd (head (filter (\x -> fst x == s) arr))

addToEnv :: (String,Int) -> [(String,Int)] -> [(String,Int)]
addToEnv (s, n) [] = [(s, n)]
addToEnv (s, n) ((s2, n2):xs)
  | s == s2 = (s, n) : xs
  | otherwise = (s2, n2) : addToEnv (s, n) xs

eval :: [Instr] -> [(String,Int)] -> [(String,Int)]
eval [] env = env
eval [Assign s expr] env = addToEnv (s, evalIntExpr expr env) env
eval (Assign s expr:xs) env = eval xs (addToEnv (s, evalIntExpr expr env) env) 
eval (If expr p1 p2:xs) env 
-- add env from evaluated p1 to rest of env
  | evalBoolExpr expr env = eval xs (eval p1 env)
-- or p2..
  | otherwise = eval xs (eval p2 env) 
eval (While expr p:xs) env 
-- Keep evaluating p as long as expr is true
  | evalBoolExpr expr env = eval (While expr p:xs) (eval p env)
  | otherwise = eval xs env

run :: [Instr] -> [(String,Int)]
run xs = eval xs []

progfac :: [Instr]
progfac = [ Assign "x" (Const 5)
          , Assign "y" (Const 1)
          , While (BoolNot (IntEq (Var "x") (Const 0)))
                  [ Assign "y" (Mul (Var "y") (Var "x"))
                  , Assign "x" (Add (Var "x") (Const (-1)))
                  ]
          ]

prog1 :: [Instr]
prog1 = [ Assign "x" (Const 1)
        , Assign "y" (Add (Var "x") (Var "x"))
        , Assign "y" (Mul (Var "y") (Add (Var "x") (Const 1)))
        , Assign "z" (Add (Var "x") (Mul (Var "y") (Const 4)))
        ]

prog2 :: [Instr]
prog2 = [ Assign "x" (Const 0)
        , If (IntEq (Var "x") (Const 0))
             [ Assign "y" (Const 1) ]
             [ Assign "y" (Const 2) ]
        , If (BoolNot (IntEq (Var "y") (Const 2)))
             [ Assign "z" (Const 2) ]
             [ Assign "z" (Const 1) ]
        ]

prog3 :: [Instr]
prog3 = [ Assign "x" (Const 0)
        , Assign "y" (Const 1)
        , If (BoolNot (IntEq (Var "x") (Var "y")))
             [ Assign "x" (Var "y")
             , If (IntEq (Var "x") (Var "y"))
                  [ Assign "z" (Const 0) ]
                  [ Assign "z" (Const 1) ]
             , Assign "y" (Const 5) ]
             [ Assign "z" (Const 2) ]
        , Assign "w" (Var "z")
        ]
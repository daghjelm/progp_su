data IntExpr = Const Int
             | Var String
             | Add IntExpr IntExpr
             | Mul IntExpr IntExpr
  deriving (Eq,Show)

evalIntExpr :: IntExpr -> [(String,Int)] -> Int
evalIntExpr (Const x) _ = x
evalIntExpr (Var s) arr = findVar s arr
evalIntExpr (Add x y) arr = evalIntExpr x arr + evalIntExpr y arr
evalIntExpr (Mul x y) arr = evalIntExpr x arr * evalIntExpr y arr


findVar :: String -> [(String,Int)] -> Int
findVar s ((x, n):xs)
  | s == x = n
  | otherwise = findVar s xs
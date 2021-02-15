data RoseTree a = N a [RoseTree a]
  deriving (Eq, Show)

mapRoseTree :: (a -> b) -> RoseTree a -> RoseTree b
mapRoseTree f (N nr []) = N (f nr) []
-- Use helper for arrays
mapRoseTree f (N nr arr) = N (f nr) (mapRoseTreeHelp f arr)
 
mapRoseTreeHelp :: (a -> b) -> [RoseTree a] -> [RoseTree b]
-- Nothing happens when list is empty
mapRoseTreeHelp f [] = []
-- Apply the function on the first item and recurse over the rest
mapRoseTreeHelp f ((N nr []):xs) = N (f nr) [] : mapRoseTreeHelp f xs
mapRoseTreeHelp f ((N nr arr):xs) = 
  N (f nr) (mapRoseTreeHelp f arr) : mapRoseTreeHelp f xs
data RoseTree a = N a [RoseTree a]
  deriving (Eq, Show)

mapRoseTree :: (a -> b) -> RoseTree a -> RoseTree b
mapRoseTree f (N nr []) = N (f nr) []
mapRoseTree f (N nr arr) = N (f nr) (mapRoseTreeHelp f arr)
 
mapRoseTreeHelp :: (a -> b) -> [RoseTree a] -> [RoseTree b]
mapRoseTreeHelp f [] = []
-- mapRoseTreeHelp f [N nr []] = [N (f nr) []]
mapRoseTreeHelp f ((N nr []):xs) = N (f nr) [] : mapRoseTreeHelp f xs
mapRoseTreeHelp f ((N nr arr):xs) = N (f nr) (mapRoseTreeHelp f arr) : mapRoseTreeHelp f xs
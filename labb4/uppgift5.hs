data RoseTree a = N a [RoseTree a]
  deriving (Eq, Show)

flatten :: RoseTree a -> [a]
-- Start with first number and then use a helper function
-- that takes arrays
flatten (N nr arr) = nr : flattenHelp arr

flattenHelp :: [RoseTree a] -> [a]
flattenHelp [] = []
-- recurse over both of the arrays of rose trees
flattenHelp ((N nr arr):xs) = nr : flattenHelp arr ++ flattenHelp xs

leaves :: RoseTree a -> [a]
-- base case: rose tree without array is a leaf (I think...) 
leaves (N nr []) = [nr]
leaves (N nr arr) = leavesHelp arr

leavesHelp :: [RoseTree a] -> [a]
leavesHelp [] = []
-- head is a leaf so we add 'x'
leavesHelp ((N x []):xs) = x : leavesHelp xs
-- No leaves means we recurse over both arrays and ++ them
leavesHelp ((N x arr):xs) = leavesHelp arr ++ leavesHelp xs
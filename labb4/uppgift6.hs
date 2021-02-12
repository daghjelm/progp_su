skyffla :: [a] -> [a]
skyffla [] = []
-- take every other element and add skyffla on 
-- the items we didnt take the first time
-- meaning every other on the tail of a
skyffla a = varannan a ++ skyffla (varannan (tail a))

varannan :: [a] -> [a]
varannan [] = []
-- drop 2 a is like doing tail (tail a)
varannan a = head a : varannan (drop 2 a) 
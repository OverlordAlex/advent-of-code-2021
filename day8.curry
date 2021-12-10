split [] _ = ([], [])
split (c:text) delim = if c == delim then ([c], text) else split text delim

input = readFile "day8.in" 

number :: [Char] -> Int
number [] = -1
number x | length x == 2 = 1
         | length x == 3 = 7
         | length x == 4 = 4
         | length x == 7 = 8
         | otherwise = -1


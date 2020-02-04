-- Task 1
zipL :: [Int] -> [Int] -> [[Int]]
zipL [] _ = []
zipL (x:xs) (y:ys) | (length xs == length ys) = [x, y] : zipL xs ys
                   | otherwise                = []

-- Task 2
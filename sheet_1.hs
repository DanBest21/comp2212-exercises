import Parsing
import System.IO

-- Task 1
zipLE :: [a] -> [a] -> [[a]]
zipLE [] _ = []
zipLE (x:xs) (y:ys) | (length xs == length ys) = [x, y] : zipL xs ys
                    | otherwise                = []

unzipLE :: [[a]] -> ([a], [a])
unzipLE xss = ([ xs !! 0 | xs <- xss ], [ xs !! 1 | xs <- xss ]) 

-- Task 2
zipL :: [a] -> [a] -> [[a]]
zipL [] [] = []
zipL [] (y:ys) = [y] : zipL [] ys
zipL (x:xs) [] = [x] : zipL xs []
zipL (x:xs) (y:ys) = [x, y] : zipL xs ys

-- Task 3
multiZipL :: [[a]] -> [[a]]
multiZipL [] = []
multiZipL xss | null nth  = []
              | otherwise = [ head xs | xs <- xss' ] : multiZipL (map (tail) xss')
        where xss' = filter (not . null) xss
              nth = [ head xs | xs <- xss' ]

-- Task 4
valueExpr :: Parser Int
valueExpr = do x <- integer
               symbol ","
               return x

lastValueExpr :: Parser Int
lastValueExpr = do x <- integer
                   return x

lineExpr :: Parser [Int]
lineExpr = do xs <- many valueExpr
              char '\n'
              return xs

listExpr :: Parser [[Int]]
listExpr = do xss <- many lineExpr
              return xss

multiZipF :: String -> [[Int]]
multiZipF s = listExpr s
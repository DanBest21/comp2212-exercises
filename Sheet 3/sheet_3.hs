-- Task 1:
-- import Grammar
-- import Tokens

-- Task 2:
import GrammarPosn
import TokensPosn

main :: IO ()
main = do
    file <- readFile "test.txt"
    print (parseCalc (alexScanTokens file))
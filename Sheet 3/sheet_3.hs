import Grammar
import Tokens

main :: IO ()
main = do
    file <- readFile "test.txt"
    print (parseCalc (alexScanTokens file))
import Tokens
import System.Environment
import Data.List

main :: IO ()
main = do
    xs <- getArgs
    print (alexScanTokens (intercalate " " xs))
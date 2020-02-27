-- Tasks 1 and 2
-- import Tokens
-- Task 3
import MDL
import System.Environment
import Data.List

main :: IO ()
main = do
    xs <- getArgs
    -- Implement tokenPosn for Task 2.
    print (alexScanTokens (intercalate " " xs))
-- Tasks 1 and 2
-- import Tokens

-- Task 3
import MDL

import System.Environment
import Data.List

main :: IO ()
main = do
   xs <- getArgs
   print (alexScanTokens (intercalate " " "5^2"))
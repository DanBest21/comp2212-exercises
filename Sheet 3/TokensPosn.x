{ 
module TokensPosn where 
}

%wrapper "posn" 
$digit = 0-9     
-- digits 
$alpha = [a-zA-Z]    
-- alphabetic characters

tokens :-
$white+       ; 
  "--".*        ; 
  let           { \p s -> TokenLet p } 
  in            { \p s -> TokenIn p }
  $digit+       { \p s -> TokenInt p (read s) } 
  \=          { \p s -> TokenEq p }
  \+          { \p s -> TokenPlus p }
  \-          { \p s -> TokenMinus p }
  \*          { \p s -> TokenTimes p }
  \/          { \p s -> TokenDiv p }
  \(          { \p s -> TokenLParen p }
  \)          { \p s -> TokenRParen p }
  \^          { \p s -> TokenExponent p }
  $alpha [$alpha $digit \_ \’]*   { \p s -> TokenVar p s } 

{ 
-- Each action has type :: String -> Token 
-- The token type: 
data Token = 
  TokenLet AlexPosn        | 
  TokenIn AlexPosn         | 
  TokenInt AlexPosn Int    |
  TokenVar AlexPosn String | 
  TokenEq AlexPosn         |
  TokenPlus AlexPosn       |
  TokenMinus AlexPosn      |
  TokenTimes AlexPosn      |
  TokenDiv AlexPosn        |
  TokenLParen AlexPosn     |
  TokenRParen AlexPosn     |
  TokenExponent AlexPosn 
  deriving (Eq,Show)

tokenPosn :: Token -> String
tokenPosn (TokenLet (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenIn (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenInt (AlexPn _ x y) _) = show(x) ++ " " ++ show(y)
tokenPosn (TokenVar (AlexPn _ x y) _) = show(x) ++ " " ++ show(y)
tokenPosn (TokenEq (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenPlus (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenMinus (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenTimes (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenDiv (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenLParen (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenRParen (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
tokenPosn (TokenExponent (AlexPn _ x y)) = show(x) ++ " " ++ show(y)
}
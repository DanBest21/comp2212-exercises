{ 
module Tokens where 
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

tokenPosn :: Token -> AlexPosn
tokenPosn (TokenLet p) = p
tokenPosn (TokenIn p) = p
tokenPosn (TokenInt p _) = p
tokenPosn (TokenVar p _) = p
tokenPosn (TokenEq p) = p
tokenPosn (TokenPlus p) = p
tokenPosn (TokenMinus p) = p
tokenPosn (TokenTimes p) = p
tokenPosn (TokenDiv p) = p
tokenPosn (TokenLParen p) = p
tokenPosn (TokenRParen p) = p
tokenPosn (TokenExponent p) = p
}
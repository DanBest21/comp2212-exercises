{ 
module MDL where 
}

%wrapper "posn" 
$digit = 0-9     
-- digits 
$alpha = [a-zA-Z]
-- alphabetic characters

tokens :-
  $white+       ;
  "--".*        ;
  \;            { \p s -> MDLBreak p }
  forward       { \p s -> MDLForward p }
  left          { \p s -> MDLRotateLeft p }
  right         { \p s -> MDLRotateRight p }
  \?\<          { \p s -> MDLCheck p }
  $digit        { \p s -> MDLDigit p (read s) }
  $digit{2,}    { \p s -> MDLNumber p (read s) }
  if            { \p s -> MDLIf p }
  then          { \p s -> MDLThen p }
  else          { \p s -> MDLElse p }

{ 
-- Each action has type :: String -> Token 
-- The token type: 
data MDLToken = 
  MDLBreak AlexPosn        |
  MDLForward AlexPosn      | 
  MDLRotateLeft AlexPosn   |
  MDLRotateRight AlexPosn  |
  MDLDigit AlexPosn Int    |
  MDLNumber AlexPosn Int   | 
  MDLCheck AlexPosn        |
  MDLIf AlexPosn           |
  MDLThen AlexPosn         |
  MDLElse AlexPosn
  deriving (Eq,Show)
}
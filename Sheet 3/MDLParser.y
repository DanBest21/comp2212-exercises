{ 
module MDLParser where 
import MDLLexer 
}

%name parseCalc 
%tokentype { MDLToken } 
%error { parseError }
%token 
    ';' { MDLBreak _ } 
    forward  { MDLForward _ } 
    left { MDLRotateLeft _ } 
    right { MDLRotateRight _ } 
    '?<' { MDLCheck _ } 
    digit { MDLDigit _ $$ } 
    num { MDLNumber _ $$ } 
    if { MDLIf _ } 
    then { MDLThen _ } 
    else { MDLElse _ } 


%right if then else
%right '?<' 
%left forward left right 
%left ';' 
%% 
Exp : Action { $1 : [] }
    | Exp ';' Action { $3 : $1 }

Action : forward Num { Forward $2 }
       | left { RLeft }
       | right { RRight }
       | forward Num ';' { Forward $2 }
       | left ';' { RLeft }
       | right ';' { RRight }
       
Check : '?<' Digit { Check $2 }

Digit : digit { $1 }

Num : num { $1 }

Cond : if Check then Exp else Exp { IfThenElse $2 $4 $6 } 
    
{ 
parseError :: [MDLToken] -> a
parseError ts = error errorMessage
    where lineCol = words (tokenPosn (last ts))
          errorMessage = "Parse error at line " ++ (lineCol !! 0) ++ ", column " ++ (lineCol !! 1)

data Exp = Forward Int
         | RLeft
         | RRight
         | IfThenElse Check' Exp Exp
         deriving Show

data Check' = Check Int
            deriving Show
} 
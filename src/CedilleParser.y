{

module CedilleParser where

import CedilleTypes
import CedilleLexer hiding (main)
  
}

%name      cedilleParser Start
%name      types         Type
%name      term          Term
%name      maybetype     MaybeCheckType
%name      deftermtype   DefTermOrType
%name      cmd           Cmd

%tokentype { Token }
%error     { parseError }
%monad     { Alex }
%lexer     { lexer } { Token _ TEOF }

%token
  var        { Token _ (TVar _)    }
  qvar       { Token _ (TQvar _)   }
  kvar       { Token _ (TKvar _)   }
  qkvar      { Token _ (TQKvar _)  }
  fpth       { Token _ (TFpth _)   }
  '.num'     { Token _ (TProj _)   }
  'ε'        { Token $$ TEps       }
  'ε-'       { Token $$ TEpsM      }
  'εl'       { Token $$ TEpsL      }
  'εl-'      { Token $$ TEpsLM     }
  'εr'       { Token $$ TEpsR      }
  'εr-'      { Token $$ TEpsRM     }    
  'import'   { Token $$ TImport    }
  'module'   { Token $$ TModule    }
  'as'       { Token $$ TAs        }
  'let'      { Token $$ TLet       }
  'in'       { Token $$ TIn        }
  '{^'       { Token $$ TLSpan     }
  '^}'       { Token $$ TRSpan     }
  'θ'        { Token $$ TTheta     }
  'θ+'       { Token $$ TThetaEq   }
  'θ<'       { Token $$ TThetaVars }
  'ρ'        { Token $$ TRhoPlain  }
  'ρ+'       { Token $$ TRhoPlus   }
  '='        { Token $$ (TSym "=") }  
  '>'        { Token $$ (TSym ">") }
  '_'        { Token _  (TSym "_") }
  '.'        { Token $$ (TSym ".") }
  '('        { Token $$ (TSym "(") }
  ')'        { Token $$ (TSym ")") }
  '['        { Token $$ (TSym "[") }
  ']'        { Token $$ (TSym "]") }
  ','        { Token $$ (TSym ",") }  
  '{'        { Token $$ (TSym "{") }
  '}'        { Token $$ (TSym "}") }
  ':'        { Token $$ (TSym ":") }
  'Π'        { Token $$ (TSym "Π") }
  '∀'        { Token $$ (TSym "∀") }
  'λ'        { Token $$ (TSym "λ") }
  'Λ'        { Token $$ (TSym "Λ") }  
  'ι'        { Token $$ (TSym "ι") }
  '↑'        { Token $$ (TSym "↑") }
  'β'        { Token $$ (TSym "β") }
  '·'        { Token $$ (TSym "·") }
  '-'        { Token $$ (TSym "-") }
  'ς'        { Token $$ (TSym "ς") }
  'χ'        { Token $$ (TSym "χ") }
  '➾'       { Token $$ (TSym "➾") }
  '➔'       { Token $$ (TSym "➔") }
  '≃'        { Token $$ (TSym "≃") }
  '◂'         { Token $$ (TSym "◂") }
  '●'        { Token $$ (TSym "●") }
  '☆'        { Token $$ (TSym "☆") }
  '★'        { Token $$ (TSym "★") }  
  
%%

{-

Must review:
 - White spaces treatment in rules.
 - Reserved words: import, module, as, let, in and several symbols.
 - Some arrows association desambiguation in terms and types.
 - Because of previous point I moved term equality from Type to Ltype grammar variable, in order to allow types equalities at the left of an arrow.
 - Because of a reduce/reduce conflict with variables and holes in types and terms I added brackets to terms equality type.
 - Position information should be converted into a string and verified.

-}      
  
Start :: { Start }
      : Imports 'module' Qvar Params '.' Cmds LineNo { File $2 $1 (tStr $3) $4 $6 $7 }  

Imprt :: { Imprt }
      : 'import' Fpth OptAs Args '.'    { Import $1 (tStr $2) $3 $4 $5 }

OptAs :: { OptAs }
      :                                 { NoOptAs             }
      | 'as' var                        { SomeOptAs (tStr $2) }
      
Imports :: { Imports }
        :                               { ImportsStart      }
        | Imprt Imports                 { ImportsNext $1 $2 }
{- Note: Happy is more efficient with left recursive rules, only important for long lists -}

Cmds :: { Cmds }
     :                                  { CmdsStart      }
     | Cmd Cmds                         { CmdsNext $1 $2 }

Cmd :: { Cmd }
    : Imprt                             { ImportCmd $1                         }
    | DefTermOrType        '.'          { DefTermOrType $1 $2                  }
    | kvar Params '=' Kind '.'          { DefKind (tPos $1) (tStr $1) $2 $4 $5 }

MaybeCheckType :: { MaybeCheckType }
               :                        { NoCheckType }
               | '◂' Type               { Type $2     }

Params :: { Params }
       :                                { ParamsNil        }
       | Decl Params                    { ParamsCons $1 $2 }

DefTermOrType :: { DefTermOrType }
              : var MaybeCheckType '=' Term  { DefTerm (tPos $1) (tStr $1) $2 $4 }
              | var '◂' Kind       '=' Type  { DefType (tPos $1) (tStr $1) $3 $5 } 

Decl :: { Decl }
     : '(' Bvar ':' Tk ')'              { Decl $1 (tPos $2) (tStr $2) $4 $5 }

Theta :: { (Theta, PosInfo) }
      : 'θ'                             { (Abstract       , $1) }
      | 'θ+'                            { (AbstractEq     , $1) }
      | 'θ<' Vars '>'                   { (AbstractVars $2, $1) }

Vars :: { Vars }
     : var                              { VarsStart (tStr $1)    }
     | var Vars                         { VarsNext  (tStr $1) $2 }

Rho :: { (Rho, PosInfo) }
    : 'ρ'                               { (RhoPlain, $1)  }
    | 'ρ+'                              { (RhoPlus , $1)  }

OptTerm :: { OptTerm }
        :                               { NoTerm         }
        | '{' Term '}'                  { SomeTerm $2 $3 }

Term :: { Term }
     : Lam Bvar OptClass '.' Term       { Lam (snd $1) (fst $1) (tPos $2) (tStr $2) $3 $5 }
     | 'let' DefTermOrType 'in' Term    { Let $1 $2 $4                                    }
     | Theta Lterm Lterms               { Theta (snd $1) (fst $1) $2 $3                   }
     | Aterm                            { $1                                              }

Aterm :: { Term }
      : Aterm     Lterm                 { App $1 NotErased $2           }
      | Aterm '-' Lterm                 { App $1 Erased    $3           }      
      | Aterm '·' Atype                 { AppTp $1 $3                   } 
      | Lterm                           { $1                            }

Lterm :: { Term }
      : 'β'   OptTerm                   { Beta $1 $2                                }
      | 'ε'   Lterm                     { Epsilon $1 Both               EpsHnf  $2  }
      | 'ε-'  Lterm                     { Epsilon $1 Both               EpsHanf $2  }
      | 'εl'  Lterm                     { Epsilon $1 CedilleTypes.Left  EpsHnf  $2  }
      | 'εl-' Lterm                     { Epsilon $1 CedilleTypes.Left  EpsHanf $2  }
      | 'εr'  Lterm                     { Epsilon $1 CedilleTypes.Right EpsHnf  $2  }
      | 'εr-' Lterm                     { Epsilon $1 CedilleTypes.Right EpsHanf $2  }
      | 'ς' Lterm                       { Sigma $1 $2                               }
      | Rho Lterm      '-' Lterm        { Rho (snd $1) (fst $1) $2 $4               }
      | 'χ' MaybeAtype '-' Lterm        { Chi $1 $2 $4                              }
      | Pterm                           { $1                                        }

Pterm :: { Term }
      : Qvar                            { Var (tPos $1) (tStr $1)         }
      | '(' Term ')'                    { Parens $1 $2 $3                 } 
      | Pterm '.num'                    { IotaProj $1 (tStr $2) (tPos $2) } -- shift-reduce conflict with the point of end of command ! solution: create a token '.1' and '.2' 
      | '[' Term ',' Term OptTerm ']'   { IotaPair $1 $2 $4 $5 $6         }
      | '●'                             { Hole $1                        }      

MaybeAtype :: { MaybeAtype }
           : Atype                      { Atype $1 }
           |                            { NoAtype  }
      
Lterms :: { Lterms }
       : LineNo                         { LtermsNil  $1              }
       |     Lterm Lterms               { LtermsCons NotErased $1 $2 }
       | '-' Lterm Lterms               { LtermsCons Erased    $2 $3 }       

OptClass :: { OptClass }
         :                              { NoClass      }
         | ':' Tk                       { SomeClass $2 }

OptType :: { OptType }
        :                               { NoType      }
        | ':' Type                      { SomeType $2 }

Lam :: { (Lam , PosInfo) }
    : 'Λ'                               { (ErasedLambda, $1) }
    | 'λ'                               { (KeptLambda  , $1) }

Type :: { Type }
     : 'Π'    Bvar ':' Tk  '.' Type     { Abs $1 Pi  (tPos $2) (tStr $2) $4 $6 }
     | '∀'    Bvar ':' Tk  '.' Type     { Abs $1 All (tPos $2) (tStr $2) $4 $6 }
     | 'λ'    Bvar ':' Tk  '.' Type     { TpLambda $1 $3 (tStr $2) $4 $6                  }
     | 'ι'    Bvar OptType '.' Type     { Iota $1 (tPos $2) (tStr $2) $3 $5               }
     | LType '➾' Type                  { TpArrow $1 ErasedArrow   $3                     }
     | LType '➔' Type                  { TpArrow $1 UnerasedArrow $3                     }
     | LType                            { $1                                              }
     | '{^' Type '^}'                   { NoSpans $2 $3                                   }

LType :: { Type } 
      : '↑' var '.' Term ':' LliftingType { Lft $1 (tPos $2) (tStr $2) $4 $6 }
      | LType   '·' Atype                 { TpApp $1 $3                      }
      | LType Lterm                       { TpAppt $1 $2                     }
      | '{' Term '≃' Term '}'            { TpEq $2 $4                       } -- reduce/reduce conflict with variables and holes in types and terms without brackets
      | Atype                             { $1                               }

Atype :: { Type }
      : '(' Type ')'                    { TpParens $1 $2 $3 }
      | Qvar                            { TpVar (tPos $1) (tStr $1) }
      | '●'                             { TpHole $1   }

Arg :: { Arg }
    : Lterm                             { TermArg $1 }
    | '·' Atype                         { TypeArg $2 }

Args :: { Args }
     : LineNo                           { ArgsNil $1     }
     | Arg Args                         { ArgsCons $1 $2 } 

Kind :: { Kind }
     : 'Π' Bvar ':' Tk '.' Kind         { KndPi $1 (tPos $2) (tStr $2) $4 $6 }
     | LKind '➔' Kind                  { KndArrow   $1 $3                   }
     | LType '➔' Kind                  { KndTpArrow $1 $3                   }
     | LKind                            { $1                                 }

LKind :: { Kind }
     : '★'                             { Star $1                            }
     | '(' Kind ')'                     { KndParens  $1 $2 $3                }
     | qkvar Args                       { KndVar (tPos $1) (tStr $1) $2      }

LiftingType :: { LiftingType }
            : 'Π' Bvar ':' Type '.' LiftingType    { LiftPi $1 (tStr $2) $4 $6 } 
            | LliftingType  '➔' LiftingType       { LiftArrow   $1 $3         }
            | Type          '➔' LiftingType       { LiftTpArrow $1 $3         }
            | LliftingType                         { $1                        }

LliftingType :: { LiftingType }
             : '☆'                                { LiftStar $1               }
             | '(' LiftingType ')'                { LiftParens  $1 $2 $3      }
             
Tk :: { Tk }
   : Type                               { Tkt $1 }
   | Kind                               { Tkk $1 } 

Bvar :: { Token }
     : '_'                              { $1 }
     | var                              { $1 }

Qvar :: { Token }
     : var                              { $1 }
     | qvar                             { $1 }

Fpth :: { Token }
     : fpth                             { $1 }
     | var                              { $1 }

LineNo :: { PosInfo }
       : {- empty -}                    {% getPos } 

{
  
getPos :: Alex PosInfo
getPos = Alex $ \ s -> return (s , alex_pos s)

posInfo :: PosInfo
posInfo = AlexPn 0 0 0
  
lexer :: (Token -> Alex a) -> Alex a
lexer f = alexMonadScan >>= f  
  
parseError :: Token -> Alex a
parseError (Token p t) = alexError $ "Parse error in token:" ++ show t ++ "\n. Position: " ++ show p

main :: IO ()
main = do  
  s <- getContents
  case runAlex s $ cedilleParser of
    Prelude.Left  errMsg -> putStrLn $ "Error:" ++ errMsg
    Prelude.Right res    -> putStrLn $ "Parser successful:" ++ show res
}

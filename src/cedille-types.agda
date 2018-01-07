----------------------------------------------------------------------------------
-- Types for parse trees
----------------------------------------------------------------------------------

module cedille-types where

postulate
  string : Set

{-# BUILTIN STRING string #-}

posinfo = string
alpha = string
alpha-bar-3 = string
alpha-range-1 = string
alpha-range-2 = string
bvar = string
bvar-bar-13 = string
fpth = string
fpth-bar-15 = string
fpth-bar-16 = string
fpth-bar-17 = string
fpth-plus-14 = string
fpth-star-18 = string
kvar = string
kvar-bar-19 = string
kvar-star-20 = string
num = string
num-plus-5 = string
numone = string
numone-range-4 = string
numpunct = string
numpunct-bar-10 = string
numpunct-bar-6 = string
numpunct-bar-7 = string
numpunct-bar-8 = string
numpunct-bar-9 = string
qkvar = string
qvar = string
var = string
var-bar-11 = string
var-star-12 = string

{-# IMPORT CedilleTypes #-}

data arg : Set
{-# COMPILED_DECLARE_DATA arg CedilleTypes.Arg #-}
data args : Set
{-# COMPILED_DECLARE_DATA args CedilleTypes.Args #-}
data arrowtype : Set
{-# COMPILED_DECLARE_DATA arrowtype CedilleTypes.ArrowType #-}
data binder : Set
{-# COMPILED_DECLARE_DATA binder CedilleTypes.Binder #-}
data cmd : Set
{-# COMPILED_DECLARE_DATA cmd CedilleTypes.Cmd #-}
data cmds : Set
{-# COMPILED_DECLARE_DATA cmds CedilleTypes.Cmds #-}
data decl : Set
{-# COMPILED_DECLARE_DATA decl CedilleTypes.Decl #-}
data defTermOrType : Set
{-# COMPILED_DECLARE_DATA defTermOrType CedilleTypes.DefTermOrType #-}
data imports : Set
{-# COMPILED_DECLARE_DATA imports CedilleTypes.Imports #-}
data imprt : Set
{-# COMPILED_DECLARE_DATA imprt CedilleTypes.Imprt #-}
data kind : Set
{-# COMPILED_DECLARE_DATA kind CedilleTypes.Kind #-}
data lam : Set
{-# COMPILED_DECLARE_DATA lam CedilleTypes.Lam #-}
data leftRight : Set
{-# COMPILED_DECLARE_DATA leftRight CedilleTypes.LeftRight #-}
data liftingType : Set
{-# COMPILED_DECLARE_DATA liftingType CedilleTypes.LiftingType #-}
data lterms : Set
{-# COMPILED_DECLARE_DATA lterms CedilleTypes.Lterms #-}
data maybeAtype : Set
{-# COMPILED_DECLARE_DATA maybeAtype CedilleTypes.MaybeAtype #-}
data maybeCheckType : Set
{-# COMPILED_DECLARE_DATA maybeCheckType CedilleTypes.MaybeCheckType #-}
data maybeErased : Set
{-# COMPILED_DECLARE_DATA maybeErased CedilleTypes.MaybeErased #-}
data maybeMinus : Set
{-# COMPILED_DECLARE_DATA maybeMinus CedilleTypes.MaybeMinus #-}
data optAs : Set
{-# COMPILED_DECLARE_DATA optAs CedilleTypes.OptAs #-}
data optClass : Set
{-# COMPILED_DECLARE_DATA optClass CedilleTypes.OptClass #-}
data optTerm : Set
{-# COMPILED_DECLARE_DATA optTerm CedilleTypes.OptTerm #-}
data optType : Set
{-# COMPILED_DECLARE_DATA optType CedilleTypes.OptType #-}
data params : Set
{-# COMPILED_DECLARE_DATA params CedilleTypes.Params #-}
data rho : Set
{-# COMPILED_DECLARE_DATA rho CedilleTypes.Rho #-}
data start : Set
{-# COMPILED_DECLARE_DATA start CedilleTypes.Start #-}
data term : Set
{-# COMPILED_DECLARE_DATA term CedilleTypes.Term  #-}
data theta : Set
{-# COMPILED_DECLARE_DATA theta CedilleTypes.Theta  #-}
data tk : Set
{-# COMPILED_DECLARE_DATA tk CedilleTypes.Tk  #-}
data type : Set
{-# COMPILED_DECLARE_DATA type CedilleTypes.Type  #-}
data vars : Set
{-# COMPILED_DECLARE_DATA vars CedilleTypes.Vars  #-}

data arg where 
  TermArg : term → arg
  TypeArg : type → arg
{-# COMPILED_DATA arg CedilleTypes.Arg CedilleTypes.TermArg CedilleTypes.TypeArg #-}

data args where 
  ArgsCons : arg → args → args
  ArgsNil : posinfo → args
{-# COMPILED_DATA args CedilleTypes.Args CedilleTypes.ArgsCons CedilleTypes.ArgsNil #-}

data arrowtype where 
  ErasedArrow : arrowtype
  UnerasedArrow : arrowtype
{-# COMPILED_DATA arrowtype CedilleTypes.ArrowType CedilleTypes.ErasedArrow CedilleTypes.UnerasedArrow #-}

data binder where 
  All : binder
  Pi : binder
{-# COMPILED_DATA binder CedilleTypes.Binder CedilleTypes.All CedilleTypes.Pi #-}

data cmd where 
  DefKind : posinfo → kvar → params → kind → posinfo → cmd
  DefTermOrType : defTermOrType → posinfo → cmd
  ImportCmd : imprt → cmd
{-# COMPILED_DATA cmd CedilleTypes.Cmd CedilleTypes.DefKind CedilleTypes.DefTermOrType CedilleTypes.ImportCmd #-}

data cmds where 
  CmdsNext : cmd → cmds → cmds
  CmdsStart : cmds
{-# COMPILED_DATA cmds CedilleTypes.Cmds CedilleTypes.CmdsNext CedilleTypes.CmdsStart #-}

data decl where 
  Decl : posinfo → posinfo → bvar → tk → posinfo → decl
{-# COMPILED_DATA decl CedilleTypes.Decl CedilleTypes.Decl #-}

data defTermOrType where 
  DefTerm : posinfo → var → maybeCheckType → term → defTermOrType
  DefType : posinfo → var → kind → type → defTermOrType
{-# COMPILED_DATA defTermOrType CedilleTypes.DefTermOrType CedilleTypes.DefTerm CedilleTypes.DefType #-}

data imports where 
  ImportsNext : imprt → imports → imports
  ImportsStart : imports
{-# COMPILED_DATA imports CedilleTypes.Imports CedilleTypes.ImportsNext CedilleTypes.ImportsStart #-}

data imprt where 
  Import : posinfo → fpth → optAs → args → posinfo → imprt
{-# COMPILED_DATA imprt CedilleTypes.Imprt CedilleTypes.Import #-}

data kind where 
  KndArrow : kind → kind → kind
  KndParens : posinfo → kind → posinfo → kind
  KndPi : posinfo → posinfo → bvar → tk → kind → kind
  KndTpArrow : type → kind → kind
  KndVar : posinfo → qkvar → args → kind
  Star : posinfo → kind
{-# COMPILED_DATA kind CedilleTypes.Kind CedilleTypes.KndArrow CedilleTypes.KndParens CedilleTypes.KndPi CedilleTypes.KndTpArrow CedilleTypes.KndVar CedilleTypes.Star #-}  

data lam where 
  ErasedLambda : lam
  KeptLambda : lam
{-# COMPILED_DATA lam CedilleTypes.Lam CedilleTypes.ErasedLambda CedilleTypes.KeptLambda #-}

data leftRight where 
  Both : leftRight
  Left : leftRight
  Right : leftRight
{-# COMPILED_DATA leftRight CedilleTypes.LeftRight CedilleTypes.Both CedilleTypes.Left CedilleTypes.Right #-}

data liftingType where 
  LiftArrow : liftingType → liftingType → liftingType
  LiftParens : posinfo → liftingType → posinfo → liftingType
  LiftPi : posinfo → bvar → type → liftingType → liftingType
  LiftStar : posinfo → liftingType
  LiftTpArrow : type → liftingType → liftingType
{-# COMPILED_DATA liftingType CedilleTypes.LiftingType CedilleTypes.LiftArrow CedilleTypes.LiftParens CedilleTypes.LiftPi CedilleTypes.LiftStar CedilleTypes.LiftTpArrow #-}

data lterms where 
  LtermsCons : maybeErased → term → lterms → lterms
  LtermsNil : posinfo → lterms
{-# COMPILED_DATA lterms CedilleTypes.Lterms CedilleTypes.LtermsCons CedilleTypes.LtermsNil #-}

data maybeAtype where 
  Atype : type → maybeAtype
  NoAtype : maybeAtype
{-# COMPILED_DATA maybeAtype CedilleTypes.MaybeAtype CedilleTypes.Atype CedilleTypes.NoAtype #-}  

data maybeCheckType where 
  NoCheckType : maybeCheckType
  Type : type → maybeCheckType
{-# COMPILED_DATA maybeCheckType CedilleTypes.MaybeCheckType CedilleTypes.NoCheckType CedilleTypes.Type #-}

data maybeErased where 
  Erased : maybeErased
  NotErased : maybeErased
{-# COMPILED_DATA maybeErased CedilleTypes.MaybeErased CedilleTypes.Erased CedilleTypes.NotErased #-}

data maybeMinus where 
  EpsHanf : maybeMinus
  EpsHnf : maybeMinus
{-# COMPILED_DATA maybeMinus CedilleTypes.MaybeMinus CedilleTypes.EpsHanf CedilleTypes.EpsHnf #-}

data optAs where 
  NoOptAs : optAs
  SomeOptAs : var → optAs
{-# COMPILED_DATA optAs CedilleTypes.OptAs CedilleTypes.NoOptAs CedilleTypes.SomeOptAs #-}

data optClass where 
  NoClass : optClass
  SomeClass : tk → optClass
{-# COMPILED_DATA optClass CedilleTypes.OptClass CedilleTypes.NoClass CedilleTypes.SomeClass #-}

data optTerm where 
  NoTerm : optTerm
  SomeTerm : term → posinfo → optTerm
{-# COMPILED_DATA optTerm CedilleTypes.OptTerm CedilleTypes.NoTerm CedilleTypes.SomeTerm #-}  

data optType where 
  NoType : optType
  SomeType : type → optType
{-# COMPILED_DATA optType CedilleTypes.OptType CedilleTypes.NoType CedilleTypes.SomeType #-}    

data params where 
  ParamsCons : decl → params → params
  ParamsNil : params
{-# COMPILED_DATA params CedilleTypes.Params CedilleTypes.ParamsCons CedilleTypes.ParamsNil #-}      

data rho where 
  RhoPlain : rho
  RhoPlus : rho
{-# COMPILED_DATA rho CedilleTypes.Rho CedilleTypes.RhoPlain CedilleTypes.RhoPlus #-}

data start where 
  File : posinfo → imports → qvar → params → cmds → posinfo → start
{-# COMPILED_DATA start CedilleTypes.Start CedilleTypes.File #-}  

data term where 
  App : term → maybeErased → term → term
  AppTp : term → type → term
  Beta : posinfo → optTerm → term
  Chi : posinfo → maybeAtype → term → term
  Epsilon : posinfo → leftRight → maybeMinus → term → term
  Hole : posinfo → term
  IotaPair : posinfo → term → term → optTerm → posinfo → term
  IotaProj : term → num → posinfo → term
  Lam : posinfo → lam → posinfo → bvar → optClass → term → term
  Let : posinfo → defTermOrType → term → term
  Parens : posinfo → term → posinfo → term
  Rho : posinfo → rho → term → term → term
  Sigma : posinfo → term → term
  Theta : posinfo → theta → term → lterms → term
  Var : posinfo → qvar → term
{-# COMPILED_DATA term CedilleTypes.Term CedilleTypes.App CedilleTypes.AppTp CedilleTypes.Beta CedilleTypes.Chi CedilleTypes.Epsilon CedilleTypes.Hole CedilleTypes.IotaPair CedilleTypes.IotaProj CedilleTypes.Lam CedilleTypes.Let CedilleTypes.Parens CedilleTypes.Rho CedilleTypes.Sigma CedilleTypes.Theta CedilleTypes.Var #-}    

data theta where 
  Abstract : theta
  AbstractEq : theta
  AbstractVars : vars → theta
{-# COMPILED_DATA theta CedilleTypes.Theta CedilleTypes.Abstract CedilleTypes.AbstractEq CedilleTypes.AbstractVars #-}      

data tk where 
  Tkk : kind → tk
  Tkt : type → tk
{-# COMPILED_DATA tk CedilleTypes.Tk CedilleTypes.Tkk CedilleTypes.Tkt #-}        

data type where 
  Abs : posinfo → binder → posinfo → bvar → tk → type → type
  Iota : posinfo → posinfo → bvar → optType → type → type
  Lft : posinfo → posinfo → var → term → liftingType → type
  NoSpans : type → posinfo → type
  TpApp : type → type → type
  TpAppt : type → term → type
  TpArrow : type → arrowtype → type → type
  TpEq : term → term → type
  TpHole : posinfo → type
  TpLambda : posinfo → posinfo → bvar → tk → type → type
  TpParens : posinfo → type → posinfo → type
  TpVar : posinfo → qvar → type
{-# COMPILED_DATA type CedilleTypes.Type CedilleTypes.Abs CedilleTypes.Iota CedilleTypes.Lft CedilleTypes.NoSpans CedilleTypes.TpApp CedilleTypes.TpAppt CedilleTypes.TpArrow CedilleTypes.TpEq CedilleTypes.TpHole CedilleTypes.TpLambda CedilleTypes.TpParens CedilleTypes.TpVar #-}

data vars where 
  VarsNext : var → vars → vars
  VarsStart : var → vars
{-# COMPILED_DATA vars CedilleTypes.Vars CedilleTypes.VarsNext CedilleTypes.VarsStart #-}

-- embedded types:
aterm : Set
aterm = term
atype : Set
atype = type
lliftingType : Set
lliftingType = liftingType
lterm : Set
lterm = term
ltype : Set
ltype = type
pterm : Set
pterm = term

data ParseTreeT : Set where
  parsed-arg : arg → ParseTreeT
  parsed-args : args → ParseTreeT
  parsed-arrowtype : arrowtype → ParseTreeT
  parsed-binder : binder → ParseTreeT
  parsed-cmd : cmd → ParseTreeT
  parsed-cmds : cmds → ParseTreeT
  parsed-decl : decl → ParseTreeT
  parsed-defTermOrType : defTermOrType → ParseTreeT
  parsed-imports : imports → ParseTreeT
  parsed-imprt : imprt → ParseTreeT
  parsed-kind : kind → ParseTreeT
  parsed-lam : lam → ParseTreeT
  parsed-leftRight : leftRight → ParseTreeT
  parsed-liftingType : liftingType → ParseTreeT
  parsed-lterms : lterms → ParseTreeT
  parsed-maybeAtype : maybeAtype → ParseTreeT
  parsed-maybeCheckType : maybeCheckType → ParseTreeT
  parsed-maybeErased : maybeErased → ParseTreeT
  parsed-maybeMinus : maybeMinus → ParseTreeT
  parsed-optAs : optAs → ParseTreeT
  parsed-optClass : optClass → ParseTreeT
  parsed-optTerm : optTerm → ParseTreeT
  parsed-optType : optType → ParseTreeT
  parsed-params : params → ParseTreeT
  parsed-rho : rho → ParseTreeT
  parsed-start : start → ParseTreeT
  parsed-term : term → ParseTreeT
  parsed-theta : theta → ParseTreeT
  parsed-tk : tk → ParseTreeT
  parsed-type : type → ParseTreeT
  parsed-vars : vars → ParseTreeT
  parsed-aterm : term → ParseTreeT
  parsed-atype : type → ParseTreeT
  parsed-lliftingType : liftingType → ParseTreeT
  parsed-lterm : term → ParseTreeT
  parsed-ltype : type → ParseTreeT
  parsed-pterm : term → ParseTreeT
  parsed-posinfo : posinfo → ParseTreeT
  parsed-alpha : alpha → ParseTreeT
  parsed-alpha-bar-3 : alpha-bar-3 → ParseTreeT
  parsed-alpha-range-1 : alpha-range-1 → ParseTreeT
  parsed-alpha-range-2 : alpha-range-2 → ParseTreeT
  parsed-bvar : bvar → ParseTreeT
  parsed-bvar-bar-13 : bvar-bar-13 → ParseTreeT
  parsed-fpth : fpth → ParseTreeT
  parsed-fpth-bar-15 : fpth-bar-15 → ParseTreeT
  parsed-fpth-bar-16 : fpth-bar-16 → ParseTreeT
  parsed-fpth-bar-17 : fpth-bar-17 → ParseTreeT
  parsed-fpth-plus-14 : fpth-plus-14 → ParseTreeT
  parsed-fpth-star-18 : fpth-star-18 → ParseTreeT
  parsed-kvar : kvar → ParseTreeT
  parsed-kvar-bar-19 : kvar-bar-19 → ParseTreeT
  parsed-kvar-star-20 : kvar-star-20 → ParseTreeT
  parsed-num : num → ParseTreeT
  parsed-num-plus-5 : num-plus-5 → ParseTreeT
  parsed-numone : numone → ParseTreeT
  parsed-numone-range-4 : numone-range-4 → ParseTreeT
  parsed-numpunct : numpunct → ParseTreeT
  parsed-numpunct-bar-10 : numpunct-bar-10 → ParseTreeT
  parsed-numpunct-bar-6 : numpunct-bar-6 → ParseTreeT
  parsed-numpunct-bar-7 : numpunct-bar-7 → ParseTreeT
  parsed-numpunct-bar-8 : numpunct-bar-8 → ParseTreeT
  parsed-numpunct-bar-9 : numpunct-bar-9 → ParseTreeT
  parsed-qkvar : qkvar → ParseTreeT
  parsed-qvar : qvar → ParseTreeT
  parsed-var : var → ParseTreeT
  parsed-var-bar-11 : var-bar-11 → ParseTreeT
  parsed-var-star-12 : var-star-12 → ParseTreeT
  parsed-anychar : ParseTreeT
  parsed-anychar-bar-68 : ParseTreeT
  parsed-anychar-bar-69 : ParseTreeT
  parsed-anychar-bar-70 : ParseTreeT
  parsed-anychar-bar-71 : ParseTreeT
  parsed-anychar-bar-72 : ParseTreeT
  parsed-aws : ParseTreeT
  parsed-aws-bar-74 : ParseTreeT
  parsed-aws-bar-75 : ParseTreeT
  parsed-aws-bar-76 : ParseTreeT
  parsed-comment : ParseTreeT
  parsed-comment-star-73 : ParseTreeT
  parsed-otherpunct : ParseTreeT
  parsed-otherpunct-bar-21 : ParseTreeT
  parsed-otherpunct-bar-22 : ParseTreeT
  parsed-otherpunct-bar-23 : ParseTreeT
  parsed-otherpunct-bar-24 : ParseTreeT
  parsed-otherpunct-bar-25 : ParseTreeT
  parsed-otherpunct-bar-26 : ParseTreeT
  parsed-otherpunct-bar-27 : ParseTreeT
  parsed-otherpunct-bar-28 : ParseTreeT
  parsed-otherpunct-bar-29 : ParseTreeT
  parsed-otherpunct-bar-30 : ParseTreeT
  parsed-otherpunct-bar-31 : ParseTreeT
  parsed-otherpunct-bar-32 : ParseTreeT
  parsed-otherpunct-bar-33 : ParseTreeT
  parsed-otherpunct-bar-34 : ParseTreeT
  parsed-otherpunct-bar-35 : ParseTreeT
  parsed-otherpunct-bar-36 : ParseTreeT
  parsed-otherpunct-bar-37 : ParseTreeT
  parsed-otherpunct-bar-38 : ParseTreeT
  parsed-otherpunct-bar-39 : ParseTreeT
  parsed-otherpunct-bar-40 : ParseTreeT
  parsed-otherpunct-bar-41 : ParseTreeT
  parsed-otherpunct-bar-42 : ParseTreeT
  parsed-otherpunct-bar-43 : ParseTreeT
  parsed-otherpunct-bar-44 : ParseTreeT
  parsed-otherpunct-bar-45 : ParseTreeT
  parsed-otherpunct-bar-46 : ParseTreeT
  parsed-otherpunct-bar-47 : ParseTreeT
  parsed-otherpunct-bar-48 : ParseTreeT
  parsed-otherpunct-bar-49 : ParseTreeT
  parsed-otherpunct-bar-50 : ParseTreeT
  parsed-otherpunct-bar-51 : ParseTreeT
  parsed-otherpunct-bar-52 : ParseTreeT
  parsed-otherpunct-bar-53 : ParseTreeT
  parsed-otherpunct-bar-54 : ParseTreeT
  parsed-otherpunct-bar-55 : ParseTreeT
  parsed-otherpunct-bar-56 : ParseTreeT
  parsed-otherpunct-bar-57 : ParseTreeT
  parsed-otherpunct-bar-58 : ParseTreeT
  parsed-otherpunct-bar-59 : ParseTreeT
  parsed-otherpunct-bar-60 : ParseTreeT
  parsed-otherpunct-bar-61 : ParseTreeT
  parsed-otherpunct-bar-62 : ParseTreeT
  parsed-otherpunct-bar-63 : ParseTreeT
  parsed-otherpunct-bar-64 : ParseTreeT
  parsed-otherpunct-bar-65 : ParseTreeT
  parsed-otherpunct-bar-66 : ParseTreeT
  parsed-otherpunct-bar-67 : ParseTreeT
  parsed-ows : ParseTreeT
  parsed-ows-star-78 : ParseTreeT
  parsed-ws : ParseTreeT
  parsed-ws-plus-77 : ParseTreeT

------------------------------------------
-- Parse tree printing functions
------------------------------------------


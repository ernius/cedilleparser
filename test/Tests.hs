module Main(main) where

import Prelude
import Test.HUnit
import CedilleTypes
import CedilleLexer hiding (main)
import CedilleParser hiding (main)
import Control.Arrow
import Control.Monad
import System.IO  
import qualified System.Exit as Exit

removeLexerPositions :: Either a [Token] -> Either a [TokenClass]
removeLexerPositions = right (map (\ (Token _ tc) -> tc))

test_lexer_str = "aaa"

test_lexer = TestCase (assertEqual "test lexer 0"
                        (removeLexerPositions (scanner test_lexer_str))
                        (Prelude.Right [TVar "aaa"]))

test_parser_str = unlines [
  "import ../hello/world . %comments",
  "import module . ",
  "%comments 2 ",
  "module Test . "
  ]

test_parser_module = TestCase (assertEqual "test parser 0"
                               (Prelude.Right (File (AlexPn 0 1 1) ImportsStart "Test" ParamsNil CmdsStart (AlexPn 34 2 1)))
                               (runAlex test_parser_str $ cedilleParser))

-- test_atype_hole_str = "  ●"
-- test_atype_hole = TestCase (assertEqual "test atype Hole"
--                        (Prelude.Right (TpHole (AlexPn 2 1 3)))
--                        (runAlex test_atype_hole_str $ atypes))

-- test_atype_qvar_str = " aaa "
-- test_atype_qvar = TestCase (assertEqual "test atype Qvar"
--                             (Prelude.Right (TpVar (AlexPn 1 1 2) "aaa"))
--                             (runAlex test_atype_qvar_str $ atypes))

-- test_atype_qvar2_str = " aaa.bbb.ccc "
-- test_atype_qvar2 = TestCase (assertEqual "test atype Qvar Qualified"
--                             (Prelude.Right (TpVar (AlexPn 1 1 2) "aaa.bbb.ccc"))
--                             (runAlex test_atype_qvar2_str $ atypes))


test_type_arrow_str = " cNat ➔ cNat "

test_type_arrow = TestCase (assertEqual "test type Arrow"
                             (Prelude.Right (TpArrow (TpVar (AlexPn 1 1 2) "cNat") UnerasedArrow (TpVar (AlexPn 8 1 9) "cNat")))
                             (runAlex test_type_arrow_str $ types))

test_parser_term_str = unlines [
  " Λ X . λ f . λ a . a  " ,
  ""                                             
  ]

test_parser_term = TestCase (assertEqual "test parser term"
                               (Prelude.Right (Lam (AlexPn 1 1 2) ErasedLambda (AlexPn 3 1 4) "X" NoClass (Lam (AlexPn 7 1 8) KeptLambda (AlexPn 9 1 10) "f" NoClass (Lam (AlexPn 13 1 14) KeptLambda (AlexPn 15 1 16) "a" NoClass (Var (AlexPn 19 1 20) "a")))))
                               (runAlex test_parser_term_str $ term))

test_parser_deftermtype_str = unlines [
    "cZ ◂ cNat = Λ X . λ f . λ a . a  " ,
--    "cS ◂ X ➔ X = a "  ,
    ""
  ]

test_parser_deftermtype = TestCase (assertEqual "test parser definition"
                                   (Prelude.Right (DefTerm (AlexPn 0 1 1) "cZ" (Type (TpVar (AlexPn 5 1 6) "cNat")) (Lam (AlexPn 12 1 13) ErasedLambda (AlexPn 14 1 15) "X" NoClass (Lam (AlexPn 18 1 19) KeptLambda (AlexPn 20 1 21) "f" NoClass (Lam (AlexPn 24 1 25) KeptLambda (AlexPn 26 1 27) "a" NoClass (Var (AlexPn 30 1 31) "a"))))))
                               (runAlex test_parser_deftermtype_str $ deftermtype))

test_parser_cmd_str = unlines [
--  "import ChurchNat ." ,                         
--  "cNat ◂ ★ = ∀ X : ★ . (X ➔ X) ➔ X ➔ X . " ,
--  "cZ ◂ cNat = Λ X . λ f . λ a . a.1  . " ,
    "cS ◂ X ➔ X  = λ n . Λ X . λ f . λ a . f (n · X f a) . "  ,
    " "
  ]

test_parser_cmd = TestCase (assertEqual "test parser command"
                            (Prelude.Right (DefTermOrType (DefTerm (AlexPn 0 1 1) "cS" (Type (TpArrow (TpVar (AlexPn 5 1 6) "X") UnerasedArrow (TpVar (AlexPn 9 1 10) "X"))) (Lam (AlexPn 14 1 15) KeptLambda (AlexPn 16 1 17) "n" NoClass (Lam (AlexPn 20 1 21) ErasedLambda (AlexPn 22 1 23) "X" NoClass (Lam (AlexPn 26 1 27) KeptLambda (AlexPn 28 1 29) "f" NoClass (Lam (AlexPn 32 1 33) KeptLambda (AlexPn 34 1 35) "a" NoClass (App (Var (AlexPn 38 1 39) "f") NotErased (Parens (AlexPn 40 1 41) (App (App (AppTp (Var (AlexPn 41 1 42) "n") (TpVar (AlexPn 45 1 46) "X")) NotErased (Var (AlexPn 47 1 48) "f")) NotErased (Var (AlexPn 49 1 50) "a")) (AlexPn 50 1 51)))))))) (AlexPn 52 1 53)))
                               (runAlex test_parser_cmd_str $ cmd))


test_parser_cnat_str = unlines [
  "module ChurchNat ."                         ,
  ""                                           ,
  "cNat ◂ ★ = ∀ X : ★ . (X ➔ X) ➔ X ➔ X . " ,
  ""                                           ,
  "cZ ◂ cNat = Λ X . λ f . λ a . a . "         ,
  ""                                           ,
  "cS ◂ cNat ➔ cNat = λ n . Λ X . λ f . λ a . f (n · X f a) . "
  ]

test_parser_cnat = TestCase (assertEqual "test parser cnat module"
                               (Prelude.Right (File (AlexPn 0 1 1) ImportsStart "ChurchNat" ParamsNil (CmdsNext (DefTermOrType (DefType (AlexPn 20 3 1) "cNat" (Star (AlexPn 27 3 8)) (Abs (AlexPn 31 3 12) All (AlexPn 33 3 14) "X" (Tkk (Star (AlexPn 37 3 18))) (TpArrow (TpParens (AlexPn 41 3 22) (TpArrow (TpVar (AlexPn 42 3 23) "X") UnerasedArrow (TpVar (AlexPn 46 3 27) "X")) (AlexPn 47 3 28)) UnerasedArrow (TpArrow (TpVar (AlexPn 51 3 32) "X") UnerasedArrow (TpVar (AlexPn 55 3 36) "X"))))) (AlexPn 57 3 38)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 61 5 1) "cZ" (Type (TpVar (AlexPn 66 5 6) "cNat")) (Lam (AlexPn 73 5 13) ErasedLambda (AlexPn 75 5 15) "X" NoClass (Lam (AlexPn 79 5 19) KeptLambda (AlexPn 81 5 21) "f" NoClass (Lam (AlexPn 85 5 25) KeptLambda (AlexPn 87 5 27) "a" NoClass (Var (AlexPn 91 5 31) "a"))))) (AlexPn 93 5 33)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 97 7 1) "cS" (Type (TpArrow (TpVar (AlexPn 102 7 6) "cNat") UnerasedArrow (TpVar (AlexPn 109 7 13) "cNat"))) (Lam (AlexPn 116 7 20) KeptLambda (AlexPn 118 7 22) "n" NoClass (Lam (AlexPn 122 7 26) ErasedLambda (AlexPn 124 7 28) "X" NoClass (Lam (AlexPn 128 7 32) KeptLambda (AlexPn 130 7 34) "f" NoClass (Lam (AlexPn 134 7 38) KeptLambda (AlexPn 136 7 40) "a" NoClass (App (Var (AlexPn 140 7 44) "f") NotErased (Parens (AlexPn 142 7 46) (App (App (AppTp (Var (AlexPn 143 7 47) "n") (TpVar (AlexPn 147 7 51) "X")) NotErased (Var (AlexPn 149 7 53) "f")) NotErased (Var (AlexPn 151 7 55) "a")) (AlexPn 152 7 56)))))))) (AlexPn 154 7 58)) CmdsStart))) (AlexPn 157 8 1)))
                               (runAlex test_parser_cnat_str $ cedilleParser))

testFromFile :: String -> IO String
testFromFile file = do
  handle <- openFile file ReadMode
  hGetContents handle

test_cnat = TestCase (do
                        cnt <- testFromFile "test/tests/cnat.ced"
                        (assertEqual "test file cnat.ced"
                          (Prelude.Right (File (AlexPn 0 1 1) ImportsStart "Cnat" ParamsNil (CmdsNext (DefTermOrType (DefType (AlexPn 15 3 1) "cNat" (Star (AlexPn 22 3 8)) (Abs (AlexPn 26 3 12) All (AlexPn 28 3 14) "X" (Tkk (Star (AlexPn 32 3 18))) (TpArrow (TpParens (AlexPn 36 3 22) (TpArrow (TpVar (AlexPn 37 3 23) "X") UnerasedArrow (TpVar (AlexPn 41 3 27) "X")) (AlexPn 42 3 28)) UnerasedArrow (TpArrow (TpVar (AlexPn 46 3 32) "X") UnerasedArrow (TpVar (AlexPn 50 3 36) "X"))))) (AlexPn 52 3 38)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 55 5 1) "cZ" (Type (TpVar (AlexPn 60 5 6) "cNat")) (Lam (AlexPn 67 5 13) ErasedLambda (AlexPn 69 5 15) "X" NoClass (Lam (AlexPn 73 5 19) KeptLambda (AlexPn 75 5 21) "f" NoClass (Lam (AlexPn 79 5 25) KeptLambda (AlexPn 81 5 27) "a" NoClass (Var (AlexPn 85 5 31) "a"))))) (AlexPn 87 5 33)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 90 7 1) "cS" (Type (TpArrow (TpVar (AlexPn 95 7 6) "cNat") UnerasedArrow (TpVar (AlexPn 102 7 13) "cNat"))) (Lam (AlexPn 109 7 20) KeptLambda (AlexPn 111 7 22) "n" NoClass (Lam (AlexPn 115 7 26) ErasedLambda (AlexPn 117 7 28) "X" NoClass (Lam (AlexPn 121 7 32) KeptLambda (AlexPn 123 7 34) "f" NoClass (Lam (AlexPn 127 7 38) KeptLambda (AlexPn 129 7 40) "a" NoClass (App (Var (AlexPn 133 7 44) "f") NotErased (Parens (AlexPn 135 7 46) (App (App (AppTp (Var (AlexPn 136 7 47) "n") (TpVar (AlexPn 140 7 51) "X")) NotErased (Var (AlexPn 142 7 53) "f")) NotErased (Var (AlexPn 144 7 55) "a")) (AlexPn 145 7 56)))))))) (AlexPn 147 7 58)) CmdsStart))) (AlexPn 152 11 1)))                          
                          (runAlex cnt $ cedilleParser)))

test_nat = TestCase (do
                        cnt <- testFromFile "test/tests/nat.ced"
                        (assertEqual "test file nat.ced"
                          (Prelude.Right (File (AlexPn 0 1 1) ImportsStart "Nat" ParamsNil (CmdsNext (ImportCmd (Import (AlexPn 14 3 1) "cnat" NoOptAs (ArgsNil (AlexPn 26 3 13)) (AlexPn 25 3 12))) (CmdsNext (DefTermOrType (DefType (AlexPn 28 5 1) "cNatInductive" (KndTpArrow (TpVar (AlexPn 44 5 17) "cNat") (Star (AlexPn 51 5 24))) (TpLambda (AlexPn 55 5 28) (AlexPn 59 5 32) "x" (Tkt (TpVar (AlexPn 61 5 34) "cNat")) (Abs (AlexPn 68 5 41) All (AlexPn 70 5 43) "Q" (Tkk (KndTpArrow (TpVar (AlexPn 74 5 47) "cNat") (Star (AlexPn 81 5 54)))) (TpArrow (TpParens (AlexPn 85 5 58) (Abs (AlexPn 86 5 59) All (AlexPn 88 5 61) "x" (Tkt (TpVar (AlexPn 92 5 65) "cNat")) (TpArrow (TpAppt (TpVar (AlexPn 99 5 72) "Q") (Var (AlexPn 101 5 74) "x")) UnerasedArrow (TpAppt (TpVar (AlexPn 105 5 78) "Q") (Parens (AlexPn 107 5 80) (App (Var (AlexPn 108 5 81) "cS") NotErased (Var (AlexPn 111 5 84) "x")) (AlexPn 112 5 85))))) (AlexPn 113 5 86)) UnerasedArrow (TpArrow (TpAppt (TpVar (AlexPn 117 5 90) "Q") (Var (AlexPn 119 5 92) "cZ")) UnerasedArrow (TpAppt (TpVar (AlexPn 124 5 97) "Q") (Var (AlexPn 126 5 99) "x"))))))) (AlexPn 127 5 100)) (CmdsNext (DefTermOrType (DefType (AlexPn 130 7 1) "Nat" (Star (AlexPn 136 7 7)) (Iota (AlexPn 140 7 11) (AlexPn 142 7 13) "x" (SomeType (TpVar (AlexPn 146 7 17) "cNat")) (TpAppt (TpVar (AlexPn 153 7 24) "cNatInductive") (Var (AlexPn 167 7 38) "x")))) (AlexPn 168 7 39)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 171 9 1) "Z" (Type (TpVar (AlexPn 175 9 5) "Nat")) (IotaPair (AlexPn 181 9 11) (Var (AlexPn 183 9 13) "cZ") (Lam (AlexPn 188 9 18) ErasedLambda (AlexPn 190 9 20) "X" NoClass (Lam (AlexPn 194 9 24) KeptLambda (AlexPn 196 9 26) "s" NoClass (Lam (AlexPn 200 9 30) KeptLambda (AlexPn 202 9 32) "z" NoClass (Var (AlexPn 206 9 36) "z")))) NoTerm (AlexPn 208 9 38))) (AlexPn 210 9 40)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 212 10 1) "S" (Type (TpArrow (TpVar (AlexPn 216 10 5) "Nat") UnerasedArrow (TpVar (AlexPn 222 10 11) "Nat"))) (Lam (AlexPn 228 10 17) KeptLambda (AlexPn 230 10 19) "n" NoClass (IotaPair (AlexPn 234 10 23) (App (Var (AlexPn 236 10 25) "cS") NotErased (IotaProj (Var (AlexPn 239 10 28) "n") "1" (AlexPn 240 10 29))) (Lam (AlexPn 245 10 34) ErasedLambda (AlexPn 247 10 36) "P" NoClass (Lam (AlexPn 251 10 40) KeptLambda (AlexPn 253 10 42) "s" NoClass (Lam (AlexPn 257 10 46) KeptLambda (AlexPn 259 10 48) "z" NoClass (App (App (Var (AlexPn 263 10 52) "s") Erased (IotaProj (Var (AlexPn 266 10 55) "n") "1" (AlexPn 267 10 56))) NotErased (Parens (AlexPn 270 10 59) (App (App (AppTp (IotaProj (Var (AlexPn 271 10 60) "n") "2" (AlexPn 272 10 61)) (TpVar (AlexPn 277 10 66) "P")) NotErased (Var (AlexPn 279 10 68) "s")) NotErased (Var (AlexPn 281 10 70) "z")) (AlexPn 282 10 71)))))) NoTerm (AlexPn 284 10 73)))) (AlexPn 286 10 75)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 289 12 1) "NatRec" (Type (TpArrow (TpVar (AlexPn 298 12 10) "Nat") UnerasedArrow (TpVar (AlexPn 304 12 16) "cNat"))) (Lam (AlexPn 311 12 23) KeptLambda (AlexPn 313 12 25) "n" NoClass (IotaProj (Var (AlexPn 317 12 29) "n") "1" (AlexPn 318 12 30)))) (AlexPn 321 12 33)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 324 14 1) "add" (Type (TpArrow (TpVar (AlexPn 330 14 7) "Nat") UnerasedArrow (TpArrow (TpVar (AlexPn 336 14 13) "Nat") UnerasedArrow (TpVar (AlexPn 342 14 19) "Nat")))) (Lam (AlexPn 348 14 25) KeptLambda (AlexPn 350 14 27) "m" NoClass (Lam (AlexPn 354 14 31) KeptLambda (AlexPn 356 14 33) "n" NoClass (App (App (AppTp (App (Var (AlexPn 360 14 37) "NatRec") NotErased (Var (AlexPn 367 14 44) "m")) (TpVar (AlexPn 371 14 48) "Nat")) NotErased (Var (AlexPn 375 14 52) "S")) NotErased (Var (AlexPn 377 14 54) "n"))))) (AlexPn 379 14 56)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 382 16 1) "mult" (Type (TpArrow (TpVar (AlexPn 389 16 8) "Nat") UnerasedArrow (TpArrow (TpVar (AlexPn 395 16 14) "Nat") UnerasedArrow (TpVar (AlexPn 401 16 20) "Nat")))) (Lam (AlexPn 407 16 26) KeptLambda (AlexPn 409 16 28) "m" NoClass (Lam (AlexPn 413 16 32) KeptLambda (AlexPn 415 16 34) "n" NoClass (App (App (AppTp (App (Var (AlexPn 419 16 38) "NatRec") NotErased (Var (AlexPn 426 16 45) "m")) (TpVar (AlexPn 430 16 49) "Nat")) NotErased (Parens (AlexPn 434 16 53) (App (Var (AlexPn 435 16 54) "add") NotErased (Var (AlexPn 439 16 58) "n")) (AlexPn 440 16 59))) NotErased (Var (AlexPn 442 16 61) "Z"))))) (AlexPn 444 16 63)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 447 18 1) "exp" (Type (TpArrow (TpVar (AlexPn 453 18 7) "Nat") UnerasedArrow (TpArrow (TpVar (AlexPn 459 18 13) "Nat") UnerasedArrow (TpVar (AlexPn 465 18 19) "Nat")))) (Lam (AlexPn 471 18 25) KeptLambda (AlexPn 473 18 27) "m" NoClass (Lam (AlexPn 477 18 31) KeptLambda (AlexPn 479 18 33) "n" NoClass (App (App (AppTp (App (Var (AlexPn 483 18 37) "NatRec") NotErased (Var (AlexPn 490 18 44) "n")) (TpVar (AlexPn 494 18 48) "Nat")) NotErased (Parens (AlexPn 498 18 52) (App (Var (AlexPn 499 18 53) "mult") NotErased (Var (AlexPn 504 18 58) "m")) (AlexPn 505 18 59))) NotErased (Parens (AlexPn 507 18 61) (App (Var (AlexPn 508 18 62) "S") NotErased (Var (AlexPn 510 18 64) "Z")) (AlexPn 511 18 65)))))) (AlexPn 513 18 67)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 516 20 1) "NatInd" (Type (Abs (AlexPn 525 20 10) Pi (AlexPn 527 20 12) "x" (Tkt (TpVar (AlexPn 531 20 16) "Nat")) (Abs (AlexPn 537 20 22) All (AlexPn 539 20 24) "Q" (Tkk (KndTpArrow (TpVar (AlexPn 543 20 28) "Nat") (Star (AlexPn 549 20 34)))) (TpArrow (TpParens (AlexPn 553 20 38) (Abs (AlexPn 554 20 39) All (AlexPn 556 20 41) "x" (Tkt (TpVar (AlexPn 560 20 45) "Nat")) (TpArrow (TpAppt (TpVar (AlexPn 566 20 51) "Q") (Var (AlexPn 568 20 53) "x")) UnerasedArrow (TpAppt (TpVar (AlexPn 572 20 57) "Q") (Parens (AlexPn 574 20 59) (App (Var (AlexPn 575 20 60) "S") NotErased (Var (AlexPn 577 20 62) "x")) (AlexPn 578 20 63))))) (AlexPn 579 20 64)) UnerasedArrow (TpArrow (TpAppt (TpVar (AlexPn 583 20 68) "Q") (Var (AlexPn 585 20 70) "Z")) UnerasedArrow (TpAppt (TpVar (AlexPn 589 20 74) "Q") (Var (AlexPn 591 20 76) "x"))))))) (Lam (AlexPn 597 21 3) KeptLambda (AlexPn 599 21 5) "x" NoClass (Lam (AlexPn 603 21 9) ErasedLambda (AlexPn 605 21 11) "Q" NoClass (Lam (AlexPn 609 21 15) KeptLambda (AlexPn 611 21 17) "s" NoClass (Lam (AlexPn 615 21 21) KeptLambda (AlexPn 617 21 23) "z" NoClass (App (AppTp (App (App (AppTp (App (Var (AlexPn 621 21 27) "a") NotErased (IotaProj (Var (AlexPn 627 22 5) "x") "2" (AlexPn 628 22 6))) (TpParens (AlexPn 633 22 11) (TpLambda (AlexPn 634 22 12) (AlexPn 638 22 16) "x" (Tkt (TpVar (AlexPn 640 22 18) "cNat")) (Abs (AlexPn 647 22 25) All (AlexPn 649 22 27) "X" (Tkk (Star (AlexPn 653 22 31))) (TpArrow (TpParens (AlexPn 657 22 35) (Abs (AlexPn 658 22 36) Pi (AlexPn 660 22 38) "x'" (Tkt (TpVar (AlexPn 665 22 43) "Nat")) (TpArrow (TpParens (AlexPn 671 22 49) (TpEq (Var (AlexPn 674 22 52) "x") (Var (AlexPn 678 22 56) "x'")) (AlexPn 682 22 60)) UnerasedArrow (TpArrow (TpAppt (TpVar (AlexPn 686 22 64) "Q") (Var (AlexPn 688 22 66) "x'")) UnerasedArrow (TpVar (AlexPn 693 22 71) "X")))) (AlexPn 694 22 72)) UnerasedArrow (TpVar (AlexPn 698 22 76) "X")))) (AlexPn 699 22 77))) NotErased (Parens (AlexPn 706 23 6) (Lam (AlexPn 707 23 7) ErasedLambda (AlexPn 709 23 9) "x'" NoClass (Lam (AlexPn 714 23 14) KeptLambda (AlexPn 716 23 16) "ih" NoClass (Lam (AlexPn 721 23 21) ErasedLambda (AlexPn 723 23 23) "X" NoClass (Lam (AlexPn 727 23 27) KeptLambda (AlexPn 729 23 29) "c" NoClass (App (AppTp (Var (AlexPn 733 23 33) "ih") (TpVar (AlexPn 738 23 38) "X")) NotErased (Parens (AlexPn 740 23 40) (Lam (AlexPn 741 23 41) KeptLambda (AlexPn 743 23 43) "x''" NoClass (Lam (AlexPn 749 23 49) KeptLambda (AlexPn 751 23 51) "e" NoClass (Lam (AlexPn 755 23 55) KeptLambda (AlexPn 757 23 57) "u" NoClass (App (App (App (Var (AlexPn 761 23 61) "c") NotErased (Parens (AlexPn 763 23 63) (App (Var (AlexPn 764 23 64) "S") NotErased (Var (AlexPn 766 23 66) "x''")) (AlexPn 769 23 69))) NotErased (Parens (AlexPn 771 23 71) (Rho (AlexPn 772 23 72) RhoPlain (Var (AlexPn 774 23 74) "e") (Beta (AlexPn 778 23 78) NoTerm)) (AlexPn 779 23 79))) NotErased (Parens (AlexPn 781 23 81) (App (App (Var (AlexPn 782 23 82) "s") Erased (Var (AlexPn 785 23 85) "x''")) NotErased (Var (AlexPn 789 23 89) "u")) (AlexPn 790 23 90)))))) (AlexPn 791 23 91))))))) (AlexPn 792 23 92))) NotErased (Parens (AlexPn 799 24 6) (Lam (AlexPn 800 24 7) ErasedLambda (AlexPn 802 24 9) "X" NoClass (Lam (AlexPn 806 24 13) KeptLambda (AlexPn 808 24 15) "c" NoClass (App (App (App (Var (AlexPn 812 24 19) "c") NotErased (Var (AlexPn 814 24 21) "Z")) NotErased (Beta (AlexPn 816 24 23) NoTerm)) NotErased (Var (AlexPn 818 24 25) "z")))) (AlexPn 819 24 26))) (TpParens (AlexPn 823 24 30) (TpAppt (TpVar (AlexPn 824 24 31) "Q") (Var (AlexPn 826 24 33) "x")) (AlexPn 827 24 34))) NotErased (Parens (AlexPn 829 24 36) (Lam (AlexPn 830 24 37) KeptLambda (AlexPn 832 24 39) "x'" NoClass (Lam (AlexPn 837 24 44) KeptLambda (AlexPn 839 24 46) "e" NoClass (Lam (AlexPn 843 24 50) KeptLambda (AlexPn 845 24 52) "u" NoClass (Rho (AlexPn 849 24 56) RhoPlain (Var (AlexPn 851 24 58) "e") (Var (AlexPn 855 24 62) "u"))))) (AlexPn 856 24 63)))))))) (AlexPn 857 24 64)) CmdsStart)))))))))) (AlexPn 862 28 1)))                          
                          (runAlex cnt $ cedilleParser)))

test_clist = TestCase (do
                        cnt <- testFromFile "test/tests/clist.ced"
                        (assertEqual "test file clist.ced"
                          (Prelude.Right (File (AlexPn 0 1 1) ImportsStart "Clist" ParamsNil (CmdsNext (DefTermOrType (DefType (AlexPn 16 3 1) "cList" (KndArrow (Star (AlexPn 24 3 9)) (Star (AlexPn 28 3 13))) (TpLambda (AlexPn 32 3 17) (AlexPn 36 3 21) "A" (Tkk (Star (AlexPn 38 3 23))) (Abs (AlexPn 42 3 27) All (AlexPn 44 3 29) "X" (Tkk (Star (AlexPn 48 3 33))) (TpArrow (TpParens (AlexPn 52 3 37) (TpArrow (TpVar (AlexPn 53 3 38) "A") UnerasedArrow (TpArrow (TpVar (AlexPn 57 3 42) "X") UnerasedArrow (TpVar (AlexPn 61 3 46) "X"))) (AlexPn 62 3 47)) UnerasedArrow (TpArrow (TpVar (AlexPn 66 3 51) "X") UnerasedArrow (TpVar (AlexPn 70 3 55) "X")))))) (AlexPn 72 3 57)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 75 5 1) "cNil" (Type (Abs (AlexPn 82 5 8) All (AlexPn 84 5 10) "A" (Tkk (Star (AlexPn 88 5 14))) (TpApp (TpVar (AlexPn 92 5 18) "cList") (TpVar (AlexPn 100 5 26) "A")))) (Lam (AlexPn 104 5 30) ErasedLambda (AlexPn 106 5 32) "A" NoClass (Lam (AlexPn 110 5 36) ErasedLambda (AlexPn 112 5 38) "X" NoClass (Lam (AlexPn 116 5 42) KeptLambda (AlexPn 118 5 44) "c" NoClass (Lam (AlexPn 122 5 48) KeptLambda (AlexPn 124 5 50) "n" NoClass (Var (AlexPn 128 5 54) "n")))))) (AlexPn 130 5 56)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 133 7 1) "cCons" (Type (Abs (AlexPn 141 7 9) All (AlexPn 143 7 11) "A" (Tkk (Star (AlexPn 147 7 15))) (TpArrow (TpVar (AlexPn 151 7 19) "A") UnerasedArrow (TpArrow (TpApp (TpVar (AlexPn 155 7 23) "cList") (TpVar (AlexPn 163 7 31) "A")) UnerasedArrow (TpApp (TpVar (AlexPn 167 7 35) "cList") (TpVar (AlexPn 175 7 43) "A")))))) (Lam (AlexPn 179 7 47) ErasedLambda (AlexPn 181 7 49) "A" NoClass (Lam (AlexPn 185 7 53) KeptLambda (AlexPn 187 7 55) "h" NoClass (Lam (AlexPn 191 7 59) KeptLambda (AlexPn 193 7 61) "t" NoClass (Lam (AlexPn 197 7 65) ErasedLambda (AlexPn 199 7 67) "X" NoClass (Lam (AlexPn 203 7 71) KeptLambda (AlexPn 205 7 73) "c" NoClass (Lam (AlexPn 209 7 77) KeptLambda (AlexPn 211 7 79) "n" NoClass (App (App (Var (AlexPn 215 7 83) "c") NotErased (Var (AlexPn 217 7 85) "h")) NotErased (Parens (AlexPn 219 7 87) (App (App (AppTp (Var (AlexPn 220 7 88) "t") (TpVar (AlexPn 224 7 92) "X")) NotErased (Var (AlexPn 226 7 94) "c")) NotErased (Var (AlexPn 228 7 96) "n")) (AlexPn 229 7 97)))))))))) (AlexPn 231 7 99)) CmdsStart))) (AlexPn 233 8 1)))                          
                          (runAlex cnt $ cedilleParser)))

test_list = TestCase (do
                        cnt <- testFromFile "test/tests/list.ced"
                        (assertEqual "test file list.ced"
                          (Prelude.Right (File (AlexPn 0 1 1) ImportsStart "List" ParamsNil (CmdsNext (ImportCmd (Import (AlexPn 15 3 1) "clist" NoOptAs (ArgsNil (AlexPn 28 3 14)) (AlexPn 27 3 13))) (CmdsNext (ImportCmd (Import (AlexPn 29 4 1) "nat" NoOptAs (ArgsNil (AlexPn 40 4 12)) (AlexPn 39 4 11))) (CmdsNext (DefTermOrType (DefType (AlexPn 42 6 1) "cListParametric" (KndPi (AlexPn 60 6 19) (AlexPn 62 6 21) "A" (Tkk (Star (AlexPn 66 6 25))) (KndTpArrow (TpApp (TpVar (AlexPn 70 6 29) "cList") (TpVar (AlexPn 78 6 37) "A")) (Star (AlexPn 82 6 41)))) (TpLambda (AlexPn 88 7 3) (AlexPn 92 7 7) "A" (Tkk (Star (AlexPn 94 7 9))) (TpLambda (AlexPn 98 7 13) (AlexPn 102 7 17) "l" (Tkt (TpApp (TpVar (AlexPn 104 7 19) "cList") (TpVar (AlexPn 112 7 27) "A"))) (Abs (AlexPn 116 7 31) All (AlexPn 118 7 33) "X" (Tkk (Star (AlexPn 122 7 37))) (Abs (AlexPn 126 7 41) All (AlexPn 128 7 43) "Q" (Tkk (KndTpArrow (TpVar (AlexPn 132 7 47) "X") (Star (AlexPn 136 7 51)))) (Abs (AlexPn 140 7 55) All (AlexPn 142 7 57) "cons" (Tkt (TpArrow (TpVar (AlexPn 149 7 64) "A") UnerasedArrow (TpArrow (TpVar (AlexPn 153 7 68) "X") UnerasedArrow (TpVar (AlexPn 157 7 72) "X")))) (Abs (AlexPn 161 7 76) All (AlexPn 163 7 78) "nil" (Tkt (TpVar (AlexPn 169 7 84) "X")) (TpArrow (TpParens (AlexPn 178 8 6) (Abs (AlexPn 179 8 7) Pi (AlexPn 181 8 9) "h" (Tkt (TpVar (AlexPn 185 8 13) "A")) (Abs (AlexPn 189 8 17) All (AlexPn 191 8 19) "t" (Tkt (TpVar (AlexPn 195 8 23) "X")) (TpArrow (TpAppt (TpVar (AlexPn 199 8 27) "Q") (Var (AlexPn 201 8 29) "t")) UnerasedArrow (TpAppt (TpVar (AlexPn 205 8 33) "Q") (Parens (AlexPn 207 8 35) (App (App (Var (AlexPn 208 8 36) "cons") NotErased (Var (AlexPn 213 8 41) "h")) NotErased (Var (AlexPn 215 8 43) "t")) (AlexPn 216 8 44)))))) (AlexPn 217 8 45)) UnerasedArrow (TpArrow (TpAppt (TpVar (AlexPn 221 8 49) "Q") (Var (AlexPn 223 8 51) "nil")) UnerasedArrow (TpAppt (TpVar (AlexPn 229 8 57) "Q") (Parens (AlexPn 231 8 59) (App (App (AppTp (Var (AlexPn 232 8 60) "l") (TpVar (AlexPn 236 8 64) "X")) NotErased (Var (AlexPn 238 8 66) "cons")) NotErased (Var (AlexPn 243 8 71) "nil")) (AlexPn 246 8 74)))))))))))) (AlexPn 248 8 76)) (CmdsNext (DefTermOrType (DefType (AlexPn 251 10 1) "List" (KndArrow (Star (AlexPn 258 10 8)) (Star (AlexPn 262 10 12))) (TpLambda (AlexPn 266 10 16) (AlexPn 270 10 20) "A" (Tkk (Star (AlexPn 272 10 22))) (Iota (AlexPn 276 10 26) (AlexPn 278 10 28) "x" (SomeType (TpApp (TpVar (AlexPn 282 10 32) "cList") (TpVar (AlexPn 290 10 40) "A"))) (Iota (AlexPn 294 10 44) (AlexPn 296 10 46) "_" (SomeType (TpEq (App (App (Var (AlexPn 302 10 52) "x") NotErased (Var (AlexPn 304 10 54) "cCons")) NotErased (Var (AlexPn 310 10 60) "cNil")) (Var (AlexPn 317 10 67) "x"))) (TpAppt (TpApp (TpVar (AlexPn 323 10 73) "cListParametric") (TpVar (AlexPn 341 10 91) "A")) (Var (AlexPn 343 10 93) "x")))))) (AlexPn 345 10 95)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 348 12 1) "Nil" (Type (Abs (AlexPn 354 12 7) All (AlexPn 356 12 9) "A" (Tkk (Star (AlexPn 360 12 13))) (TpApp (TpVar (AlexPn 364 12 17) "List") (TpVar (AlexPn 371 12 24) "A")))) (Lam (AlexPn 375 12 28) ErasedLambda (AlexPn 377 12 30) "A" NoClass (IotaPair (AlexPn 381 12 34) (AppTp (Var (AlexPn 383 12 36) "cNil") (TpVar (AlexPn 390 12 43) "A")) (IotaPair (AlexPn 394 12 47) (Beta (AlexPn 396 12 49) (SomeTerm (Var (AlexPn 398 12 51) "cNil") (AlexPn 402 12 55))) (Lam (AlexPn 406 12 59) ErasedLambda (AlexPn 408 12 61) "Q" NoClass (Lam (AlexPn 412 12 65) ErasedLambda (AlexPn 414 12 67) "Q" NoClass (Lam (AlexPn 418 12 71) ErasedLambda (AlexPn 420 12 73) "cons" NoClass (Lam (AlexPn 427 12 80) ErasedLambda (AlexPn 429 12 82) "nil" NoClass (Lam (AlexPn 435 12 88) KeptLambda (AlexPn 437 12 90) "c" NoClass (Lam (AlexPn 441 12 94) KeptLambda (AlexPn 443 12 96) "n" NoClass (Var (AlexPn 447 12 100) "n"))))))) NoTerm (AlexPn 449 12 102)) NoTerm (AlexPn 451 12 104)))) (AlexPn 452 12 105)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 455 14 1) "Cons" (Type (Abs (AlexPn 462 14 8) All (AlexPn 464 14 10) "A" (Tkk (Star (AlexPn 468 14 14))) (TpArrow (TpVar (AlexPn 472 14 18) "A") UnerasedArrow (TpArrow (TpApp (TpVar (AlexPn 476 14 22) "List") (TpVar (AlexPn 483 14 29) "A")) UnerasedArrow (TpApp (TpVar (AlexPn 487 14 33) "List") (TpVar (AlexPn 494 14 40) "A")))))) (Lam (AlexPn 500 15 3) ErasedLambda (AlexPn 502 15 5) "A" NoClass (Lam (AlexPn 506 15 9) KeptLambda (AlexPn 508 15 11) "h" NoClass (Lam (AlexPn 512 15 15) KeptLambda (AlexPn 514 15 17) "t" NoClass (IotaPair (AlexPn 522 16 5) (App (App (AppTp (Var (AlexPn 524 16 7) "cCons") (TpVar (AlexPn 532 16 15) "A")) NotErased (Var (AlexPn 534 16 17) "h")) NotErased (IotaProj (Var (AlexPn 536 16 19) "t") "1" (AlexPn 537 16 20))) (IotaPair (AlexPn 546 17 5) (Epsilon (AlexPn 548 17 7) Both EpsHnf (Rho (AlexPn 550 17 9) RhoPlain (IotaProj (IotaProj (Var (AlexPn 552 17 11) "t") "2" (AlexPn 553 17 12)) "1" (AlexPn 555 17 14)) (Beta (AlexPn 560 17 19) (SomeTerm (App (App (Var (AlexPn 562 17 21) "cCons") NotErased (Var (AlexPn 568 17 27) "h")) NotErased (Var (AlexPn 570 17 29) "t")) (AlexPn 571 17 30))))) (Lam (AlexPn 581 18 7) ErasedLambda (AlexPn 583 18 9) "X" NoClass (Lam (AlexPn 587 18 13) ErasedLambda (AlexPn 589 18 15) "Q" NoClass (Lam (AlexPn 593 18 19) ErasedLambda (AlexPn 595 18 21) "cons" NoClass (Lam (AlexPn 602 18 28) ErasedLambda (AlexPn 604 18 30) "nil" NoClass (Lam (AlexPn 610 18 36) KeptLambda (AlexPn 612 18 38) "c" NoClass (Lam (AlexPn 616 18 42) KeptLambda (AlexPn 618 18 44) "n" NoClass (App (App (App (Var (AlexPn 622 18 48) "c") NotErased (Var (AlexPn 624 18 50) "h")) Erased (Parens (AlexPn 627 18 53) (App (App (AppTp (IotaProj (Var (AlexPn 628 18 54) "t") "1" (AlexPn 629 18 55)) (TpVar (AlexPn 634 18 60) "X")) NotErased (Var (AlexPn 636 18 62) "cons")) NotErased (Var (AlexPn 641 18 67) "nil")) (AlexPn 644 18 70))) NotErased (Parens (AlexPn 646 18 72) (App (App (App (App (AppTp (AppTp (IotaProj (IotaProj (Var (AlexPn 647 18 73) "t") "2" (AlexPn 648 18 74)) "2" (AlexPn 650 18 76)) (TpVar (AlexPn 655 18 81) "X")) (TpVar (AlexPn 659 18 85) "Q")) Erased (Var (AlexPn 662 18 88) "cons")) Erased (Var (AlexPn 668 18 94) "nil")) NotErased (Var (AlexPn 672 18 98) "c")) NotErased (Var (AlexPn 674 18 100) "n")) (AlexPn 675 18 101))))))))) NoTerm (AlexPn 677 18 103)) NoTerm (AlexPn 679 18 105)))))) (AlexPn 680 18 106)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 683 20 1) "ListRec" (Type (Abs (AlexPn 693 20 11) All (AlexPn 695 20 13) "A" (Tkk (Star (AlexPn 699 20 17))) (TpArrow (TpApp (TpVar (AlexPn 703 20 21) "List") (TpVar (AlexPn 710 20 28) "A")) UnerasedArrow (TpApp (TpVar (AlexPn 714 20 32) "cList") (TpVar (AlexPn 722 20 40) "A"))))) (Lam (AlexPn 726 20 44) ErasedLambda (AlexPn 728 20 46) "A" NoClass (Lam (AlexPn 732 20 50) KeptLambda (AlexPn 734 20 52) "l" NoClass (IotaProj (Var (AlexPn 738 20 56) "l") "1" (AlexPn 739 20 57))))) (AlexPn 742 20 60)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 745 22 1) "ListInd" (Type (Abs (AlexPn 755 22 11) All (AlexPn 757 22 13) "A" (Tkk (Star (AlexPn 761 22 17))) (Abs (AlexPn 765 22 21) Pi (AlexPn 767 22 23) "l" (Tkt (TpApp (TpVar (AlexPn 771 22 27) "List") (TpVar (AlexPn 778 22 34) "A"))) (Abs (AlexPn 792 23 11) All (AlexPn 794 23 13) "P" (Tkk (KndTpArrow (TpApp (TpVar (AlexPn 798 23 17) "List") (TpVar (AlexPn 805 23 24) "A")) (Star (AlexPn 809 23 28)))) (TpArrow (TpParens (AlexPn 823 24 11) (Abs (AlexPn 824 24 12) Pi (AlexPn 826 24 14) "h" (Tkt (TpVar (AlexPn 830 24 18) "A")) (Abs (AlexPn 834 24 22) All (AlexPn 836 24 24) "t" (Tkt (TpApp (TpVar (AlexPn 840 24 28) "List") (TpVar (AlexPn 847 24 35) "A"))) (TpArrow (TpAppt (TpVar (AlexPn 851 24 39) "P") (Var (AlexPn 853 24 41) "t")) UnerasedArrow (TpAppt (TpVar (AlexPn 857 24 45) "P") (Parens (AlexPn 859 24 47) (App (App (AppTp (Var (AlexPn 860 24 48) "Cons") (TpVar (AlexPn 867 24 55) "A")) NotErased (Var (AlexPn 869 24 57) "h")) NotErased (Var (AlexPn 871 24 59) "t")) (AlexPn 872 24 60)))))) (AlexPn 873 24 61)) UnerasedArrow (TpArrow (TpAppt (TpVar (AlexPn 887 25 11) "P") (Parens (AlexPn 889 25 13) (AppTp (Var (AlexPn 890 25 14) "Nil") (TpVar (AlexPn 896 25 20) "A")) (AlexPn 897 25 21))) UnerasedArrow (TpAppt (TpVar (AlexPn 911 26 11) "P") (Var (AlexPn 913 26 13) "l")))))))) (Lam (AlexPn 917 26 17) ErasedLambda (AlexPn 919 26 19) "A" NoClass (Lam (AlexPn 923 26 23) KeptLambda (AlexPn 925 26 25) "l" NoClass (Lam (AlexPn 929 26 29) ErasedLambda (AlexPn 931 26 31) "P" NoClass (Lam (AlexPn 935 26 35) KeptLambda (AlexPn 937 26 37) "c" NoClass (Lam (AlexPn 941 26 41) KeptLambda (AlexPn 943 26 43) "n" NoClass (Rho (AlexPn 947 26 47) RhoPlain (Sigma (AlexPn 949 26 49) (IotaProj (IotaProj (Var (AlexPn 951 26 51) "l") "2" (AlexPn 952 26 52)) "1" (AlexPn 954 26 54))) (Parens (AlexPn 959 26 59) (App (App (App (App (AppTp (AppTp (IotaProj (IotaProj (Var (AlexPn 960 26 60) "l") "2" (AlexPn 961 26 61)) "2" (AlexPn 963 26 63)) (TpParens (AlexPn 968 26 68) (TpApp (TpVar (AlexPn 969 26 69) "List") (TpVar (AlexPn 976 26 76) "A")) (AlexPn 977 26 77))) (TpVar (AlexPn 981 26 81) "P")) Erased (Parens (AlexPn 984 26 84) (AppTp (Var (AlexPn 985 26 85) "Cons") (TpVar (AlexPn 992 26 92) "A")) (AlexPn 993 26 93))) Erased (Parens (AlexPn 996 26 96) (AppTp (Var (AlexPn 997 26 97) "Nil") (TpVar (AlexPn 1003 26 103) "A")) (AlexPn 1004 26 104))) NotErased (Var (AlexPn 1006 26 106) "c")) NotErased (Var (AlexPn 1008 26 108) "n")) (AlexPn 1009 26 109))))))))) (AlexPn 1011 26 111)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 1014 28 1) "append" (Type (Abs (AlexPn 1023 28 10) All (AlexPn 1025 28 12) "A" (Tkk (Star (AlexPn 1029 28 16))) (TpArrow (TpApp (TpVar (AlexPn 1033 28 20) "List") (TpVar (AlexPn 1040 28 27) "A")) UnerasedArrow (TpArrow (TpApp (TpVar (AlexPn 1044 28 31) "List") (TpVar (AlexPn 1051 28 38) "A")) UnerasedArrow (TpApp (TpVar (AlexPn 1055 28 42) "List") (TpVar (AlexPn 1062 28 49) "A")))))) (Lam (AlexPn 1068 29 3) ErasedLambda (AlexPn 1070 29 5) "A" NoClass (Lam (AlexPn 1074 29 9) KeptLambda (AlexPn 1076 29 11) "l1" NoClass (Lam (AlexPn 1081 29 16) KeptLambda (AlexPn 1083 29 18) "l2" NoClass (App (App (AppTp (App (AppTp (Var (AlexPn 1092 30 5) "ListRec") (TpVar (AlexPn 1102 30 15) "A")) NotErased (Var (AlexPn 1104 30 17) "l1")) (TpParens (AlexPn 1109 30 22) (TpApp (TpVar (AlexPn 1110 30 23) "List") (TpVar (AlexPn 1117 30 30) "A")) (AlexPn 1118 30 31))) NotErased (Parens (AlexPn 1126 31 7) (AppTp (Var (AlexPn 1127 31 8) "Cons") (TpVar (AlexPn 1134 31 15) "A")) (AlexPn 1135 31 16))) NotErased (Var (AlexPn 1143 32 7) "l2")))))) (AlexPn 1146 32 10)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 1149 34 1) "length" (Type (Abs (AlexPn 1158 34 10) All (AlexPn 1160 34 12) "A" (Tkk (Star (AlexPn 1164 34 16))) (TpArrow (TpApp (TpVar (AlexPn 1168 34 20) "List") (TpVar (AlexPn 1175 34 27) "A")) UnerasedArrow (TpVar (AlexPn 1179 34 31) "Nat")))) (Lam (AlexPn 1186 35 2) ErasedLambda (AlexPn 1188 35 4) "A" NoClass (Lam (AlexPn 1192 35 8) KeptLambda (AlexPn 1194 35 10) "l" NoClass (App (App (AppTp (App (AppTp (Var (AlexPn 1201 36 4) "ListRec") (TpVar (AlexPn 1211 36 14) "A")) NotErased (Var (AlexPn 1213 36 16) "l")) (TpVar (AlexPn 1217 36 20) "Nat")) NotErased (Parens (AlexPn 1226 37 6) (Lam (AlexPn 1227 37 7) KeptLambda (AlexPn 1229 37 9) "_" NoClass (Var (AlexPn 1233 37 13) "S")) (AlexPn 1234 37 14))) NotErased (Var (AlexPn 1236 37 16) "Z"))))) (AlexPn 1238 37 18)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 1241 39 1) "map" (Type (Abs (AlexPn 1247 39 7) All (AlexPn 1249 39 9) "A" (Tkk (Star (AlexPn 1253 39 13))) (Abs (AlexPn 1257 39 17) All (AlexPn 1259 39 19) "B" (Tkk (Star (AlexPn 1263 39 23))) (TpArrow (TpParens (AlexPn 1267 39 27) (TpArrow (TpVar (AlexPn 1268 39 28) "A") UnerasedArrow (TpVar (AlexPn 1272 39 32) "B")) (AlexPn 1273 39 33)) UnerasedArrow (TpArrow (TpApp (TpVar (AlexPn 1277 39 37) "List") (TpVar (AlexPn 1284 39 44) "A")) UnerasedArrow (TpApp (TpVar (AlexPn 1288 39 48) "List") (TpVar (AlexPn 1295 39 55) "B"))))))) (Lam (AlexPn 1301 40 3) ErasedLambda (AlexPn 1303 40 5) "A" NoClass (Lam (AlexPn 1307 40 9) ErasedLambda (AlexPn 1309 40 11) "B" NoClass (Lam (AlexPn 1313 40 15) KeptLambda (AlexPn 1315 40 17) "f" NoClass (Lam (AlexPn 1319 40 21) KeptLambda (AlexPn 1321 40 23) "l" NoClass (App (App (AppTp (App (AppTp (Var (AlexPn 1325 40 27) "ListRec") (TpVar (AlexPn 1335 40 37) "A")) NotErased (Var (AlexPn 1337 40 39) "l")) (TpParens (AlexPn 1341 40 43) (TpApp (TpVar (AlexPn 1342 40 44) "List") (TpVar (AlexPn 1349 40 51) "B")) (AlexPn 1350 40 52))) NotErased (Parens (AlexPn 1352 40 54) (Lam (AlexPn 1353 40 55) KeptLambda (AlexPn 1355 40 57) "a" NoClass (Lam (AlexPn 1359 40 61) KeptLambda (AlexPn 1361 40 63) "bl" NoClass (App (App (AppTp (Var (AlexPn 1366 40 68) "Cons") (TpVar (AlexPn 1373 40 75) "B")) NotErased (Parens (AlexPn 1375 40 77) (App (Var (AlexPn 1376 40 78) "f") NotErased (Var (AlexPn 1378 40 80) "a")) (AlexPn 1379 40 81))) NotErased (Var (AlexPn 1381 40 83) "bl")))) (AlexPn 1383 40 85))) NotErased (Parens (AlexPn 1385 40 87) (AppTp (Var (AlexPn 1386 40 88) "Nil") (TpVar (AlexPn 1392 40 94) "B")) (AlexPn 1393 40 95)))))))) (AlexPn 1395 40 97)) (CmdsNext (DefTermOrType (DefTerm (AlexPn 1398 42 1) "foldr" (Type (Abs (AlexPn 1406 42 9) All (AlexPn 1408 42 11) "A" (Tkk (Star (AlexPn 1412 42 15))) (Abs (AlexPn 1416 42 19) All (AlexPn 1418 42 21) "B" (Tkk (Star (AlexPn 1422 42 25))) (TpArrow (TpParens (AlexPn 1426 42 29) (TpArrow (TpVar (AlexPn 1427 42 30) "A") UnerasedArrow (TpArrow (TpVar (AlexPn 1431 42 34) "B") UnerasedArrow (TpVar (AlexPn 1435 42 38) "B"))) (AlexPn 1436 42 39)) UnerasedArrow (TpArrow (TpVar (AlexPn 1440 42 43) "B") UnerasedArrow (TpArrow (TpApp (TpVar (AlexPn 1444 42 47) "List") (TpVar (AlexPn 1451 42 54) "A")) UnerasedArrow (TpVar (AlexPn 1455 42 58) "B"))))))) (Lam (AlexPn 1461 43 3) ErasedLambda (AlexPn 1463 43 5) "A" NoClass (Lam (AlexPn 1467 43 9) ErasedLambda (AlexPn 1469 43 11) "B" NoClass (Lam (AlexPn 1473 43 15) KeptLambda (AlexPn 1475 43 17) "f" NoClass (Lam (AlexPn 1479 43 21) KeptLambda (AlexPn 1481 43 23) "i" NoClass (Lam (AlexPn 1485 43 27) KeptLambda (AlexPn 1487 43 29) "l" NoClass (App (App (AppTp (App (AppTp (Var (AlexPn 1491 43 33) "ListRec") (TpVar (AlexPn 1501 43 43) "A")) NotErased (Var (AlexPn 1503 43 45) "l")) (TpVar (AlexPn 1507 43 49) "B")) NotErased (Var (AlexPn 1509 43 51) "f")) NotErased (Var (AlexPn 1511 43 53) "i")))))))) (AlexPn 1513 43 55)) CmdsStart)))))))))))) (AlexPn 1515 44 1)))                          
                          (runAlex cnt $ cedilleParser)))


tests = TestList [ 
    TestLabel "test lexer"                 test_lexer          
  --, TestLabel "test atype hole" test_atype_hole 
  --, TestLabel "test atype qvar" test_atype_qvar 
  --, TestLabel "test atype qvar qualified" test_atype_qvar2 
  , TestLabel "test parser term"           test_parser_term 
  , TestLabel "test parser term defintion" test_parser_deftermtype 
  , TestLabel "test type arrow"            test_type_arrow 
  , TestLabel "test parser command"        test_parser_cmd 
  , TestLabel "test parser cnat module"    test_parser_cnat
  , TestLabel "test cnat.ced"              test_cnat
  , TestLabel "test nat.ced"               test_nat
  , TestLabel "test clist.ced"             test_clist
  , TestLabel "test list.ced"              test_list  
  ]

main = do
  count  <- Test.HUnit.runTestTT tests
  if Test.HUnit.failures count > 0    
    then Exit.exitFailure
    else return ()



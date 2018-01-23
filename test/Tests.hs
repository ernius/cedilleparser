{-# LANGUAGE OverloadedStrings #-}
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
import Data.Text (Text, pack)

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
                               (Prelude.Right (File "0" ImportsStart "Test" ParamsNil CmdsStart "34"))
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
                             (Prelude.Right (TpArrow (TpVar "1" "cNat") UnerasedArrow (TpVar "8" "cNat")))
                             (runAlex test_type_arrow_str $ types))

test_parser_term_str = unlines [
  " Λ X . λ f . λ a . a  " ,
  ""                                             
  ]

test_parser_term = TestCase (assertEqual "test parser term"
                               (Prelude.Right (Lam "1" ErasedLambda "3" "X" NoClass (Lam "7" KeptLambda "9" "f" NoClass (Lam "13" KeptLambda "15" "a" NoClass (Var "19" "a")))))
                               (runAlex test_parser_term_str $ term))

test_parser_deftermtype_str = unlines [
    "cZ ◂ cNat = Λ X . λ f . λ a . a  " ,
--    "cS ◂ X ➔ X = a "  ,
    ""
  ]

test_parser_deftermtype = TestCase (assertEqual "test parser definition"
                                   (Prelude.Right (DefTerm "0" "cZ" (Type (TpVar "5" "cNat")) (Lam "12" ErasedLambda "14" "X" NoClass (Lam "18" KeptLambda "20" "f" NoClass (Lam "24" KeptLambda "26" "a" NoClass (Var "30" "a"))))))
                                (runAlex test_parser_deftermtype_str $ deftermtype))

test_parser_cmd_str = unlines [
--  "import ChurchNat ." ,                         
--  "cNat ◂ ★ = ∀ X : ★ . (X ➔ X) ➔ X ➔ X . " ,
--  "cZ ◂ cNat = Λ X . λ f . λ a . a.1  . " ,
    "cS ◂ X ➔ X  = λ n . Λ X . λ f . λ a . f (n · X f a) . "  ,
    " "
  ]

test_parser_cmd = TestCase (assertEqual "test parser command"
                            (Prelude.Right (DefTermOrType (DefTerm "0" "cS" (Type (TpArrow (TpVar "5" "X") UnerasedArrow (TpVar "9" "X"))) (Lam "14" KeptLambda "16" "n" NoClass (Lam "20" ErasedLambda "22" "X" NoClass (Lam "26" KeptLambda "28" "f" NoClass (Lam "32" KeptLambda "34" "a" NoClass (App (Var "38" "f") NotErased (Parens "40" (App (App (AppTp (Var "41" "n") (TpVar "45" "X")) NotErased (Var "47" "f")) NotErased (Var "49" "a")) "51"))))))) "53"))
                               (runAlex test_parser_cmd_str $ cmd))

-- Problem shift-reduce confict in state 12 causes it is not correctly parsed

test_parser_liftingtype_str = unlines [
--  "    Π a : a . a ➔ ☆   "
    "     a ➔ ☆   "
  ]

test_parser_liftingtype = TestCase (assertEqual "test parser lifting type"
                                    (Prelude.Right (LiftTpArrow (TpVar "1" "a") (LiftStar "1")))
                                    (runAlex test_parser_liftingtype_str $ liftingtype))

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
                               (Prelude.Right
                                (File "0" ImportsStart "ChurchNat" ParamsNil (CmdsNext (DefTermOrType (DefType "20" "cNat" (Star "27") (Abs "31" All "33" "X" (Tkk (Star "37")) (TpArrow (TpParens "41" (TpArrow (TpVar "42" "X") UnerasedArrow (TpVar "46" "X")) "48") UnerasedArrow (TpArrow (TpVar "51" "X") UnerasedArrow (TpVar "55" "X"))))) "58") (CmdsNext (DefTermOrType (DefTerm "61" "cZ" (Type (TpVar "66" "cNat")) (Lam "73" ErasedLambda "75" "X" NoClass (Lam "79" KeptLambda "81" "f" NoClass (Lam "85" KeptLambda "87" "a" NoClass (Var "91" "a"))))) "94") (CmdsNext (DefTermOrType (DefTerm "97" "cS" (Type (TpArrow (TpVar "102" "cNat") UnerasedArrow (TpVar "109" "cNat"))) (Lam "116" KeptLambda "118" "n" NoClass (Lam "122" ErasedLambda "124" "X" NoClass (Lam "128" KeptLambda "130" "f" NoClass (Lam "134" KeptLambda "136" "a" NoClass (App (Var "140" "f") NotErased (Parens "142" (App (App (AppTp (Var "143" "n") (TpVar "147" "X")) NotErased (Var "149" "f")) NotErased (Var "151" "a")) "153"))))))) "155") CmdsStart))) "157"))
                               (runAlex test_parser_cnat_str $ cedilleParser))

testFromFile :: String -> IO String
testFromFile file = do
  handle <- openFile file ReadMode
  hGetContents handle

test_cnat = TestCase (do
                        cnt <- testFromFile "test/tests/cnat.ced"
                        (assertEqual "test file cnat.ced"
                          (Prelude.Right (File "0" ImportsStart "Cnat" ParamsNil (CmdsNext (DefTermOrType (DefType "15" "cNat" (Star "22") (Abs "26" All "28" "X" (Tkk (Star "32")) (TpArrow (TpParens "36" (TpArrow (TpVar "37" "X") UnerasedArrow (TpVar "41" "X")) "43") UnerasedArrow (TpArrow (TpVar "46" "X") UnerasedArrow (TpVar "50" "X"))))) "53") (CmdsNext (DefTermOrType (DefTerm "55" "cZ" (Type (TpVar "60" "cNat")) (Lam "67" ErasedLambda "69" "X" NoClass (Lam "73" KeptLambda "75" "f" NoClass (Lam "79" KeptLambda "81" "a" NoClass (Var "85" "a"))))) "88") (CmdsNext (DefTermOrType (DefTerm "90" "cS" (Type (TpArrow (TpVar "95" "cNat") UnerasedArrow (TpVar "102" "cNat"))) (Lam "109" KeptLambda "111" "n" NoClass (Lam "115" ErasedLambda "117" "X" NoClass (Lam "121" KeptLambda "123" "f" NoClass (Lam "127" KeptLambda "129" "a" NoClass (App (Var "133" "f") NotErased (Parens "135" (App (App (AppTp (Var "136" "n") (TpVar "140" "X")) NotErased (Var "142" "f")) NotErased (Var "144" "a")) "146"))))))) "148") CmdsStart))) "152"))                                       (runAlex cnt $ cedilleParser)))

test_nat = TestCase (do
                        cnt <- testFromFile "test/tests/nat.ced"
                        (assertEqual "test file nat.ced"
                          (Prelude.Right (File "0" ImportsStart "Nat" ParamsNil (CmdsNext (ImportCmd (Import "14" "cnat" NoOptAs (ArgsNil "26") "25")) (CmdsNext (DefTermOrType (DefType "28" "cNatInductive" (KndTpArrow (TpVar "44" "cNat") (Star "51")) (TpLambda "55" "59" "x" (Tkt (TpVar "61" "cNat")) (Abs "68" All "70" "Q" (Tkk (KndTpArrow (TpVar "74" "cNat") (Star "81"))) (TpArrow (TpParens "85" (Abs "86" All "88" "x" (Tkt (TpVar "92" "cNat")) (TpArrow (TpAppt (TpVar "99" "Q") (Var "101" "x")) UnerasedArrow (TpAppt (TpVar "105" "Q") (Parens "107" (App (Var "108" "cS") NotErased (Var "111" "x")) "113")))) "114") UnerasedArrow (TpArrow (TpAppt (TpVar "117" "Q") (Var "119" "cZ")) UnerasedArrow (TpAppt (TpVar "124" "Q") (Var "126" "x"))))))) "128") (CmdsNext (DefTermOrType (DefType "130" "Nat" (Star "136") (Iota "140" "142" "x" (SomeType (TpVar "146" "cNat")) (TpAppt (TpVar "153" "cNatInductive") (Var "167" "x")))) "169") (CmdsNext (DefTermOrType (DefTerm "171" "Z" (Type (TpVar "175" "Nat")) (IotaPair "181" (Var "183" "cZ") (Lam "188" ErasedLambda "190" "X" NoClass (Lam "194" KeptLambda "196" "s" NoClass (Lam "200" KeptLambda "202" "z" NoClass (Var "206" "z")))) NoTerm "208")) "211") (CmdsNext (DefTermOrType (DefTerm "212" "S" (Type (TpArrow (TpVar "216" "Nat") UnerasedArrow (TpVar "222" "Nat"))) (Lam "228" KeptLambda "230" "n" NoClass (IotaPair "234" (App (Var "236" "cS") NotErased (IotaProj (Var "239" "n") "1" "240")) (Lam "245" ErasedLambda "247" "P" NoClass (Lam "251" KeptLambda "253" "s" NoClass (Lam "257" KeptLambda "259" "z" NoClass (App (App (Var "263" "s") Erased (IotaProj (Var "266" "n") "1" "267")) NotErased (Parens "270" (App (App (AppTp (IotaProj (Var "271" "n") "2" "272") (TpVar "277" "P")) NotErased (Var "279" "s")) NotErased (Var "281" "z")) "283"))))) NoTerm "284"))) "287") (CmdsNext (DefTermOrType (DefTerm "289" "NatRec" (Type (TpArrow (TpVar "298" "Nat") UnerasedArrow (TpVar "304" "cNat"))) (Lam "311" KeptLambda "313" "n" NoClass (IotaProj (Var "317" "n") "1" "318"))) "322") (CmdsNext (DefTermOrType (DefTerm "324" "add" (Type (TpArrow (TpVar "330" "Nat") UnerasedArrow (TpArrow (TpVar "336" "Nat") UnerasedArrow (TpVar "342" "Nat")))) (Lam "348" KeptLambda "350" "m" NoClass (Lam "354" KeptLambda "356" "n" NoClass (App (App (AppTp (App (Var "360" "NatRec") NotErased (Var "367" "m")) (TpVar "371" "Nat")) NotErased (Var "375" "S")) NotErased (Var "377" "n"))))) "380") (CmdsNext (DefTermOrType (DefTerm "382" "mult" (Type (TpArrow (TpVar "389" "Nat") UnerasedArrow (TpArrow (TpVar "395" "Nat") UnerasedArrow (TpVar "401" "Nat")))) (Lam "407" KeptLambda "409" "m" NoClass (Lam "413" KeptLambda "415" "n" NoClass (App (App (AppTp (App (Var "419" "NatRec") NotErased (Var "426" "m")) (TpVar "430" "Nat")) NotErased (Parens "434" (App (Var "435" "add") NotErased (Var "439" "n")) "441")) NotErased (Var "442" "Z"))))) "445") (CmdsNext (DefTermOrType (DefTerm "447" "exp" (Type (TpArrow (TpVar "453" "Nat") UnerasedArrow (TpArrow (TpVar "459" "Nat") UnerasedArrow (TpVar "465" "Nat")))) (Lam "471" KeptLambda "473" "m" NoClass (Lam "477" KeptLambda "479" "n" NoClass (App (App (AppTp (App (Var "483" "NatRec") NotErased (Var "490" "n")) (TpVar "494" "Nat")) NotErased (Parens "498" (App (Var "499" "mult") NotErased (Var "504" "m")) "506")) NotErased (Parens "507" (App (Var "508" "S") NotErased (Var "510" "Z")) "512"))))) "514") (CmdsNext (DefTermOrType (DefTerm "516" "NatInd" (Type (Abs "525" Pi "527" "x" (Tkt (TpVar "531" "Nat")) (Abs "537" All "539" "Q" (Tkk (KndTpArrow (TpVar "543" "Nat") (Star "549"))) (TpArrow (TpParens "553" (Abs "554" All "556" "x" (Tkt (TpVar "560" "Nat")) (TpArrow (TpAppt (TpVar "566" "Q") (Var "568" "x")) UnerasedArrow (TpAppt (TpVar "572" "Q") (Parens "574" (App (Var "575" "S") NotErased (Var "577" "x")) "579")))) "580") UnerasedArrow (TpArrow (TpAppt (TpVar "583" "Q") (Var "585" "Z")) UnerasedArrow (TpAppt (TpVar "589" "Q") (Var "591" "x"))))))) (Lam "597" KeptLambda "599" "x" NoClass (Lam "603" ErasedLambda "605" "Q" NoClass (Lam "609" KeptLambda "611" "s" NoClass (Lam "615" KeptLambda "617" "z" NoClass (App (AppTp (App (App (AppTp (App (Var "621" "a") NotErased (IotaProj (Var "627" "x") "2" "628")) (TpParens "633" (TpLambda "634" "638" "x" (Tkt (TpVar "640" "cNat")) (Abs "647" All "649" "X" (Tkk (Star "653")) (TpArrow (TpParens "657" (Abs "658" Pi "660" "x'" (Tkt (TpVar "665" "Nat")) (TpArrow (TpParens "671" (TpEq (Var "674" "x") (Var "678" "x'")) "683") UnerasedArrow (TpArrow (TpAppt (TpVar "686" "Q") (Var "688" "x'")) UnerasedArrow (TpVar "693" "X")))) "695") UnerasedArrow (TpVar "698" "X")))) "700")) NotErased (Parens "706" (Lam "707" ErasedLambda "709" "x'" NoClass (Lam "714" KeptLambda "716" "ih" NoClass (Lam "721" ErasedLambda "723" "X" NoClass (Lam "727" KeptLambda "729" "c" NoClass (App (AppTp (Var "733" "ih") (TpVar "738" "X")) NotErased (Parens "740" (Lam "741" KeptLambda "743" "x''" NoClass (Lam "749" KeptLambda "751" "e" NoClass (Lam "755" KeptLambda "757" "u" NoClass (App (App (App (Var "761" "c") NotErased (Parens "763" (App (Var "764" "S") NotErased (Var "766" "x''")) "770")) NotErased (Parens "771" (Rho "772" RhoPlain (Var "774" "e") (Beta "778" NoTerm)) "780")) NotErased (Parens "781" (App (App (Var "782" "s") Erased (Var "785" "x''")) NotErased (Var "789" "u")) "791"))))) "792")))))) "793")) NotErased (Parens "799" (Lam "800" ErasedLambda "802" "X" NoClass (Lam "806" KeptLambda "808" "c" NoClass (App (App (App (Var "812" "c") NotErased (Var "814" "Z")) NotErased (Beta "816" NoTerm)) NotErased (Var "818" "z")))) "820")) (TpParens "823" (TpAppt (TpVar "824" "Q") (Var "826" "x")) "828")) NotErased (Parens "829" (Lam "830" KeptLambda "832" "x'" NoClass (Lam "837" KeptLambda "839" "e" NoClass (Lam "843" KeptLambda "845" "u" NoClass (Rho "849" RhoPlain (Var "851" "e") (Var "855" "u"))))) "857"))))))) "858") CmdsStart)))))))))) "862"))
                          (runAlex cnt $ cedilleParser)))

test_clist = TestCase (do
                        cnt <- testFromFile "test/tests/clist.ced"
                        (assertEqual "test file clist.ced"
                          (Prelude.Right (File "0" ImportsStart "Clist" ParamsNil (CmdsNext (DefTermOrType (DefType "16" "cList" (KndArrow (Star "24") (Star "28")) (TpLambda "32" "36" "A" (Tkk (Star "38")) (Abs "42" All "44" "X" (Tkk (Star "48")) (TpArrow (TpParens "52" (TpArrow (TpVar "53" "A") UnerasedArrow (TpArrow (TpVar "57" "X") UnerasedArrow (TpVar "61" "X"))) "63") UnerasedArrow (TpArrow (TpVar "66" "X") UnerasedArrow (TpVar "70" "X")))))) "73") (CmdsNext (DefTermOrType (DefTerm "75" "cNil" (Type (Abs "82" All "84" "A" (Tkk (Star "88")) (TpApp (TpVar "92" "cList") (TpVar "100" "A")))) (Lam "104" ErasedLambda "106" "A" NoClass (Lam "110" ErasedLambda "112" "X" NoClass (Lam "116" KeptLambda "118" "c" NoClass (Lam "122" KeptLambda "124" "n" NoClass (Var "128" "n")))))) "131") (CmdsNext (DefTermOrType (DefTerm "133" "cCons" (Type (Abs "141" All "143" "A" (Tkk (Star "147")) (TpArrow (TpVar "151" "A") UnerasedArrow (TpArrow (TpApp (TpVar "155" "cList") (TpVar "163" "A")) UnerasedArrow (TpApp (TpVar "167" "cList") (TpVar "175" "A")))))) (Lam "179" ErasedLambda "181" "A" NoClass (Lam "185" KeptLambda "187" "h" NoClass (Lam "191" KeptLambda "193" "t" NoClass (Lam "197" ErasedLambda "199" "X" NoClass (Lam "203" KeptLambda "205" "c" NoClass (Lam "209" KeptLambda "211" "n" NoClass (App (App (Var "215" "c") NotErased (Var "217" "h")) NotErased (Parens "219" (App (App (AppTp (Var "220" "t") (TpVar "224" "X")) NotErased (Var "226" "c")) NotErased (Var "228" "n")) "230"))))))))) "232") CmdsStart))) "233"))                          
                          (runAlex cnt $ cedilleParser)))

test_list = TestCase (do
                        cnt <- testFromFile "test/tests/list.ced"
                        (assertEqual "test file list.ced"
                          (Prelude.Right (File "0" ImportsStart "List" ParamsNil (CmdsNext (ImportCmd (Import "15" "clist" NoOptAs (ArgsNil "28") "27")) (CmdsNext (ImportCmd (Import "29" "nat" NoOptAs (ArgsNil "40") "39")) (CmdsNext (DefTermOrType (DefType "42" "cListParametric" (KndPi "60" "62" "A" (Tkk (Star "66")) (KndTpArrow (TpApp (TpVar "70" "cList") (TpVar "78" "A")) (Star "82"))) (TpLambda "88" "92" "A" (Tkk (Star "94")) (TpLambda "98" "102" "l" (Tkt (TpApp (TpVar "104" "cList") (TpVar "112" "A"))) (Abs "116" All "118" "X" (Tkk (Star "122")) (Abs "126" All "128" "Q" (Tkk (KndTpArrow (TpVar "132" "X") (Star "136"))) (Abs "140" All "142" "cons" (Tkt (TpArrow (TpVar "149" "A") UnerasedArrow (TpArrow (TpVar "153" "X") UnerasedArrow (TpVar "157" "X")))) (Abs "161" All "163" "nil" (Tkt (TpVar "169" "X")) (TpArrow (TpParens "178" (Abs "179" Pi "181" "h" (Tkt (TpVar "185" "A")) (Abs "189" All "191" "t" (Tkt (TpVar "195" "X")) (TpArrow (TpAppt (TpVar "199" "Q") (Var "201" "t")) UnerasedArrow (TpAppt (TpVar "205" "Q") (Parens "207" (App (App (Var "208" "cons") NotErased (Var "213" "h")) NotErased (Var "215" "t")) "217"))))) "218") UnerasedArrow (TpArrow (TpAppt (TpVar "221" "Q") (Var "223" "nil")) UnerasedArrow (TpAppt (TpVar "229" "Q") (Parens "231" (App (App (AppTp (Var "232" "l") (TpVar "236" "X")) NotErased (Var "238" "cons")) NotErased (Var "243" "nil")) "247"))))))))))) "249") (CmdsNext (DefTermOrType (DefType "251" "List" (KndArrow (Star "258") (Star "262")) (TpLambda "266" "270" "A" (Tkk (Star "272")) (Iota "276" "278" "x" (SomeType (TpApp (TpVar "282" "cList") (TpVar "290" "A"))) (Iota "294" "296" "_" (SomeType (TpEq (App (App (Var "302" "x") NotErased (Var "304" "cCons")) NotErased (Var "310" "cNil")) (Var "317" "x"))) (TpAppt (TpApp (TpVar "323" "cListParametric") (TpVar "341" "A")) (Var "343" "x")))))) "346") (CmdsNext (DefTermOrType (DefTerm "348" "Nil" (Type (Abs "354" All "356" "A" (Tkk (Star "360")) (TpApp (TpVar "364" "List") (TpVar "371" "A")))) (Lam "375" ErasedLambda "377" "A" NoClass (IotaPair "381" (AppTp (Var "383" "cNil") (TpVar "390" "A")) (IotaPair "394" (Beta "396" (SomeTerm (Var "398" "cNil") "402")) (Lam "406" ErasedLambda "408" "Q" NoClass (Lam "412" ErasedLambda "414" "Q" NoClass (Lam "418" ErasedLambda "420" "cons" NoClass (Lam "427" ErasedLambda "429" "nil" NoClass (Lam "435" KeptLambda "437" "c" NoClass (Lam "441" KeptLambda "443" "n" NoClass (Var "447" "n"))))))) NoTerm "449") NoTerm "451"))) "453") (CmdsNext (DefTermOrType (DefTerm "455" "Cons" (Type (Abs "462" All "464" "A" (Tkk (Star "468")) (TpArrow (TpVar "472" "A") UnerasedArrow (TpArrow (TpApp (TpVar "476" "List") (TpVar "483" "A")) UnerasedArrow (TpApp (TpVar "487" "List") (TpVar "494" "A")))))) (Lam "500" ErasedLambda "502" "A" NoClass (Lam "506" KeptLambda "508" "h" NoClass (Lam "512" KeptLambda "514" "t" NoClass (IotaPair "522" (App (App (AppTp (Var "524" "cCons") (TpVar "532" "A")) NotErased (Var "534" "h")) NotErased (IotaProj (Var "536" "t") "1" "537")) (IotaPair "546" (Epsilon "548" Both EpsHnf (Rho "550" RhoPlain (IotaProj (IotaProj (Var "552" "t") "2" "553") "1" "555") (Beta "560" (SomeTerm (App (App (Var "562" "cCons") NotErased (Var "568" "h")) NotErased (Var "570" "t")) "571")))) (Lam "581" ErasedLambda "583" "X" NoClass (Lam "587" ErasedLambda "589" "Q" NoClass (Lam "593" ErasedLambda "595" "cons" NoClass (Lam "602" ErasedLambda "604" "nil" NoClass (Lam "610" KeptLambda "612" "c" NoClass (Lam "616" KeptLambda "618" "n" NoClass (App (App (App (Var "622" "c") NotErased (Var "624" "h")) Erased (Parens "627" (App (App (AppTp (IotaProj (Var "628" "t") "1" "629") (TpVar "634" "X")) NotErased (Var "636" "cons")) NotErased (Var "641" "nil")) "645")) NotErased (Parens "646" (App (App (App (App (AppTp (AppTp (IotaProj (IotaProj (Var "647" "t") "2" "648") "2" "650") (TpVar "655" "X")) (TpVar "659" "Q")) Erased (Var "662" "cons")) Erased (Var "668" "nil")) NotErased (Var "672" "c")) NotErased (Var "674" "n")) "676")))))))) NoTerm "677") NoTerm "679"))))) "681") (CmdsNext (DefTermOrType (DefTerm "683" "ListRec" (Type (Abs "693" All "695" "A" (Tkk (Star "699")) (TpArrow (TpApp (TpVar "703" "List") (TpVar "710" "A")) UnerasedArrow (TpApp (TpVar "714" "cList") (TpVar "722" "A"))))) (Lam "726" ErasedLambda "728" "A" NoClass (Lam "732" KeptLambda "734" "l" NoClass (IotaProj (Var "738" "l") "1" "739")))) "743") (CmdsNext (DefTermOrType (DefTerm "745" "ListInd" (Type (Abs "755" All "757" "A" (Tkk (Star "761")) (Abs "765" Pi "767" "l" (Tkt (TpApp (TpVar "771" "List") (TpVar "778" "A"))) (Abs "792" All "794" "P" (Tkk (KndTpArrow (TpApp (TpVar "798" "List") (TpVar "805" "A")) (Star "809"))) (TpArrow (TpParens "823" (Abs "824" Pi "826" "h" (Tkt (TpVar "830" "A")) (Abs "834" All "836" "t" (Tkt (TpApp (TpVar "840" "List") (TpVar "847" "A"))) (TpArrow (TpAppt (TpVar "851" "P") (Var "853" "t")) UnerasedArrow (TpAppt (TpVar "857" "P") (Parens "859" (App (App (AppTp (Var "860" "Cons") (TpVar "867" "A")) NotErased (Var "869" "h")) NotErased (Var "871" "t")) "873"))))) "874") UnerasedArrow (TpArrow (TpAppt (TpVar "887" "P") (Parens "889" (AppTp (Var "890" "Nil") (TpVar "896" "A")) "898")) UnerasedArrow (TpAppt (TpVar "911" "P") (Var "913" "l")))))))) (Lam "917" ErasedLambda "919" "A" NoClass (Lam "923" KeptLambda "925" "l" NoClass (Lam "929" ErasedLambda "931" "P" NoClass (Lam "935" KeptLambda "937" "c" NoClass (Lam "941" KeptLambda "943" "n" NoClass (Rho "947" RhoPlain (Sigma "949" (IotaProj (IotaProj (Var "951" "l") "2" "952") "1" "954")) (Parens "959" (App (App (App (App (AppTp (AppTp (IotaProj (IotaProj (Var "960" "l") "2" "961") "2" "963") (TpParens "968" (TpApp (TpVar "969" "List") (TpVar "976" "A")) "978")) (TpVar "981" "P")) Erased (Parens "984" (AppTp (Var "985" "Cons") (TpVar "992" "A")) "994")) Erased (Parens "996" (AppTp (Var "997" "Nil") (TpVar "1003" "A")) "1005")) NotErased (Var "1006" "c")) NotErased (Var "1008" "n")) "1010")))))))) "1012") (CmdsNext (DefTermOrType (DefTerm "1014" "append" (Type (Abs "1023" All "1025" "A" (Tkk (Star "1029")) (TpArrow (TpApp (TpVar "1033" "List") (TpVar "1040" "A")) UnerasedArrow (TpArrow (TpApp (TpVar "1044" "List") (TpVar "1051" "A")) UnerasedArrow (TpApp (TpVar "1055" "List") (TpVar "1062" "A")))))) (Lam "1068" ErasedLambda "1070" "A" NoClass (Lam "1074" KeptLambda "1076" "l1" NoClass (Lam "1081" KeptLambda "1083" "l2" NoClass (App (App (AppTp (App (AppTp (Var "1092" "ListRec") (TpVar "1102" "A")) NotErased (Var "1104" "l1")) (TpParens "1109" (TpApp (TpVar "1110" "List") (TpVar "1117" "A")) "1119")) NotErased (Parens "1126" (AppTp (Var "1127" "Cons") (TpVar "1134" "A")) "1136")) NotErased (Var "1143" "l2")))))) "1147") (CmdsNext (DefTermOrType (DefTerm "1149" "length" (Type (Abs "1158" All "1160" "A" (Tkk (Star "1164")) (TpArrow (TpApp (TpVar "1168" "List") (TpVar "1175" "A")) UnerasedArrow (TpVar "1179" "Nat")))) (Lam "1186" ErasedLambda "1188" "A" NoClass (Lam "1192" KeptLambda "1194" "l" NoClass (App (App (AppTp (App (AppTp (Var "1201" "ListRec") (TpVar "1211" "A")) NotErased (Var "1213" "l")) (TpVar "1217" "Nat")) NotErased (Parens "1226" (Lam "1227" KeptLambda "1229" "_" NoClass (Var "1233" "S")) "1235")) NotErased (Var "1236" "Z"))))) "1239") (CmdsNext (DefTermOrType (DefTerm "1241" "map" (Type (Abs "1247" All "1249" "A" (Tkk (Star "1253")) (Abs "1257" All "1259" "B" (Tkk (Star "1263")) (TpArrow (TpParens "1267" (TpArrow (TpVar "1268" "A") UnerasedArrow (TpVar "1272" "B")) "1274") UnerasedArrow (TpArrow (TpApp (TpVar "1277" "List") (TpVar "1284" "A")) UnerasedArrow (TpApp (TpVar "1288" "List") (TpVar "1295" "B"))))))) (Lam "1301" ErasedLambda "1303" "A" NoClass (Lam "1307" ErasedLambda "1309" "B" NoClass (Lam "1313" KeptLambda "1315" "f" NoClass (Lam "1319" KeptLambda "1321" "l" NoClass (App (App (AppTp (App (AppTp (Var "1325" "ListRec") (TpVar "1335" "A")) NotErased (Var "1337" "l")) (TpParens "1341" (TpApp (TpVar "1342" "List") (TpVar "1349" "B")) "1351")) NotErased (Parens "1352" (Lam "1353" KeptLambda "1355" "a" NoClass (Lam "1359" KeptLambda "1361" "bl" NoClass (App (App (AppTp (Var "1366" "Cons") (TpVar "1373" "B")) NotErased (Parens "1375" (App (Var "1376" "f") NotErased (Var "1378" "a")) "1380")) NotErased (Var "1381" "bl")))) "1384")) NotErased (Parens "1385" (AppTp (Var "1386" "Nil") (TpVar "1392" "B")) "1394"))))))) "1396") (CmdsNext (DefTermOrType (DefTerm "1398" "foldr" (Type (Abs "1406" All "1408" "A" (Tkk (Star "1412")) (Abs "1416" All "1418" "B" (Tkk (Star "1422")) (TpArrow (TpParens "1426" (TpArrow (TpVar "1427" "A") UnerasedArrow (TpArrow (TpVar "1431" "B") UnerasedArrow (TpVar "1435" "B"))) "1437") UnerasedArrow (TpArrow (TpVar "1440" "B") UnerasedArrow (TpArrow (TpApp (TpVar "1444" "List") (TpVar "1451" "A")) UnerasedArrow (TpVar "1455" "B"))))))) (Lam "1461" ErasedLambda "1463" "A" NoClass (Lam "1467" ErasedLambda "1469" "B" NoClass (Lam "1473" KeptLambda "1475" "f" NoClass (Lam "1479" KeptLambda "1481" "i" NoClass (Lam "1485" KeptLambda "1487" "l" NoClass (App (App (AppTp (App (AppTp (Var "1491" "ListRec") (TpVar "1501" "A")) NotErased (Var "1503" "l")) (TpVar "1507" "B")) NotErased (Var "1509" "f")) NotErased (Var "1511" "i")))))))) "1514") CmdsStart)))))))))))) "1515"))                                                     (runAlex cnt $ cedilleParser)))

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

  -- shift/reduce conflict problematic test
  --TestLabel "test lifting type"          test_parser_liftingtype
  ]

main = do
  count  <- Test.HUnit.runTestTT tests
  if Test.HUnit.failures count > 0    
    then Exit.exitFailure
    else return ()



{-# OPTIONS_GHC -w #-}
{-# OPTIONS -cpp #-}
module CedilleParser where

import CedilleTypes
import CedilleLexer hiding (main)
import Data.Text(Text,pack,unpack)
import qualified Data.Array as Happy_Data_Array
import qualified System.IO as Happy_System_IO
import qualified System.IO.Unsafe as Happy_System_IO_Unsafe
import qualified Debug.Trace as Happy_Debug_Trace
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn10 (Start)
	| HappyAbsSyn11 (Imprt)
	| HappyAbsSyn12 (OptAs)
	| HappyAbsSyn13 (Imports)
	| HappyAbsSyn14 (Cmds)
	| HappyAbsSyn15 (Cmd)
	| HappyAbsSyn16 (MaybeCheckType)
	| HappyAbsSyn17 (Params)
	| HappyAbsSyn18 (DefTermOrType)
	| HappyAbsSyn19 (Decl)
	| HappyAbsSyn20 ((Theta, PosInfo))
	| HappyAbsSyn21 (Vars)
	| HappyAbsSyn22 ((Rho, PosInfo))
	| HappyAbsSyn23 (OptTerm)
	| HappyAbsSyn24 (Term)
	| HappyAbsSyn28 (MaybeAtype)
	| HappyAbsSyn29 (Lterms)
	| HappyAbsSyn30 (OptClass)
	| HappyAbsSyn31 (OptType)
	| HappyAbsSyn32 ((Lam , PosInfo))
	| HappyAbsSyn33 (Type)
	| HappyAbsSyn36 (Arg)
	| HappyAbsSyn37 (Args)
	| HappyAbsSyn38 (Kind)
	| HappyAbsSyn40 (LiftingType)
	| HappyAbsSyn42 (Tk)
	| HappyAbsSyn43 (Token)
	| HappyAbsSyn46 (PosInfo)

happyActOffsets :: Happy_Data_Array.Array Int Int
happyActOffsets = Happy_Data_Array.listArray (0,247) ([452,456,91,416,461,11,44,447,447,437,47,399,165,0,394,398,0,0,0,456,44,91,14,14,14,14,445,0,0,0,382,404,378,393,366,366,456,432,432,366,263,0,414,14,0,432,432,432,432,432,432,412,0,0,410,0,0,91,91,0,0,368,432,5,0,346,456,14,346,362,0,0,367,341,0,0,0,91,357,347,353,364,343,0,0,0,0,0,0,321,0,0,5,432,305,407,0,324,319,14,316,1,0,311,292,291,290,282,264,-26,295,286,44,0,5,456,456,44,278,0,0,78,0,259,360,284,0,0,0,0,0,0,0,0,91,1,1,1,249,456,91,116,251,205,360,1,14,0,91,226,0,7,335,0,0,432,432,0,0,224,1,91,0,0,0,91,218,432,1,0,0,219,0,0,212,0,0,91,0,335,0,214,216,14,1,0,206,211,0,288,0,0,5,7,456,1,204,0,456,208,207,202,193,0,192,191,11,0,0,44,456,456,0,-28,0,0,0,0,0,0,1,188,171,0,7,0,0,174,456,0,0,1,0,175,0,44,0,0,0,0,11,0,0,1,169,7,0,0
	])

happyGotoOffsets :: Happy_Data_Array.Array Int Int
happyGotoOffsets = Happy_Data_Array.listArray (0,247) ([141,797,546,181,161,190,781,178,154,0,126,0,641,0,0,0,0,0,0,793,769,537,160,159,153,138,0,0,0,0,0,0,143,147,0,0,785,635,629,0,627,0,0,102,0,621,615,608,606,600,475,108,0,0,99,0,0,523,514,0,0,92,411,-8,0,0,773,76,0,0,0,0,0,0,0,0,0,500,0,0,0,93,0,0,0,0,0,0,0,75,0,0,26,376,0,594,0,0,112,41,0,761,0,0,69,0,0,0,0,0,0,0,757,0,22,541,401,745,56,0,0,37,0,57,573,0,0,0,0,0,0,0,0,0,489,726,714,702,0,351,454,339,0,0,560,738,21,0,217,0,0,815,585,0,0,304,267,0,0,0,690,168,0,0,0,136,0,60,678,0,0,0,0,0,24,0,0,53,0,72,0,16,0,-4,666,0,0,0,0,557,0,0,-7,808,329,371,0,0,279,0,0,0,0,0,0,0,846,0,0,299,257,244,0,-15,0,0,0,0,0,0,654,0,0,0,800,0,0,0,-3,0,0,642,0,0,0,225,0,0,0,-23,128,0,0,176,0,749,0,0
	])

happyDefActions :: Happy_Data_Array.Array Int Int
happyDefActions = Happy_Data_Array.listArray (0,247) ([-12,0,0,-19,0,0,0,0,-12,0,0,0,-76,-82,0,-100,-84,-107,-108,0,0,0,0,0,0,0,0,-85,-101,-16,0,0,-19,-21,0,0,0,0,0,0,-38,-42,-53,0,-54,0,0,0,0,0,0,0,-26,-27,0,-31,-32,0,0,-69,-68,-33,0,-60,-58,0,0,0,0,0,-106,-105,0,0,-59,-50,-43,0,0,0,0,-29,0,-49,-48,-47,-46,-45,-44,-64,-56,-39,0,0,0,-111,-20,0,-21,0,0,0,-17,0,-66,0,0,0,0,0,0,0,0,-81,0,0,0,0,-10,-110,-109,0,-13,-21,-111,0,-99,-75,-74,-80,-98,-77,-102,-83,0,0,0,0,0,0,0,-76,0,-93,-111,0,0,-94,0,0,-22,0,-111,-37,-61,0,0,-40,-41,0,0,0,-30,-28,-55,0,0,0,0,-103,-104,0,-52,-34,-33,-36,-65,0,-51,-111,-62,0,0,0,0,-23,0,0,-86,-111,-96,-88,0,0,0,0,0,-67,0,0,0,0,0,-11,0,0,-14,-9,-78,0,0,0,-73,0,-92,-24,-91,-87,-89,-95,0,0,0,-18,0,-63,-35,0,0,-70,-57,0,-25,0,-79,0,-72,-71,-97,-111,-14,-15,-8,0,0,0,-90
	])

happyCheck :: Happy_Data_Array.Array Int Int
happyCheck = Happy_Data_Array.listArray (0,901) ([-1,29,1,2,30,4,1,2,1,2,18,4,1,36,3,1,31,25,25,18,23,24,25,49,13,53,34,34,12,33,29,34,16,17,29,34,29,13,37,38,39,27,41,42,37,1,2,25,1,42,34,25,5,52,33,54,34,52,2,52,34,54,18,10,7,12,9,14,15,16,17,34,12,29,33,22,16,17,34,1,2,37,38,39,12,41,42,34,16,17,21,19,1,2,34,20,52,53,7,8,9,10,11,12,11,13,34,16,36,33,11,20,21,22,23,24,8,1,2,7,29,9,31,7,8,9,10,11,12,1,39,40,4,5,43,33,8,46,47,23,24,0,1,52,3,29,10,31,12,6,14,15,16,17,7,1,9,3,22,43,44,35,46,47,48,49,1,2,52,8,34,33,7,8,9,10,11,12,10,1,12,3,14,15,16,17,33,6,23,24,22,1,33,33,29,5,31,28,8,23,24,25,34,28,28,29,32,36,43,44,34,46,47,48,49,1,2,52,30,28,28,7,8,9,10,11,12,10,35,12,28,14,15,16,17,28,28,23,24,22,36,30,36,29,28,31,34,28,23,24,25,34,28,35,49,30,31,43,44,34,46,47,36,49,1,2,52,23,24,25,7,8,9,10,11,12,25,28,34,12,23,24,25,16,17,1,23,24,29,1,2,34,29,15,31,7,8,9,10,11,12,34,23,24,25,19,43,44,45,46,47,23,24,34,50,52,12,29,36,31,16,17,23,24,25,30,36,36,36,30,31,43,44,34,46,47,1,2,34,28,52,25,7,8,9,10,11,12,29,25,45,12,23,24,25,16,17,36,23,24,17,1,2,34,29,1,31,7,8,9,10,11,12,34,23,24,25,30,43,26,45,46,47,23,24,34,45,52,12,29,33,31,16,17,23,24,25,30,36,28,29,55,34,43,44,34,46,47,1,2,34,1,52,1,7,8,9,10,11,12,6,55,29,12,23,24,25,16,17,51,23,24,28,1,2,34,29,55,31,7,8,9,10,11,12,34,1,49,49,55,43,14,45,46,47,23,24,1,2,52,13,29,1,31,10,13,12,51,14,15,16,17,-1,-1,18,43,22,-1,46,47,-1,-1,-1,-1,52,29,-1,12,34,-1,34,16,17,37,38,39,-1,41,42,10,-1,12,-1,14,15,16,17,-1,52,34,10,22,12,-1,14,15,16,17,-1,-1,-1,-1,22,34,10,-1,12,-1,14,15,16,17,-1,10,34,12,22,14,15,16,17,-1,-1,-1,-1,22,-1,10,34,12,-1,14,15,16,17,-1,10,34,12,22,14,15,16,17,23,24,25,-1,22,12,-1,34,12,16,17,34,16,17,-1,-1,34,-1,-1,26,27,12,26,27,-1,16,17,34,-1,36,34,-1,36,12,-1,26,27,16,17,-1,19,-1,12,34,-1,36,16,17,12,19,-1,-1,16,17,12,34,12,36,16,17,16,17,-1,12,34,-1,36,16,17,12,34,-1,-1,16,17,12,34,12,34,16,17,16,17,12,-1,34,-1,16,17,12,-1,34,-1,16,17,-1,-1,34,-1,34,-1,23,24,25,-1,34,28,29,-1,-1,32,34,34,23,24,25,-1,-1,28,29,-1,-1,32,-1,34,23,24,25,-1,-1,28,29,-1,-1,32,-1,34,23,24,25,-1,-1,28,29,-1,-1,32,-1,34,23,24,25,-1,-1,28,29,-1,-1,32,-1,34,23,24,25,-1,-1,28,29,-1,-1,32,-1,34,23,24,25,-1,-1,28,29,-1,-1,32,-1,34,23,24,25,-1,-1,28,29,-1,-1,32,-1,34,23,24,25,-1,-1,28,29,23,24,25,-1,34,24,25,30,31,28,29,34,23,24,25,34,23,24,25,30,31,28,29,34,23,24,25,34,23,24,25,30,31,-1,-1,34,23,24,25,34,23,24,25,30,31,-1,-1,34,23,24,25,34,23,24,25,-1,24,25,-1,34,28,29,-1,34,24,25,34,-1,28,29,-1,24,25,-1,34,28,29,-1,-1,1,-1,34,4,5,-1,-1,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	])

happyTable :: Happy_Data_Array.Array Int Int
happyTable = Happy_Data_Array.listArray (0,901) ([0,236,18,19,134,145,18,19,18,19,73,145,33,242,34,71,234,74,217,20,229,12,13,118,11,29,16,16,38,222,146,16,113,42,67,22,146,227,147,24,25,72,26,27,184,18,19,129,120,27,44,158,121,28,186,148,16,28,124,28,16,148,20,37,205,38,98,226,40,41,42,123,38,21,149,43,172,42,22,18,19,23,24,25,38,26,27,44,152,42,138,225,18,19,44,159,28,29,46,47,48,49,50,51,162,76,44,52,154,69,80,53,54,55,56,57,82,18,19,150,58,98,59,46,47,48,49,50,51,29,60,61,241,240,62,89,31,63,64,56,57,68,8,65,9,58,37,59,38,100,174,40,41,42,97,8,98,122,43,62,115,118,63,64,116,196,18,19,65,34,44,104,46,47,48,49,50,51,37,8,38,9,175,40,41,42,105,35,56,57,43,29,106,107,58,30,59,246,31,229,141,13,44,244,246,143,231,232,62,115,16,63,64,116,117,18,19,65,233,207,208,46,47,48,49,50,51,37,209,38,210,185,40,41,42,211,212,56,57,43,214,220,221,58,224,59,78,229,11,12,13,44,178,174,194,110,15,62,115,16,63,64,185,225,18,19,65,236,12,13,46,47,48,49,50,51,195,199,16,38,237,12,13,178,42,204,56,57,100,18,19,16,58,126,59,46,47,48,49,50,51,44,212,12,13,132,62,93,94,63,64,56,57,16,135,65,38,58,136,59,179,42,11,12,13,133,137,138,140,238,15,62,193,16,63,64,18,19,44,141,65,149,46,47,48,49,50,51,100,152,157,38,215,12,13,113,42,161,56,57,162,18,19,16,58,82,59,46,47,48,49,50,51,44,197,12,13,165,62,164,156,63,64,56,57,16,168,65,38,58,166,59,157,42,127,141,13,134,169,214,143,-1,78,62,193,16,63,64,18,19,44,82,65,33,46,47,48,49,50,51,91,-1,100,38,127,12,13,75,42,102,56,57,103,18,19,16,58,-1,59,46,47,48,49,50,51,44,104,113,118,-1,62,122,156,63,64,56,57,18,19,65,11,58,33,59,37,11,38,37,196,40,41,42,0,0,20,62,43,0,63,64,0,0,0,0,65,67,0,38,44,0,22,83,42,68,24,25,0,26,27,37,0,38,0,202,40,41,42,0,28,44,37,43,38,0,166,40,41,42,0,0,0,0,43,44,37,0,38,0,78,40,41,42,0,37,44,38,43,79,40,41,42,0,0,0,0,43,0,37,44,38,0,108,40,41,42,0,37,44,38,43,39,40,41,42,128,12,13,0,43,38,0,44,38,188,42,16,188,42,0,0,44,0,0,189,218,38,189,190,0,188,42,44,0,191,44,0,191,38,0,189,204,152,42,0,180,0,38,44,0,191,152,42,38,153,0,0,84,42,38,44,38,154,85,42,86,42,0,38,44,0,154,87,42,38,44,0,0,88,42,38,44,38,44,91,42,94,42,38,0,44,0,95,42,38,0,44,0,113,42,0,0,44,0,44,0,169,141,13,0,44,170,143,0,0,244,44,16,169,141,13,0,0,170,143,0,0,233,0,16,169,141,13,0,0,170,143,0,0,221,0,16,169,141,13,0,0,170,143,0,0,171,0,16,169,141,13,0,0,170,143,0,0,176,0,16,169,141,13,0,0,170,143,0,0,199,0,16,169,141,13,0,0,170,143,0,0,200,0,16,201,141,13,0,0,170,143,0,0,171,0,16,72,141,13,0,0,187,143,11,12,13,0,16,181,13,126,15,246,143,16,11,12,13,16,96,141,13,130,15,142,143,16,109,12,13,16,72,12,13,110,15,0,0,16,11,12,13,16,96,12,13,14,15,0,0,16,111,12,13,16,65,12,13,0,181,13,0,16,214,143,0,16,181,13,16,0,216,143,0,181,13,0,16,182,143,0,0,29,0,16,239,240,0,0,31,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

happyReduceArr = Happy_Data_Array.array (7, 110) [
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40),
	(41 , happyReduce_41),
	(42 , happyReduce_42),
	(43 , happyReduce_43),
	(44 , happyReduce_44),
	(45 , happyReduce_45),
	(46 , happyReduce_46),
	(47 , happyReduce_47),
	(48 , happyReduce_48),
	(49 , happyReduce_49),
	(50 , happyReduce_50),
	(51 , happyReduce_51),
	(52 , happyReduce_52),
	(53 , happyReduce_53),
	(54 , happyReduce_54),
	(55 , happyReduce_55),
	(56 , happyReduce_56),
	(57 , happyReduce_57),
	(58 , happyReduce_58),
	(59 , happyReduce_59),
	(60 , happyReduce_60),
	(61 , happyReduce_61),
	(62 , happyReduce_62),
	(63 , happyReduce_63),
	(64 , happyReduce_64),
	(65 , happyReduce_65),
	(66 , happyReduce_66),
	(67 , happyReduce_67),
	(68 , happyReduce_68),
	(69 , happyReduce_69),
	(70 , happyReduce_70),
	(71 , happyReduce_71),
	(72 , happyReduce_72),
	(73 , happyReduce_73),
	(74 , happyReduce_74),
	(75 , happyReduce_75),
	(76 , happyReduce_76),
	(77 , happyReduce_77),
	(78 , happyReduce_78),
	(79 , happyReduce_79),
	(80 , happyReduce_80),
	(81 , happyReduce_81),
	(82 , happyReduce_82),
	(83 , happyReduce_83),
	(84 , happyReduce_84),
	(85 , happyReduce_85),
	(86 , happyReduce_86),
	(87 , happyReduce_87),
	(88 , happyReduce_88),
	(89 , happyReduce_89),
	(90 , happyReduce_90),
	(91 , happyReduce_91),
	(92 , happyReduce_92),
	(93 , happyReduce_93),
	(94 , happyReduce_94),
	(95 , happyReduce_95),
	(96 , happyReduce_96),
	(97 , happyReduce_97),
	(98 , happyReduce_98),
	(99 , happyReduce_99),
	(100 , happyReduce_100),
	(101 , happyReduce_101),
	(102 , happyReduce_102),
	(103 , happyReduce_103),
	(104 , happyReduce_104),
	(105 , happyReduce_105),
	(106 , happyReduce_106),
	(107 , happyReduce_107),
	(108 , happyReduce_108),
	(109 , happyReduce_109),
	(110 , happyReduce_110)
	]

happy_n_terms = 56 :: Int
happy_n_nonterms = 37 :: Int

happyReduce_7 = happyReduce 7 0 happyReduction_7
happyReduction_7 ((HappyAbsSyn46  happy_var_7) `HappyStk`
	(HappyAbsSyn14  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	(HappyAbsSyn43  happy_var_3) `HappyStk`
	(HappyTerminal (Token happy_var_2 TModule)) `HappyStk`
	(HappyAbsSyn13  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (File (pos2Txt happy_var_2) happy_var_1 (tTxt happy_var_3) happy_var_4 happy_var_6 happy_var_7
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 5 1 happyReduction_8
happyReduction_8 ((HappyTerminal (Token happy_var_5 (TSym "."))) `HappyStk`
	(HappyAbsSyn37  happy_var_4) `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 TImport)) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Import (pos2Txt happy_var_1) (tTxt happy_var_2) happy_var_3 happy_var_4 (pos2Txt happy_var_5)
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_0  2 happyReduction_9
happyReduction_9  =  HappyAbsSyn12
		 (NoOptAs
	)

happyReduce_10 = happySpecReduce_2  2 happyReduction_10
happyReduction_10 (HappyTerminal happy_var_2)
	_
	 =  HappyAbsSyn12
		 (SomeOptAs (tTxt happy_var_2)
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_0  3 happyReduction_11
happyReduction_11  =  HappyAbsSyn13
		 (ImportsStart
	)

happyReduce_12 = happySpecReduce_2  3 happyReduction_12
happyReduction_12 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn13
		 (ImportsNext happy_var_1 happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_0  4 happyReduction_13
happyReduction_13  =  HappyAbsSyn14
		 (CmdsStart
	)

happyReduce_14 = happySpecReduce_2  4 happyReduction_14
happyReduction_14 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (CmdsNext happy_var_1 happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  5 happyReduction_15
happyReduction_15 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn15
		 (ImportCmd happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  5 happyReduction_16
happyReduction_16 (HappyTerminal (Token happy_var_2 (TSym ".")))
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn15
		 (DefTermOrType happy_var_1 (pos2Txt happy_var_2)
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happyReduce 5 5 happyReduction_17
happyReduction_17 ((HappyTerminal (Token happy_var_5 (TSym "."))) `HappyStk`
	(HappyAbsSyn38  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (DefKind (tPosTxt happy_var_1) (tTxt happy_var_1) happy_var_2 happy_var_4 (pos2Txt happy_var_5)
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_0  6 happyReduction_18
happyReduction_18  =  HappyAbsSyn16
		 (NoCheckType
	)

happyReduce_19 = happySpecReduce_2  6 happyReduction_19
happyReduction_19 (HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (Type happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_0  7 happyReduction_20
happyReduction_20  =  HappyAbsSyn17
		 (ParamsNil
	)

happyReduce_21 = happySpecReduce_2  7 happyReduction_21
happyReduction_21 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn17
		 (ParamsCons happy_var_1 happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happyReduce 4 8 happyReduction_22
happyReduction_22 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (DefTerm (tPosTxt happy_var_1) (tTxt happy_var_1) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 5 8 happyReduction_23
happyReduction_23 ((HappyAbsSyn33  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (DefType (tPosTxt happy_var_1) (tTxt happy_var_1) happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 5 9 happyReduction_24
happyReduction_24 ((HappyTerminal (Token happy_var_5 (TSym ")"))) `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "("))) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (Decl (pos2Txt happy_var_1) (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_4 (pos2Txt happy_var_5)
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_1  10 happyReduction_25
happyReduction_25 (HappyTerminal (Token happy_var_1 TTheta))
	 =  HappyAbsSyn20
		 ((Abstract       , pos2Txt happy_var_1)
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  10 happyReduction_26
happyReduction_26 (HappyTerminal (Token happy_var_1 TThetaEq))
	 =  HappyAbsSyn20
		 ((AbstractEq     , pos2Txt happy_var_1)
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  10 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn21  happy_var_2)
	(HappyTerminal (Token happy_var_1 TThetaVars))
	 =  HappyAbsSyn20
		 ((AbstractVars happy_var_2, pos2Txt happy_var_1)
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  11 happyReduction_28
happyReduction_28 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn21
		 (VarsStart (tTxt happy_var_1)
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  11 happyReduction_29
happyReduction_29 (HappyAbsSyn21  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn21
		 (VarsNext  (tTxt happy_var_1) happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  12 happyReduction_30
happyReduction_30 (HappyTerminal (Token happy_var_1 TRhoPlain))
	 =  HappyAbsSyn22
		 ((RhoPlain, pos2Txt happy_var_1)
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  12 happyReduction_31
happyReduction_31 (HappyTerminal (Token happy_var_1 TRhoPlus))
	 =  HappyAbsSyn22
		 ((RhoPlus , pos2Txt happy_var_1)
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_0  13 happyReduction_32
happyReduction_32  =  HappyAbsSyn23
		 (NoTerm
	)

happyReduce_33 = happySpecReduce_3  13 happyReduction_33
happyReduction_33 (HappyTerminal (Token happy_var_3 (TSym "}")))
	(HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (SomeTerm happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happyReduce 5 14 happyReduction_34
happyReduction_34 ((HappyAbsSyn24  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyAbsSyn32  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Lam (snd happy_var_1) (fst happy_var_1) (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 4 14 happyReduction_35
happyReduction_35 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 TLet)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Let (pos2Txt happy_var_1) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_36 = happySpecReduce_3  14 happyReduction_36
happyReduction_36 (HappyAbsSyn29  happy_var_3)
	(HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (Theta (snd happy_var_1) (fst happy_var_1) happy_var_2 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  14 happyReduction_37
happyReduction_37 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  15 happyReduction_38
happyReduction_38 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (App happy_var_1 NotErased happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  15 happyReduction_39
happyReduction_39 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (App happy_var_1 Erased    happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  15 happyReduction_40
happyReduction_40 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (AppTp happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  15 happyReduction_41
happyReduction_41 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_2  16 happyReduction_42
happyReduction_42 (HappyAbsSyn23  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "β")))
	 =  HappyAbsSyn24
		 (Beta    (pos2Txt happy_var_1) happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  16 happyReduction_43
happyReduction_43 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEps))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) Both               EpsHnf  happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  16 happyReduction_44
happyReduction_44 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsM))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) Both               EpsHanf happy_var_2
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  16 happyReduction_45
happyReduction_45 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsL))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) CedilleTypes.Left  EpsHnf  happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  16 happyReduction_46
happyReduction_46 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsLM))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) CedilleTypes.Left  EpsHanf happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  16 happyReduction_47
happyReduction_47 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsR))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) CedilleTypes.Right EpsHnf  happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_2  16 happyReduction_48
happyReduction_48 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsRM))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) CedilleTypes.Right EpsHanf happy_var_2
	)
happyReduction_48 _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_2  16 happyReduction_49
happyReduction_49 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "ς")))
	 =  HappyAbsSyn24
		 (Sigma (pos2Txt happy_var_1) happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happyReduce 4 16 happyReduction_50
happyReduction_50 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_2) `HappyStk`
	(HappyAbsSyn22  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Rho (snd happy_var_1) (fst happy_var_1) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_51 = happyReduce 4 16 happyReduction_51
happyReduction_51 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "χ"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Chi (pos2Txt happy_var_1) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_52 = happySpecReduce_1  16 happyReduction_52
happyReduction_52 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  17 happyReduction_53
happyReduction_53 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn24
		 (Var (tPosTxt happy_var_1) (tTxt happy_var_1)
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  17 happyReduction_54
happyReduction_54 (HappyTerminal (Token happy_var_3 (TSym ")")))
	(HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "(")))
	 =  HappyAbsSyn24
		 (Parens (pos2Txt happy_var_1) happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_2  17 happyReduction_55
happyReduction_55 (HappyTerminal happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (IotaProj happy_var_1 (tTxt happy_var_2) (tPosTxt happy_var_2)
	)
happyReduction_55 _ _  = notHappyAtAll 

happyReduce_56 = happyReduce 6 17 happyReduction_56
happyReduction_56 ((HappyTerminal (Token happy_var_6 (TSym "]"))) `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "["))) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (IotaPair (pos2Txt happy_var_1) happy_var_2 happy_var_4 happy_var_5 (pos2Txt happy_var_6)
	) `HappyStk` happyRest

happyReduce_57 = happySpecReduce_1  17 happyReduction_57
happyReduction_57 (HappyTerminal (Token happy_var_1 (TSym "●")))
	 =  HappyAbsSyn24
		 (Hole (pos2Txt happy_var_1)
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  18 happyReduction_58
happyReduction_58 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn28
		 (Atype happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_0  18 happyReduction_59
happyReduction_59  =  HappyAbsSyn28
		 (NoAtype
	)

happyReduce_60 = happySpecReduce_1  19 happyReduction_60
happyReduction_60 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn29
		 (LtermsNil  happy_var_1
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_2  19 happyReduction_61
happyReduction_61 (HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn29
		 (LtermsCons NotErased happy_var_1 happy_var_2
	)
happyReduction_61 _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  19 happyReduction_62
happyReduction_62 (HappyAbsSyn29  happy_var_3)
	(HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (LtermsCons Erased    happy_var_2 happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_0  20 happyReduction_63
happyReduction_63  =  HappyAbsSyn30
		 (NoClass
	)

happyReduce_64 = happySpecReduce_2  20 happyReduction_64
happyReduction_64 (HappyAbsSyn42  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (SomeClass happy_var_2
	)
happyReduction_64 _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_0  21 happyReduction_65
happyReduction_65  =  HappyAbsSyn31
		 (NoType
	)

happyReduce_66 = happySpecReduce_2  21 happyReduction_66
happyReduction_66 (HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn31
		 (SomeType happy_var_2
	)
happyReduction_66 _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  22 happyReduction_67
happyReduction_67 (HappyTerminal (Token happy_var_1 (TSym "Λ")))
	 =  HappyAbsSyn32
		 ((ErasedLambda, pos2Txt happy_var_1)
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  22 happyReduction_68
happyReduction_68 (HappyTerminal (Token happy_var_1 (TSym "λ")))
	 =  HappyAbsSyn32
		 ((KeptLambda  , pos2Txt happy_var_1)
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happyReduce 6 23 happyReduction_69
happyReduction_69 ((HappyAbsSyn33  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "Π"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (Abs (pos2Txt happy_var_1) Pi  (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 6 23 happyReduction_70
happyReduction_70 ((HappyAbsSyn33  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "∀"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (Abs (pos2Txt happy_var_1) All (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 6 23 happyReduction_71
happyReduction_71 ((HappyAbsSyn33  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	(HappyTerminal (Token happy_var_3 (TSym ":"))) `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "λ"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (TpLambda (pos2Txt happy_var_1) (pos2Txt happy_var_3) (tTxt happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_72 = happyReduce 5 23 happyReduction_72
happyReduction_72 ((HappyAbsSyn33  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_3) `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "ι"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (Iota     (pos2Txt happy_var_1) (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_73 = happySpecReduce_3  23 happyReduction_73
happyReduction_73 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (TpArrow happy_var_1 ErasedArrow   happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  23 happyReduction_74
happyReduction_74 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (TpArrow happy_var_1 UnerasedArrow happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  23 happyReduction_75
happyReduction_75 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  23 happyReduction_76
happyReduction_76 (HappyTerminal (Token happy_var_3 TRSpan))
	(HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn33
		 (NoSpans happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happyReduce 5 23 happyReduction_77
happyReduction_77 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (TpEq happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_78 = happyReduce 6 24 happyReduction_78
happyReduction_78 ((HappyAbsSyn40  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "↑"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (Lft (pos2Txt happy_var_1) (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_79 = happySpecReduce_3  24 happyReduction_79
happyReduction_79 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (TpApp happy_var_1 happy_var_3
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_2  24 happyReduction_80
happyReduction_80 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (TpAppt happy_var_1 happy_var_2
	)
happyReduction_80 _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  24 happyReduction_81
happyReduction_81 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  25 happyReduction_82
happyReduction_82 (HappyTerminal (Token happy_var_3 (TSym ")")))
	(HappyAbsSyn33  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "(")))
	 =  HappyAbsSyn33
		 (TpParens (pos2Txt happy_var_1) happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  25 happyReduction_83
happyReduction_83 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn33
		 (TpVar (tPosTxt happy_var_1) (tTxt happy_var_1)
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  25 happyReduction_84
happyReduction_84 (HappyTerminal (Token happy_var_1 (TSym "●")))
	 =  HappyAbsSyn33
		 (TpHole (pos2Txt happy_var_1)
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  26 happyReduction_85
happyReduction_85 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn36
		 (TermArg happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_2  26 happyReduction_86
happyReduction_86 (HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn36
		 (TypeArg happy_var_2
	)
happyReduction_86 _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  27 happyReduction_87
happyReduction_87 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn37
		 (ArgsNil happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_2  27 happyReduction_88
happyReduction_88 (HappyAbsSyn37  happy_var_2)
	(HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn37
		 (ArgsCons happy_var_1 happy_var_2
	)
happyReduction_88 _ _  = notHappyAtAll 

happyReduce_89 = happyReduce 6 28 happyReduction_89
happyReduction_89 ((HappyAbsSyn38  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "Π"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn38
		 (KndPi (pos2Txt happy_var_1) (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_90 = happySpecReduce_3  28 happyReduction_90
happyReduction_90 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (KndArrow   happy_var_1 happy_var_3
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_3  28 happyReduction_91
happyReduction_91 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn38
		 (KndTpArrow happy_var_1 happy_var_3
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  28 happyReduction_92
happyReduction_92 (HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (happy_var_1
	)
happyReduction_92 _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_1  29 happyReduction_93
happyReduction_93 (HappyTerminal (Token happy_var_1 (TSym "★")))
	 =  HappyAbsSyn38
		 (Star (pos2Txt happy_var_1)
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_3  29 happyReduction_94
happyReduction_94 (HappyTerminal (Token happy_var_3 (TSym ")")))
	(HappyAbsSyn38  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "(")))
	 =  HappyAbsSyn38
		 (KndParens  (pos2Txt happy_var_1) happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_94 _ _ _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_2  29 happyReduction_95
happyReduction_95 (HappyAbsSyn37  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn38
		 (KndVar (tPosTxt happy_var_1) (tTxt happy_var_1) happy_var_2
	)
happyReduction_95 _ _  = notHappyAtAll 

happyReduce_96 = happyReduce 6 30 happyReduction_96
happyReduction_96 ((HappyAbsSyn40  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn33  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "Π"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn40
		 (LiftPi (pos2Txt happy_var_1) (tTxt happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_97 = happySpecReduce_3  30 happyReduction_97
happyReduction_97 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (LiftArrow   happy_var_1 happy_var_3
	)
happyReduction_97 _ _ _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_3  30 happyReduction_98
happyReduction_98 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn40
		 (LiftTpArrow happy_var_1 happy_var_3
	)
happyReduction_98 _ _ _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  30 happyReduction_99
happyReduction_99 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  31 happyReduction_100
happyReduction_100 (HappyTerminal (Token happy_var_1 (TSym "☆")))
	 =  HappyAbsSyn40
		 (LiftStar (pos2Txt happy_var_1)
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_3  31 happyReduction_101
happyReduction_101 (HappyTerminal (Token happy_var_3 (TSym ")")))
	(HappyAbsSyn40  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "(")))
	 =  HappyAbsSyn40
		 (LiftParens  (pos2Txt happy_var_1) happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_101 _ _ _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  32 happyReduction_102
happyReduction_102 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn42
		 (Tkt happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  32 happyReduction_103
happyReduction_103 (HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn42
		 (Tkk happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  33 happyReduction_104
happyReduction_104 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_1  33 happyReduction_105
happyReduction_105 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_105 _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  34 happyReduction_106
happyReduction_106 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_106 _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_1  34 happyReduction_107
happyReduction_107 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_107 _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_1  35 happyReduction_108
happyReduction_108 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_108 _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_1  35 happyReduction_109
happyReduction_109 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_109 _  = notHappyAtAll 

happyReduce_110 = happyMonadReduce 0 36 happyReduction_110
happyReduction_110 (happyRest) tk
	 = happyThen (( getPos)
	) (\r -> happyReturn (HappyAbsSyn46 r))

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = happyDoAction i tk action sts stk in
	case tk of {
	Token _ TEOF -> happyDoAction 55 tk action sts stk;
	Token _ (TVar _) -> cont 1;
	Token _ (TQvar _) -> cont 2;
	Token _ (TKvar _) -> cont 3;
	Token _ (TQKvar _) -> cont 4;
	Token _ (TFpth _) -> cont 5;
	Token _ (TProj _) -> cont 6;
	Token happy_dollar_dollar TEps -> cont 7;
	Token happy_dollar_dollar TEpsM -> cont 8;
	Token happy_dollar_dollar TEpsL -> cont 9;
	Token happy_dollar_dollar TEpsLM -> cont 10;
	Token happy_dollar_dollar TEpsR -> cont 11;
	Token happy_dollar_dollar TEpsRM -> cont 12;
	Token happy_dollar_dollar TImport -> cont 13;
	Token happy_dollar_dollar TModule -> cont 14;
	Token happy_dollar_dollar TAs -> cont 15;
	Token happy_dollar_dollar TLet -> cont 16;
	Token happy_dollar_dollar TIn -> cont 17;
	Token happy_dollar_dollar TLSpan -> cont 18;
	Token happy_dollar_dollar TRSpan -> cont 19;
	Token happy_dollar_dollar TTheta -> cont 20;
	Token happy_dollar_dollar TThetaEq -> cont 21;
	Token happy_dollar_dollar TThetaVars -> cont 22;
	Token happy_dollar_dollar TRhoPlain -> cont 23;
	Token happy_dollar_dollar TRhoPlus -> cont 24;
	Token happy_dollar_dollar (TSym "=") -> cont 25;
	Token happy_dollar_dollar (TSym ">") -> cont 26;
	Token _  (TSym "_") -> cont 27;
	Token happy_dollar_dollar (TSym ".") -> cont 28;
	Token happy_dollar_dollar (TSym "(") -> cont 29;
	Token happy_dollar_dollar (TSym ")") -> cont 30;
	Token happy_dollar_dollar (TSym "[") -> cont 31;
	Token happy_dollar_dollar (TSym "]") -> cont 32;
	Token happy_dollar_dollar (TSym ",") -> cont 33;
	Token happy_dollar_dollar (TSym "{") -> cont 34;
	Token happy_dollar_dollar (TSym "}") -> cont 35;
	Token happy_dollar_dollar (TSym ":") -> cont 36;
	Token happy_dollar_dollar (TSym "Π") -> cont 37;
	Token happy_dollar_dollar (TSym "∀") -> cont 38;
	Token happy_dollar_dollar (TSym "λ") -> cont 39;
	Token happy_dollar_dollar (TSym "Λ") -> cont 40;
	Token happy_dollar_dollar (TSym "ι") -> cont 41;
	Token happy_dollar_dollar (TSym "↑") -> cont 42;
	Token happy_dollar_dollar (TSym "β") -> cont 43;
	Token happy_dollar_dollar (TSym "·") -> cont 44;
	Token happy_dollar_dollar (TSym "-") -> cont 45;
	Token happy_dollar_dollar (TSym "ς") -> cont 46;
	Token happy_dollar_dollar (TSym "χ") -> cont 47;
	Token happy_dollar_dollar (TSym "➾") -> cont 48;
	Token happy_dollar_dollar (TSym "➔") -> cont 49;
	Token happy_dollar_dollar (TSym "≃") -> cont 50;
	Token happy_dollar_dollar (TSym "◂") -> cont 51;
	Token happy_dollar_dollar (TSym "●") -> cont 52;
	Token happy_dollar_dollar (TSym "☆") -> cont 53;
	Token happy_dollar_dollar (TSym "★") -> cont 54;
	_ -> happyError' tk
	})

happyError_ 55 tk = happyError' tk
happyError_ _ tk = happyError' tk

happyThen :: () => Alex a -> (a -> Alex b) -> Alex b
happyThen = (>>=)
happyReturn :: () => a -> Alex a
happyReturn = (return)
happyThen1 = happyThen
happyReturn1 :: () => a -> Alex a
happyReturn1 = happyReturn
happyError' :: () => (Token) -> Alex a
happyError' tk = parseError tk

cedilleParser = happySomeParser where
  happySomeParser = happyThen (happyParse 0) (\x -> case x of {HappyAbsSyn10 z -> happyReturn z; _other -> notHappyAtAll })

types = happySomeParser where
  happySomeParser = happyThen (happyParse 1) (\x -> case x of {HappyAbsSyn33 z -> happyReturn z; _other -> notHappyAtAll })

term = happySomeParser where
  happySomeParser = happyThen (happyParse 2) (\x -> case x of {HappyAbsSyn24 z -> happyReturn z; _other -> notHappyAtAll })

maybetype = happySomeParser where
  happySomeParser = happyThen (happyParse 3) (\x -> case x of {HappyAbsSyn16 z -> happyReturn z; _other -> notHappyAtAll })

deftermtype = happySomeParser where
  happySomeParser = happyThen (happyParse 4) (\x -> case x of {HappyAbsSyn18 z -> happyReturn z; _other -> notHappyAtAll })

cmd = happySomeParser where
  happySomeParser = happyThen (happyParse 5) (\x -> case x of {HappyAbsSyn15 z -> happyReturn z; _other -> notHappyAtAll })

liftingtype = happySomeParser where
  happySomeParser = happyThen (happyParse 6) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


alexPos2txt :: AlexPosn -> Text
alexPos2txt (AlexPn p _ _) = pack (show p)
  
getPos :: Alex PosInfo
getPos = Alex $ \ s -> return (s , alexPos2txt(alex_pos s))
  
posInfo :: PosInfo
posInfo = pack "0"
  
lexer :: (Token -> Alex a) -> Alex a
lexer f = alexMonadScan >>= f  
  
parseError :: Token -> Alex a
parseError (Token p t) = alexError $ "Parse error in token:" ++ show t ++ "\n. Position: " ++ show p

parse :: String-> Either String Start
parse s = runAlex s $ cedilleParser 

parseTxt :: Text -> Either Text Start
parseTxt s = case runAlex (unpack s) $ cedilleParser of
               Prelude.Left  s2 -> Prelude.Left (pack s2)
               Prelude.Right r  -> Prelude.Right r

showStart :: Start -> Text
showStart s = pack (show s)

main :: IO ()
main = do  
  s <- getContents
  case parse s of
    Prelude.Left  errMsg -> putStrLn $ "Error:"             ++ errMsg
    Prelude.Right res    -> putStrLn $ "Parser successful, AST:" ++ show res
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 10 "<command-line>" #-}
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 10 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc/include/ghcversion.h" #-}

















{-# LINE 10 "<command-line>" #-}
{-# LINE 1 "/tmp/ghcac8b_0/ghc_2.h" #-}


































































































































































{-# LINE 10 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}


data Happy_IntList = HappyCons Int Happy_IntList





{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}



happyTrace string expr = Happy_System_IO_Unsafe.unsafePerformIO $ do
    Happy_System_IO.hPutStr Happy_System_IO.stderr string
    return expr




infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (0), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (0) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
        = (happyTrace ("state: " ++ show (st) ++                        ",\ttoken: " ++ show (i) ++                       ",\taction: ")) $


          case action of
                (0)           -> (happyTrace ("fail.\n")) $
                                     happyFail i tk st
                (-1)          -> (happyTrace ("accept.\n")) $
                                     happyAccept i tk st
                n | (n < ((0) :: Int)) -> (happyTrace ("reduce (rule " ++ show rule                                                                ++ ")")) $

                                                   (happyReduceArr Happy_Data_Array.! rule) i tk st
                                                   where rule = ((negate ((n + ((1) :: Int)))))
                n                 -> (happyTrace ("shift, enter state "                                                  ++ show (new_state)                                                  ++ "\n")) $


                                     happyShift new_state i tk st
                                     where new_state = (n - ((1) :: Int))
   where off    = indexShortOffAddr happyActOffsets st
         off_i  = (off + i)
         check  = if (off_i >= ((0) :: Int))
                  then (indexShortOffAddr happyCheck off_i ==  i)
                  else False
         action
          | check     = indexShortOffAddr happyTable off_i
          | otherwise = indexShortOffAddr happyDefActions st

{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off








-----------------------------------------------------------------------------
-- HappyState data type (not arrays)

{-# LINE 170 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (0) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (0) tk st sts stk
     = happyFail (0) tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (0) tk st sts stk
     = happyFail (0) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (0) tk st sts stk
     = happyFail (0) tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (0) tk st sts stk
     = happyFail (0) tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (0) tk st sts stk
     = happyFail (0) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@((HappyCons (st1@(action)) (_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn (0) tk st sts stk
     = happyFail (0) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (0) tk st sts stk
     = happyFail (0) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
         let drop_stk = happyDropStk k stk

             off = indexShortOffAddr happyGotoOffsets st1
             off_i = (off + nt)
             new_state = indexShortOffAddr happyTable off_i



          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   (happyTrace (", goto state " ++ show (new_state) ++ "\n")) $
   happyDoAction j tk new_state
   where off = indexShortOffAddr happyGotoOffsets st
         off_i = (off + nt)
         new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery ((0) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (0) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (0) tk old_st (HappyCons ((action)) (sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        happyDoAction (0) tk action sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (action) sts stk =
--      trace "entering error recovery" $
        happyDoAction (0) tk action sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

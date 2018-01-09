{-# OPTIONS_GHC -w #-}
module CedilleParser where

import CedilleTypes
import CedilleLexer hiding (main)
import Data.Text(Text,pack,unpack)
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

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163,
 action_164,
 action_165,
 action_166,
 action_167,
 action_168,
 action_169,
 action_170,
 action_171,
 action_172,
 action_173,
 action_174,
 action_175,
 action_176,
 action_177,
 action_178,
 action_179,
 action_180,
 action_181,
 action_182,
 action_183,
 action_184,
 action_185,
 action_186,
 action_187,
 action_188,
 action_189,
 action_190,
 action_191,
 action_192,
 action_193,
 action_194,
 action_195,
 action_196,
 action_197,
 action_198,
 action_199,
 action_200,
 action_201,
 action_202,
 action_203,
 action_204,
 action_205,
 action_206,
 action_207,
 action_208,
 action_209,
 action_210,
 action_211,
 action_212,
 action_213,
 action_214,
 action_215,
 action_216,
 action_217,
 action_218,
 action_219,
 action_220,
 action_221,
 action_222,
 action_223,
 action_224,
 action_225,
 action_226,
 action_227,
 action_228,
 action_229,
 action_230,
 action_231,
 action_232,
 action_233,
 action_234,
 action_235,
 action_236,
 action_237,
 action_238,
 action_239,
 action_240,
 action_241,
 action_242,
 action_243,
 action_244,
 action_245,
 action_246 :: () => Int -> ({-HappyReduction (Alex) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (Alex) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (Alex) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (Alex) HappyAbsSyn)

happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86,
 happyReduce_87,
 happyReduce_88,
 happyReduce_89,
 happyReduce_90,
 happyReduce_91,
 happyReduce_92,
 happyReduce_93,
 happyReduce_94,
 happyReduce_95,
 happyReduce_96,
 happyReduce_97,
 happyReduce_98,
 happyReduce_99,
 happyReduce_100,
 happyReduce_101,
 happyReduce_102,
 happyReduce_103,
 happyReduce_104,
 happyReduce_105,
 happyReduce_106,
 happyReduce_107,
 happyReduce_108,
 happyReduce_109,
 happyReduce_110 :: () => ({-HappyReduction (Alex) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (Alex) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (Alex) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (Alex) HappyAbsSyn)

action_0 (59) = happyShift action_10
action_0 (10) = happyGoto action_68
action_0 (11) = happyGoto action_8
action_0 (13) = happyGoto action_9
action_0 _ = happyReduce_11

action_1 (47) = happyShift action_17
action_1 (48) = happyShift action_18
action_1 (64) = happyShift action_19
action_1 (75) = happyShift action_66
action_1 (80) = happyShift action_21
action_1 (83) = happyShift action_67
action_1 (84) = happyShift action_23
action_1 (85) = happyShift action_24
action_1 (87) = happyShift action_25
action_1 (88) = happyShift action_26
action_1 (98) = happyShift action_27
action_1 (33) = happyGoto action_65
action_1 (34) = happyGoto action_12
action_1 (35) = happyGoto action_13
action_1 (44) = happyGoto action_16
action_1 _ = happyFail

action_2 (47) = happyShift action_17
action_2 (48) = happyShift action_18
action_2 (53) = happyShift action_45
action_2 (54) = happyShift action_46
action_2 (55) = happyShift action_47
action_2 (56) = happyShift action_48
action_2 (57) = happyShift action_49
action_2 (58) = happyShift action_50
action_2 (62) = happyShift action_51
action_2 (66) = happyShift action_52
action_2 (67) = happyShift action_53
action_2 (68) = happyShift action_54
action_2 (69) = happyShift action_55
action_2 (70) = happyShift action_56
action_2 (75) = happyShift action_57
action_2 (77) = happyShift action_58
action_2 (85) = happyShift action_59
action_2 (86) = happyShift action_60
action_2 (89) = happyShift action_61
action_2 (92) = happyShift action_62
action_2 (93) = happyShift action_63
action_2 (98) = happyShift action_64
action_2 (20) = happyGoto action_37
action_2 (22) = happyGoto action_38
action_2 (24) = happyGoto action_39
action_2 (25) = happyGoto action_40
action_2 (26) = happyGoto action_41
action_2 (27) = happyGoto action_42
action_2 (32) = happyGoto action_43
action_2 (44) = happyGoto action_44
action_2 _ = happyFail

action_3 (97) = happyShift action_36
action_3 (16) = happyGoto action_35
action_3 _ = happyReduce_18

action_4 (47) = happyShift action_32
action_4 (18) = happyGoto action_34
action_4 _ = happyFail

action_5 (47) = happyShift action_32
action_5 (49) = happyShift action_33
action_5 (59) = happyShift action_10
action_5 (11) = happyGoto action_29
action_5 (15) = happyGoto action_30
action_5 (18) = happyGoto action_31
action_5 _ = happyFail

action_6 (47) = happyShift action_17
action_6 (48) = happyShift action_18
action_6 (64) = happyShift action_19
action_6 (75) = happyShift action_20
action_6 (80) = happyShift action_21
action_6 (83) = happyShift action_22
action_6 (84) = happyShift action_23
action_6 (85) = happyShift action_24
action_6 (87) = happyShift action_25
action_6 (88) = happyShift action_26
action_6 (98) = happyShift action_27
action_6 (99) = happyShift action_28
action_6 (33) = happyGoto action_11
action_6 (34) = happyGoto action_12
action_6 (35) = happyGoto action_13
action_6 (40) = happyGoto action_14
action_6 (41) = happyGoto action_15
action_6 (44) = happyGoto action_16
action_6 _ = happyFail

action_7 (59) = happyShift action_10
action_7 (11) = happyGoto action_8
action_7 (13) = happyGoto action_9
action_7 _ = happyFail

action_8 (59) = happyShift action_10
action_8 (11) = happyGoto action_8
action_8 (13) = happyGoto action_122
action_8 _ = happyReduce_11

action_9 (60) = happyShift action_121
action_9 _ = happyFail

action_10 (47) = happyShift action_119
action_10 (51) = happyShift action_120
action_10 (45) = happyGoto action_118
action_10 _ = happyFail

action_11 (95) = happyShift action_117
action_11 _ = happyFail

action_12 (47) = happyShift action_17
action_12 (48) = happyShift action_18
action_12 (53) = happyShift action_45
action_12 (54) = happyShift action_46
action_12 (55) = happyShift action_47
action_12 (56) = happyShift action_48
action_12 (57) = happyShift action_49
action_12 (58) = happyShift action_50
action_12 (69) = happyShift action_55
action_12 (70) = happyShift action_56
action_12 (75) = happyShift action_57
action_12 (77) = happyShift action_58
action_12 (89) = happyShift action_61
action_12 (90) = happyShift action_114
action_12 (92) = happyShift action_62
action_12 (93) = happyShift action_63
action_12 (94) = happyShift action_115
action_12 (95) = happyShift action_116
action_12 (98) = happyShift action_64
action_12 (22) = happyGoto action_38
action_12 (26) = happyGoto action_113
action_12 (27) = happyGoto action_42
action_12 (44) = happyGoto action_44
action_12 _ = happyReduce_75

action_13 _ = happyReduce_81

action_14 (101) = happyAccept
action_14 _ = happyFail

action_15 (95) = happyShift action_112
action_15 _ = happyReduce_99

action_16 _ = happyReduce_83

action_17 _ = happyReduce_106

action_18 _ = happyReduce_107

action_19 (47) = happyShift action_17
action_19 (48) = happyShift action_18
action_19 (64) = happyShift action_19
action_19 (75) = happyShift action_66
action_19 (80) = happyShift action_21
action_19 (83) = happyShift action_67
action_19 (84) = happyShift action_23
action_19 (85) = happyShift action_24
action_19 (87) = happyShift action_25
action_19 (88) = happyShift action_26
action_19 (98) = happyShift action_27
action_19 (33) = happyGoto action_111
action_19 (34) = happyGoto action_12
action_19 (35) = happyGoto action_13
action_19 (44) = happyGoto action_16
action_19 _ = happyFail

action_20 (47) = happyShift action_17
action_20 (48) = happyShift action_18
action_20 (64) = happyShift action_19
action_20 (75) = happyShift action_20
action_20 (80) = happyShift action_21
action_20 (83) = happyShift action_22
action_20 (84) = happyShift action_23
action_20 (85) = happyShift action_24
action_20 (87) = happyShift action_25
action_20 (88) = happyShift action_26
action_20 (98) = happyShift action_27
action_20 (99) = happyShift action_28
action_20 (33) = happyGoto action_109
action_20 (34) = happyGoto action_12
action_20 (35) = happyGoto action_13
action_20 (40) = happyGoto action_110
action_20 (41) = happyGoto action_15
action_20 (44) = happyGoto action_16
action_20 _ = happyFail

action_21 (47) = happyShift action_17
action_21 (48) = happyShift action_18
action_21 (53) = happyShift action_45
action_21 (54) = happyShift action_46
action_21 (55) = happyShift action_47
action_21 (56) = happyShift action_48
action_21 (57) = happyShift action_49
action_21 (58) = happyShift action_50
action_21 (62) = happyShift action_51
action_21 (66) = happyShift action_52
action_21 (67) = happyShift action_53
action_21 (68) = happyShift action_54
action_21 (69) = happyShift action_55
action_21 (70) = happyShift action_56
action_21 (75) = happyShift action_57
action_21 (77) = happyShift action_58
action_21 (85) = happyShift action_59
action_21 (86) = happyShift action_60
action_21 (89) = happyShift action_61
action_21 (92) = happyShift action_62
action_21 (93) = happyShift action_63
action_21 (98) = happyShift action_64
action_21 (20) = happyGoto action_37
action_21 (22) = happyGoto action_38
action_21 (24) = happyGoto action_108
action_21 (25) = happyGoto action_40
action_21 (26) = happyGoto action_41
action_21 (27) = happyGoto action_42
action_21 (32) = happyGoto action_43
action_21 (44) = happyGoto action_44
action_21 _ = happyFail

action_22 (47) = happyShift action_70
action_22 (73) = happyShift action_71
action_22 (43) = happyGoto action_107
action_22 _ = happyFail

action_23 (47) = happyShift action_70
action_23 (73) = happyShift action_71
action_23 (43) = happyGoto action_106
action_23 _ = happyFail

action_24 (47) = happyShift action_70
action_24 (73) = happyShift action_71
action_24 (43) = happyGoto action_105
action_24 _ = happyFail

action_25 (47) = happyShift action_70
action_25 (73) = happyShift action_71
action_25 (43) = happyGoto action_104
action_25 _ = happyFail

action_26 (47) = happyShift action_103
action_26 _ = happyFail

action_27 _ = happyReduce_84

action_28 _ = happyReduce_100

action_29 _ = happyReduce_15

action_30 (101) = happyAccept
action_30 _ = happyFail

action_31 (74) = happyShift action_102
action_31 _ = happyFail

action_32 (97) = happyShift action_101
action_32 (16) = happyGoto action_100
action_32 _ = happyReduce_18

action_33 (75) = happyShift action_99
action_33 (17) = happyGoto action_97
action_33 (19) = happyGoto action_98
action_33 _ = happyReduce_20

action_34 (101) = happyAccept
action_34 _ = happyFail

action_35 (101) = happyAccept
action_35 _ = happyFail

action_36 (47) = happyShift action_17
action_36 (48) = happyShift action_18
action_36 (64) = happyShift action_19
action_36 (75) = happyShift action_66
action_36 (80) = happyShift action_21
action_36 (83) = happyShift action_67
action_36 (84) = happyShift action_23
action_36 (85) = happyShift action_24
action_36 (87) = happyShift action_25
action_36 (88) = happyShift action_26
action_36 (98) = happyShift action_27
action_36 (33) = happyGoto action_96
action_36 (34) = happyGoto action_12
action_36 (35) = happyGoto action_13
action_36 (44) = happyGoto action_16
action_36 _ = happyFail

action_37 (47) = happyShift action_17
action_37 (48) = happyShift action_18
action_37 (53) = happyShift action_45
action_37 (54) = happyShift action_46
action_37 (55) = happyShift action_47
action_37 (56) = happyShift action_48
action_37 (57) = happyShift action_49
action_37 (58) = happyShift action_50
action_37 (69) = happyShift action_55
action_37 (70) = happyShift action_56
action_37 (75) = happyShift action_57
action_37 (77) = happyShift action_58
action_37 (89) = happyShift action_61
action_37 (92) = happyShift action_62
action_37 (93) = happyShift action_63
action_37 (98) = happyShift action_64
action_37 (22) = happyGoto action_38
action_37 (26) = happyGoto action_95
action_37 (27) = happyGoto action_42
action_37 (44) = happyGoto action_44
action_37 _ = happyFail

action_38 (47) = happyShift action_17
action_38 (48) = happyShift action_18
action_38 (53) = happyShift action_45
action_38 (54) = happyShift action_46
action_38 (55) = happyShift action_47
action_38 (56) = happyShift action_48
action_38 (57) = happyShift action_49
action_38 (58) = happyShift action_50
action_38 (69) = happyShift action_55
action_38 (70) = happyShift action_56
action_38 (75) = happyShift action_57
action_38 (77) = happyShift action_58
action_38 (89) = happyShift action_61
action_38 (92) = happyShift action_62
action_38 (93) = happyShift action_63
action_38 (98) = happyShift action_64
action_38 (22) = happyGoto action_38
action_38 (26) = happyGoto action_94
action_38 (27) = happyGoto action_42
action_38 (44) = happyGoto action_44
action_38 _ = happyFail

action_39 (101) = happyAccept
action_39 _ = happyFail

action_40 (47) = happyShift action_17
action_40 (48) = happyShift action_18
action_40 (53) = happyShift action_45
action_40 (54) = happyShift action_46
action_40 (55) = happyShift action_47
action_40 (56) = happyShift action_48
action_40 (57) = happyShift action_49
action_40 (58) = happyShift action_50
action_40 (69) = happyShift action_55
action_40 (70) = happyShift action_56
action_40 (75) = happyShift action_57
action_40 (77) = happyShift action_58
action_40 (89) = happyShift action_61
action_40 (90) = happyShift action_92
action_40 (91) = happyShift action_93
action_40 (92) = happyShift action_62
action_40 (93) = happyShift action_63
action_40 (98) = happyShift action_64
action_40 (22) = happyGoto action_38
action_40 (26) = happyGoto action_91
action_40 (27) = happyGoto action_42
action_40 (44) = happyGoto action_44
action_40 _ = happyReduce_37

action_41 _ = happyReduce_41

action_42 (52) = happyShift action_90
action_42 _ = happyReduce_52

action_43 (47) = happyShift action_70
action_43 (73) = happyShift action_71
action_43 (43) = happyGoto action_89
action_43 _ = happyFail

action_44 _ = happyReduce_53

action_45 (47) = happyShift action_17
action_45 (48) = happyShift action_18
action_45 (53) = happyShift action_45
action_45 (54) = happyShift action_46
action_45 (55) = happyShift action_47
action_45 (56) = happyShift action_48
action_45 (57) = happyShift action_49
action_45 (58) = happyShift action_50
action_45 (69) = happyShift action_55
action_45 (70) = happyShift action_56
action_45 (75) = happyShift action_57
action_45 (77) = happyShift action_58
action_45 (89) = happyShift action_61
action_45 (92) = happyShift action_62
action_45 (93) = happyShift action_63
action_45 (98) = happyShift action_64
action_45 (22) = happyGoto action_38
action_45 (26) = happyGoto action_88
action_45 (27) = happyGoto action_42
action_45 (44) = happyGoto action_44
action_45 _ = happyFail

action_46 (47) = happyShift action_17
action_46 (48) = happyShift action_18
action_46 (53) = happyShift action_45
action_46 (54) = happyShift action_46
action_46 (55) = happyShift action_47
action_46 (56) = happyShift action_48
action_46 (57) = happyShift action_49
action_46 (58) = happyShift action_50
action_46 (69) = happyShift action_55
action_46 (70) = happyShift action_56
action_46 (75) = happyShift action_57
action_46 (77) = happyShift action_58
action_46 (89) = happyShift action_61
action_46 (92) = happyShift action_62
action_46 (93) = happyShift action_63
action_46 (98) = happyShift action_64
action_46 (22) = happyGoto action_38
action_46 (26) = happyGoto action_87
action_46 (27) = happyGoto action_42
action_46 (44) = happyGoto action_44
action_46 _ = happyFail

action_47 (47) = happyShift action_17
action_47 (48) = happyShift action_18
action_47 (53) = happyShift action_45
action_47 (54) = happyShift action_46
action_47 (55) = happyShift action_47
action_47 (56) = happyShift action_48
action_47 (57) = happyShift action_49
action_47 (58) = happyShift action_50
action_47 (69) = happyShift action_55
action_47 (70) = happyShift action_56
action_47 (75) = happyShift action_57
action_47 (77) = happyShift action_58
action_47 (89) = happyShift action_61
action_47 (92) = happyShift action_62
action_47 (93) = happyShift action_63
action_47 (98) = happyShift action_64
action_47 (22) = happyGoto action_38
action_47 (26) = happyGoto action_86
action_47 (27) = happyGoto action_42
action_47 (44) = happyGoto action_44
action_47 _ = happyFail

action_48 (47) = happyShift action_17
action_48 (48) = happyShift action_18
action_48 (53) = happyShift action_45
action_48 (54) = happyShift action_46
action_48 (55) = happyShift action_47
action_48 (56) = happyShift action_48
action_48 (57) = happyShift action_49
action_48 (58) = happyShift action_50
action_48 (69) = happyShift action_55
action_48 (70) = happyShift action_56
action_48 (75) = happyShift action_57
action_48 (77) = happyShift action_58
action_48 (89) = happyShift action_61
action_48 (92) = happyShift action_62
action_48 (93) = happyShift action_63
action_48 (98) = happyShift action_64
action_48 (22) = happyGoto action_38
action_48 (26) = happyGoto action_85
action_48 (27) = happyGoto action_42
action_48 (44) = happyGoto action_44
action_48 _ = happyFail

action_49 (47) = happyShift action_17
action_49 (48) = happyShift action_18
action_49 (53) = happyShift action_45
action_49 (54) = happyShift action_46
action_49 (55) = happyShift action_47
action_49 (56) = happyShift action_48
action_49 (57) = happyShift action_49
action_49 (58) = happyShift action_50
action_49 (69) = happyShift action_55
action_49 (70) = happyShift action_56
action_49 (75) = happyShift action_57
action_49 (77) = happyShift action_58
action_49 (89) = happyShift action_61
action_49 (92) = happyShift action_62
action_49 (93) = happyShift action_63
action_49 (98) = happyShift action_64
action_49 (22) = happyGoto action_38
action_49 (26) = happyGoto action_84
action_49 (27) = happyGoto action_42
action_49 (44) = happyGoto action_44
action_49 _ = happyFail

action_50 (47) = happyShift action_17
action_50 (48) = happyShift action_18
action_50 (53) = happyShift action_45
action_50 (54) = happyShift action_46
action_50 (55) = happyShift action_47
action_50 (56) = happyShift action_48
action_50 (57) = happyShift action_49
action_50 (58) = happyShift action_50
action_50 (69) = happyShift action_55
action_50 (70) = happyShift action_56
action_50 (75) = happyShift action_57
action_50 (77) = happyShift action_58
action_50 (89) = happyShift action_61
action_50 (92) = happyShift action_62
action_50 (93) = happyShift action_63
action_50 (98) = happyShift action_64
action_50 (22) = happyGoto action_38
action_50 (26) = happyGoto action_83
action_50 (27) = happyGoto action_42
action_50 (44) = happyGoto action_44
action_50 _ = happyFail

action_51 (47) = happyShift action_32
action_51 (18) = happyGoto action_82
action_51 _ = happyFail

action_52 _ = happyReduce_25

action_53 _ = happyReduce_26

action_54 (47) = happyShift action_81
action_54 (21) = happyGoto action_80
action_54 _ = happyFail

action_55 _ = happyReduce_30

action_56 _ = happyReduce_31

action_57 (47) = happyShift action_17
action_57 (48) = happyShift action_18
action_57 (53) = happyShift action_45
action_57 (54) = happyShift action_46
action_57 (55) = happyShift action_47
action_57 (56) = happyShift action_48
action_57 (57) = happyShift action_49
action_57 (58) = happyShift action_50
action_57 (62) = happyShift action_51
action_57 (66) = happyShift action_52
action_57 (67) = happyShift action_53
action_57 (68) = happyShift action_54
action_57 (69) = happyShift action_55
action_57 (70) = happyShift action_56
action_57 (75) = happyShift action_57
action_57 (77) = happyShift action_58
action_57 (85) = happyShift action_59
action_57 (86) = happyShift action_60
action_57 (89) = happyShift action_61
action_57 (92) = happyShift action_62
action_57 (93) = happyShift action_63
action_57 (98) = happyShift action_64
action_57 (20) = happyGoto action_37
action_57 (22) = happyGoto action_38
action_57 (24) = happyGoto action_79
action_57 (25) = happyGoto action_40
action_57 (26) = happyGoto action_41
action_57 (27) = happyGoto action_42
action_57 (32) = happyGoto action_43
action_57 (44) = happyGoto action_44
action_57 _ = happyFail

action_58 (47) = happyShift action_17
action_58 (48) = happyShift action_18
action_58 (53) = happyShift action_45
action_58 (54) = happyShift action_46
action_58 (55) = happyShift action_47
action_58 (56) = happyShift action_48
action_58 (57) = happyShift action_49
action_58 (58) = happyShift action_50
action_58 (62) = happyShift action_51
action_58 (66) = happyShift action_52
action_58 (67) = happyShift action_53
action_58 (68) = happyShift action_54
action_58 (69) = happyShift action_55
action_58 (70) = happyShift action_56
action_58 (75) = happyShift action_57
action_58 (77) = happyShift action_58
action_58 (85) = happyShift action_59
action_58 (86) = happyShift action_60
action_58 (89) = happyShift action_61
action_58 (92) = happyShift action_62
action_58 (93) = happyShift action_63
action_58 (98) = happyShift action_64
action_58 (20) = happyGoto action_37
action_58 (22) = happyGoto action_38
action_58 (24) = happyGoto action_78
action_58 (25) = happyGoto action_40
action_58 (26) = happyGoto action_41
action_58 (27) = happyGoto action_42
action_58 (32) = happyGoto action_43
action_58 (44) = happyGoto action_44
action_58 _ = happyFail

action_59 _ = happyReduce_68

action_60 _ = happyReduce_67

action_61 (80) = happyShift action_77
action_61 (23) = happyGoto action_76
action_61 _ = happyReduce_32

action_62 (47) = happyShift action_17
action_62 (48) = happyShift action_18
action_62 (53) = happyShift action_45
action_62 (54) = happyShift action_46
action_62 (55) = happyShift action_47
action_62 (56) = happyShift action_48
action_62 (57) = happyShift action_49
action_62 (58) = happyShift action_50
action_62 (69) = happyShift action_55
action_62 (70) = happyShift action_56
action_62 (75) = happyShift action_57
action_62 (77) = happyShift action_58
action_62 (89) = happyShift action_61
action_62 (92) = happyShift action_62
action_62 (93) = happyShift action_63
action_62 (98) = happyShift action_64
action_62 (22) = happyGoto action_38
action_62 (26) = happyGoto action_75
action_62 (27) = happyGoto action_42
action_62 (44) = happyGoto action_44
action_62 _ = happyFail

action_63 (47) = happyShift action_17
action_63 (48) = happyShift action_18
action_63 (75) = happyShift action_66
action_63 (98) = happyShift action_27
action_63 (28) = happyGoto action_73
action_63 (35) = happyGoto action_74
action_63 (44) = happyGoto action_16
action_63 _ = happyReduce_59

action_64 _ = happyReduce_57

action_65 (101) = happyAccept
action_65 _ = happyFail

action_66 (47) = happyShift action_17
action_66 (48) = happyShift action_18
action_66 (64) = happyShift action_19
action_66 (75) = happyShift action_66
action_66 (80) = happyShift action_21
action_66 (83) = happyShift action_67
action_66 (84) = happyShift action_23
action_66 (85) = happyShift action_24
action_66 (87) = happyShift action_25
action_66 (88) = happyShift action_26
action_66 (98) = happyShift action_27
action_66 (33) = happyGoto action_72
action_66 (34) = happyGoto action_12
action_66 (35) = happyGoto action_13
action_66 (44) = happyGoto action_16
action_66 _ = happyFail

action_67 (47) = happyShift action_70
action_67 (73) = happyShift action_71
action_67 (43) = happyGoto action_69
action_67 _ = happyFail

action_68 (101) = happyAccept
action_68 _ = happyFail

action_69 (82) = happyShift action_168
action_69 _ = happyFail

action_70 _ = happyReduce_105

action_71 _ = happyReduce_104

action_72 (76) = happyShift action_133
action_72 _ = happyFail

action_73 (91) = happyShift action_167
action_73 _ = happyFail

action_74 _ = happyReduce_58

action_75 _ = happyReduce_49

action_76 _ = happyReduce_42

action_77 (47) = happyShift action_17
action_77 (48) = happyShift action_18
action_77 (53) = happyShift action_45
action_77 (54) = happyShift action_46
action_77 (55) = happyShift action_47
action_77 (56) = happyShift action_48
action_77 (57) = happyShift action_49
action_77 (58) = happyShift action_50
action_77 (62) = happyShift action_51
action_77 (66) = happyShift action_52
action_77 (67) = happyShift action_53
action_77 (68) = happyShift action_54
action_77 (69) = happyShift action_55
action_77 (70) = happyShift action_56
action_77 (75) = happyShift action_57
action_77 (77) = happyShift action_58
action_77 (85) = happyShift action_59
action_77 (86) = happyShift action_60
action_77 (89) = happyShift action_61
action_77 (92) = happyShift action_62
action_77 (93) = happyShift action_63
action_77 (98) = happyShift action_64
action_77 (20) = happyGoto action_37
action_77 (22) = happyGoto action_38
action_77 (24) = happyGoto action_166
action_77 (25) = happyGoto action_40
action_77 (26) = happyGoto action_41
action_77 (27) = happyGoto action_42
action_77 (32) = happyGoto action_43
action_77 (44) = happyGoto action_44
action_77 _ = happyFail

action_78 (79) = happyShift action_165
action_78 _ = happyFail

action_79 (76) = happyShift action_164
action_79 _ = happyFail

action_80 (72) = happyShift action_163
action_80 _ = happyFail

action_81 (47) = happyShift action_81
action_81 (21) = happyGoto action_162
action_81 _ = happyReduce_28

action_82 (63) = happyShift action_161
action_82 _ = happyFail

action_83 _ = happyReduce_48

action_84 _ = happyReduce_47

action_85 _ = happyReduce_46

action_86 _ = happyReduce_45

action_87 _ = happyReduce_44

action_88 _ = happyReduce_43

action_89 (82) = happyShift action_160
action_89 (30) = happyGoto action_159
action_89 _ = happyReduce_63

action_90 _ = happyReduce_55

action_91 _ = happyReduce_38

action_92 (47) = happyShift action_17
action_92 (48) = happyShift action_18
action_92 (75) = happyShift action_66
action_92 (98) = happyShift action_27
action_92 (35) = happyGoto action_158
action_92 (44) = happyGoto action_16
action_92 _ = happyFail

action_93 (47) = happyShift action_17
action_93 (48) = happyShift action_18
action_93 (53) = happyShift action_45
action_93 (54) = happyShift action_46
action_93 (55) = happyShift action_47
action_93 (56) = happyShift action_48
action_93 (57) = happyShift action_49
action_93 (58) = happyShift action_50
action_93 (69) = happyShift action_55
action_93 (70) = happyShift action_56
action_93 (75) = happyShift action_57
action_93 (77) = happyShift action_58
action_93 (89) = happyShift action_61
action_93 (92) = happyShift action_62
action_93 (93) = happyShift action_63
action_93 (98) = happyShift action_64
action_93 (22) = happyGoto action_38
action_93 (26) = happyGoto action_157
action_93 (27) = happyGoto action_42
action_93 (44) = happyGoto action_44
action_93 _ = happyFail

action_94 (91) = happyShift action_156
action_94 _ = happyFail

action_95 (47) = happyShift action_17
action_95 (48) = happyShift action_18
action_95 (53) = happyShift action_45
action_95 (54) = happyShift action_46
action_95 (55) = happyShift action_47
action_95 (56) = happyShift action_48
action_95 (57) = happyShift action_49
action_95 (58) = happyShift action_50
action_95 (69) = happyShift action_55
action_95 (70) = happyShift action_56
action_95 (75) = happyShift action_57
action_95 (77) = happyShift action_58
action_95 (89) = happyShift action_61
action_95 (91) = happyShift action_155
action_95 (92) = happyShift action_62
action_95 (93) = happyShift action_63
action_95 (98) = happyShift action_64
action_95 (22) = happyGoto action_38
action_95 (26) = happyGoto action_152
action_95 (27) = happyGoto action_42
action_95 (29) = happyGoto action_153
action_95 (44) = happyGoto action_44
action_95 (46) = happyGoto action_154
action_95 _ = happyReduce_110

action_96 _ = happyReduce_19

action_97 (71) = happyShift action_151
action_97 _ = happyFail

action_98 (75) = happyShift action_99
action_98 (17) = happyGoto action_150
action_98 (19) = happyGoto action_98
action_98 _ = happyReduce_20

action_99 (47) = happyShift action_70
action_99 (73) = happyShift action_71
action_99 (43) = happyGoto action_149
action_99 _ = happyFail

action_100 (71) = happyShift action_148
action_100 _ = happyFail

action_101 (47) = happyShift action_17
action_101 (48) = happyShift action_18
action_101 (50) = happyShift action_144
action_101 (64) = happyShift action_19
action_101 (75) = happyShift action_145
action_101 (80) = happyShift action_21
action_101 (83) = happyShift action_146
action_101 (84) = happyShift action_23
action_101 (85) = happyShift action_24
action_101 (87) = happyShift action_25
action_101 (88) = happyShift action_26
action_101 (98) = happyShift action_27
action_101 (100) = happyShift action_147
action_101 (33) = happyGoto action_96
action_101 (34) = happyGoto action_141
action_101 (35) = happyGoto action_13
action_101 (38) = happyGoto action_142
action_101 (39) = happyGoto action_143
action_101 (44) = happyGoto action_16
action_101 _ = happyFail

action_102 _ = happyReduce_16

action_103 (74) = happyShift action_140
action_103 _ = happyFail

action_104 (82) = happyShift action_139
action_104 (31) = happyGoto action_138
action_104 _ = happyReduce_65

action_105 (82) = happyShift action_137
action_105 _ = happyFail

action_106 (82) = happyShift action_136
action_106 _ = happyFail

action_107 (82) = happyShift action_135
action_107 _ = happyFail

action_108 (96) = happyShift action_134
action_108 _ = happyFail

action_109 (76) = happyShift action_133
action_109 (95) = happyShift action_117
action_109 _ = happyFail

action_110 (76) = happyShift action_132
action_110 _ = happyFail

action_111 (65) = happyShift action_131
action_111 _ = happyFail

action_112 (47) = happyShift action_17
action_112 (48) = happyShift action_18
action_112 (64) = happyShift action_19
action_112 (75) = happyShift action_20
action_112 (80) = happyShift action_21
action_112 (83) = happyShift action_22
action_112 (84) = happyShift action_23
action_112 (85) = happyShift action_24
action_112 (87) = happyShift action_25
action_112 (88) = happyShift action_26
action_112 (98) = happyShift action_27
action_112 (99) = happyShift action_28
action_112 (33) = happyGoto action_11
action_112 (34) = happyGoto action_12
action_112 (35) = happyGoto action_13
action_112 (40) = happyGoto action_130
action_112 (41) = happyGoto action_15
action_112 (44) = happyGoto action_16
action_112 _ = happyFail

action_113 _ = happyReduce_80

action_114 (47) = happyShift action_17
action_114 (48) = happyShift action_18
action_114 (75) = happyShift action_66
action_114 (98) = happyShift action_27
action_114 (35) = happyGoto action_129
action_114 (44) = happyGoto action_16
action_114 _ = happyFail

action_115 (47) = happyShift action_17
action_115 (48) = happyShift action_18
action_115 (64) = happyShift action_19
action_115 (75) = happyShift action_66
action_115 (80) = happyShift action_21
action_115 (83) = happyShift action_67
action_115 (84) = happyShift action_23
action_115 (85) = happyShift action_24
action_115 (87) = happyShift action_25
action_115 (88) = happyShift action_26
action_115 (98) = happyShift action_27
action_115 (33) = happyGoto action_128
action_115 (34) = happyGoto action_12
action_115 (35) = happyGoto action_13
action_115 (44) = happyGoto action_16
action_115 _ = happyFail

action_116 (47) = happyShift action_17
action_116 (48) = happyShift action_18
action_116 (64) = happyShift action_19
action_116 (75) = happyShift action_66
action_116 (80) = happyShift action_21
action_116 (83) = happyShift action_67
action_116 (84) = happyShift action_23
action_116 (85) = happyShift action_24
action_116 (87) = happyShift action_25
action_116 (88) = happyShift action_26
action_116 (98) = happyShift action_27
action_116 (33) = happyGoto action_127
action_116 (34) = happyGoto action_12
action_116 (35) = happyGoto action_13
action_116 (44) = happyGoto action_16
action_116 _ = happyFail

action_117 (47) = happyShift action_17
action_117 (48) = happyShift action_18
action_117 (64) = happyShift action_19
action_117 (75) = happyShift action_20
action_117 (80) = happyShift action_21
action_117 (83) = happyShift action_22
action_117 (84) = happyShift action_23
action_117 (85) = happyShift action_24
action_117 (87) = happyShift action_25
action_117 (88) = happyShift action_26
action_117 (98) = happyShift action_27
action_117 (99) = happyShift action_28
action_117 (33) = happyGoto action_11
action_117 (34) = happyGoto action_12
action_117 (35) = happyGoto action_13
action_117 (40) = happyGoto action_126
action_117 (41) = happyGoto action_15
action_117 (44) = happyGoto action_16
action_117 _ = happyFail

action_118 (61) = happyShift action_125
action_118 (12) = happyGoto action_124
action_118 _ = happyReduce_9

action_119 _ = happyReduce_109

action_120 _ = happyReduce_108

action_121 (47) = happyShift action_17
action_121 (48) = happyShift action_18
action_121 (44) = happyGoto action_123
action_121 _ = happyFail

action_122 _ = happyReduce_12

action_123 (75) = happyShift action_99
action_123 (17) = happyGoto action_205
action_123 (19) = happyGoto action_98
action_123 _ = happyReduce_20

action_124 (47) = happyShift action_17
action_124 (48) = happyShift action_18
action_124 (53) = happyShift action_45
action_124 (54) = happyShift action_46
action_124 (55) = happyShift action_47
action_124 (56) = happyShift action_48
action_124 (57) = happyShift action_49
action_124 (58) = happyShift action_50
action_124 (69) = happyShift action_55
action_124 (70) = happyShift action_56
action_124 (75) = happyShift action_57
action_124 (77) = happyShift action_58
action_124 (89) = happyShift action_61
action_124 (90) = happyShift action_192
action_124 (92) = happyShift action_62
action_124 (93) = happyShift action_63
action_124 (98) = happyShift action_64
action_124 (22) = happyGoto action_38
action_124 (26) = happyGoto action_188
action_124 (27) = happyGoto action_42
action_124 (36) = happyGoto action_189
action_124 (37) = happyGoto action_204
action_124 (44) = happyGoto action_44
action_124 (46) = happyGoto action_191
action_124 _ = happyReduce_110

action_125 (47) = happyShift action_203
action_125 _ = happyFail

action_126 _ = happyReduce_98

action_127 _ = happyReduce_74

action_128 _ = happyReduce_73

action_129 _ = happyReduce_79

action_130 _ = happyReduce_97

action_131 _ = happyReduce_76

action_132 _ = happyReduce_101

action_133 _ = happyReduce_82

action_134 (47) = happyShift action_17
action_134 (48) = happyShift action_18
action_134 (53) = happyShift action_45
action_134 (54) = happyShift action_46
action_134 (55) = happyShift action_47
action_134 (56) = happyShift action_48
action_134 (57) = happyShift action_49
action_134 (58) = happyShift action_50
action_134 (62) = happyShift action_51
action_134 (66) = happyShift action_52
action_134 (67) = happyShift action_53
action_134 (68) = happyShift action_54
action_134 (69) = happyShift action_55
action_134 (70) = happyShift action_56
action_134 (75) = happyShift action_57
action_134 (77) = happyShift action_58
action_134 (85) = happyShift action_59
action_134 (86) = happyShift action_60
action_134 (89) = happyShift action_61
action_134 (92) = happyShift action_62
action_134 (93) = happyShift action_63
action_134 (98) = happyShift action_64
action_134 (20) = happyGoto action_37
action_134 (22) = happyGoto action_38
action_134 (24) = happyGoto action_202
action_134 (25) = happyGoto action_40
action_134 (26) = happyGoto action_41
action_134 (27) = happyGoto action_42
action_134 (32) = happyGoto action_43
action_134 (44) = happyGoto action_44
action_134 _ = happyFail

action_135 (47) = happyShift action_17
action_135 (48) = happyShift action_18
action_135 (50) = happyShift action_144
action_135 (64) = happyShift action_19
action_135 (75) = happyShift action_145
action_135 (80) = happyShift action_21
action_135 (83) = happyShift action_146
action_135 (84) = happyShift action_23
action_135 (85) = happyShift action_24
action_135 (87) = happyShift action_25
action_135 (88) = happyShift action_26
action_135 (98) = happyShift action_27
action_135 (100) = happyShift action_147
action_135 (33) = happyGoto action_201
action_135 (34) = happyGoto action_141
action_135 (35) = happyGoto action_13
action_135 (38) = happyGoto action_170
action_135 (39) = happyGoto action_143
action_135 (42) = happyGoto action_171
action_135 (44) = happyGoto action_16
action_135 _ = happyFail

action_136 (47) = happyShift action_17
action_136 (48) = happyShift action_18
action_136 (50) = happyShift action_144
action_136 (64) = happyShift action_19
action_136 (75) = happyShift action_145
action_136 (80) = happyShift action_21
action_136 (83) = happyShift action_146
action_136 (84) = happyShift action_23
action_136 (85) = happyShift action_24
action_136 (87) = happyShift action_25
action_136 (88) = happyShift action_26
action_136 (98) = happyShift action_27
action_136 (100) = happyShift action_147
action_136 (33) = happyGoto action_169
action_136 (34) = happyGoto action_141
action_136 (35) = happyGoto action_13
action_136 (38) = happyGoto action_170
action_136 (39) = happyGoto action_143
action_136 (42) = happyGoto action_200
action_136 (44) = happyGoto action_16
action_136 _ = happyFail

action_137 (47) = happyShift action_17
action_137 (48) = happyShift action_18
action_137 (50) = happyShift action_144
action_137 (64) = happyShift action_19
action_137 (75) = happyShift action_145
action_137 (80) = happyShift action_21
action_137 (83) = happyShift action_146
action_137 (84) = happyShift action_23
action_137 (85) = happyShift action_24
action_137 (87) = happyShift action_25
action_137 (88) = happyShift action_26
action_137 (98) = happyShift action_27
action_137 (100) = happyShift action_147
action_137 (33) = happyGoto action_169
action_137 (34) = happyGoto action_141
action_137 (35) = happyGoto action_13
action_137 (38) = happyGoto action_170
action_137 (39) = happyGoto action_143
action_137 (42) = happyGoto action_199
action_137 (44) = happyGoto action_16
action_137 _ = happyFail

action_138 (74) = happyShift action_198
action_138 _ = happyFail

action_139 (47) = happyShift action_17
action_139 (48) = happyShift action_18
action_139 (64) = happyShift action_19
action_139 (75) = happyShift action_66
action_139 (80) = happyShift action_21
action_139 (83) = happyShift action_67
action_139 (84) = happyShift action_23
action_139 (85) = happyShift action_24
action_139 (87) = happyShift action_25
action_139 (88) = happyShift action_26
action_139 (98) = happyShift action_27
action_139 (33) = happyGoto action_197
action_139 (34) = happyGoto action_12
action_139 (35) = happyGoto action_13
action_139 (44) = happyGoto action_16
action_139 _ = happyFail

action_140 (47) = happyShift action_17
action_140 (48) = happyShift action_18
action_140 (53) = happyShift action_45
action_140 (54) = happyShift action_46
action_140 (55) = happyShift action_47
action_140 (56) = happyShift action_48
action_140 (57) = happyShift action_49
action_140 (58) = happyShift action_50
action_140 (62) = happyShift action_51
action_140 (66) = happyShift action_52
action_140 (67) = happyShift action_53
action_140 (68) = happyShift action_54
action_140 (69) = happyShift action_55
action_140 (70) = happyShift action_56
action_140 (75) = happyShift action_57
action_140 (77) = happyShift action_58
action_140 (85) = happyShift action_59
action_140 (86) = happyShift action_60
action_140 (89) = happyShift action_61
action_140 (92) = happyShift action_62
action_140 (93) = happyShift action_63
action_140 (98) = happyShift action_64
action_140 (20) = happyGoto action_37
action_140 (22) = happyGoto action_38
action_140 (24) = happyGoto action_196
action_140 (25) = happyGoto action_40
action_140 (26) = happyGoto action_41
action_140 (27) = happyGoto action_42
action_140 (32) = happyGoto action_43
action_140 (44) = happyGoto action_44
action_140 _ = happyFail

action_141 (47) = happyShift action_17
action_141 (48) = happyShift action_18
action_141 (53) = happyShift action_45
action_141 (54) = happyShift action_46
action_141 (55) = happyShift action_47
action_141 (56) = happyShift action_48
action_141 (57) = happyShift action_49
action_141 (58) = happyShift action_50
action_141 (69) = happyShift action_55
action_141 (70) = happyShift action_56
action_141 (75) = happyShift action_57
action_141 (77) = happyShift action_58
action_141 (89) = happyShift action_61
action_141 (90) = happyShift action_114
action_141 (92) = happyShift action_62
action_141 (93) = happyShift action_63
action_141 (94) = happyShift action_115
action_141 (95) = happyShift action_195
action_141 (98) = happyShift action_64
action_141 (22) = happyGoto action_38
action_141 (26) = happyGoto action_113
action_141 (27) = happyGoto action_42
action_141 (44) = happyGoto action_44
action_141 _ = happyReduce_75

action_142 (71) = happyShift action_194
action_142 _ = happyFail

action_143 (95) = happyShift action_193
action_143 _ = happyReduce_92

action_144 (47) = happyShift action_17
action_144 (48) = happyShift action_18
action_144 (53) = happyShift action_45
action_144 (54) = happyShift action_46
action_144 (55) = happyShift action_47
action_144 (56) = happyShift action_48
action_144 (57) = happyShift action_49
action_144 (58) = happyShift action_50
action_144 (69) = happyShift action_55
action_144 (70) = happyShift action_56
action_144 (75) = happyShift action_57
action_144 (77) = happyShift action_58
action_144 (89) = happyShift action_61
action_144 (90) = happyShift action_192
action_144 (92) = happyShift action_62
action_144 (93) = happyShift action_63
action_144 (98) = happyShift action_64
action_144 (22) = happyGoto action_38
action_144 (26) = happyGoto action_188
action_144 (27) = happyGoto action_42
action_144 (36) = happyGoto action_189
action_144 (37) = happyGoto action_190
action_144 (44) = happyGoto action_44
action_144 (46) = happyGoto action_191
action_144 _ = happyReduce_110

action_145 (47) = happyShift action_17
action_145 (48) = happyShift action_18
action_145 (50) = happyShift action_144
action_145 (64) = happyShift action_19
action_145 (75) = happyShift action_145
action_145 (80) = happyShift action_21
action_145 (83) = happyShift action_146
action_145 (84) = happyShift action_23
action_145 (85) = happyShift action_24
action_145 (87) = happyShift action_25
action_145 (88) = happyShift action_26
action_145 (98) = happyShift action_27
action_145 (100) = happyShift action_147
action_145 (33) = happyGoto action_72
action_145 (34) = happyGoto action_141
action_145 (35) = happyGoto action_13
action_145 (38) = happyGoto action_187
action_145 (39) = happyGoto action_143
action_145 (44) = happyGoto action_16
action_145 _ = happyFail

action_146 (47) = happyShift action_70
action_146 (73) = happyShift action_71
action_146 (43) = happyGoto action_186
action_146 _ = happyFail

action_147 _ = happyReduce_93

action_148 (47) = happyShift action_17
action_148 (48) = happyShift action_18
action_148 (53) = happyShift action_45
action_148 (54) = happyShift action_46
action_148 (55) = happyShift action_47
action_148 (56) = happyShift action_48
action_148 (57) = happyShift action_49
action_148 (58) = happyShift action_50
action_148 (62) = happyShift action_51
action_148 (66) = happyShift action_52
action_148 (67) = happyShift action_53
action_148 (68) = happyShift action_54
action_148 (69) = happyShift action_55
action_148 (70) = happyShift action_56
action_148 (75) = happyShift action_57
action_148 (77) = happyShift action_58
action_148 (85) = happyShift action_59
action_148 (86) = happyShift action_60
action_148 (89) = happyShift action_61
action_148 (92) = happyShift action_62
action_148 (93) = happyShift action_63
action_148 (98) = happyShift action_64
action_148 (20) = happyGoto action_37
action_148 (22) = happyGoto action_38
action_148 (24) = happyGoto action_185
action_148 (25) = happyGoto action_40
action_148 (26) = happyGoto action_41
action_148 (27) = happyGoto action_42
action_148 (32) = happyGoto action_43
action_148 (44) = happyGoto action_44
action_148 _ = happyFail

action_149 (82) = happyShift action_184
action_149 _ = happyFail

action_150 _ = happyReduce_21

action_151 (47) = happyShift action_17
action_151 (48) = happyShift action_18
action_151 (50) = happyShift action_144
action_151 (75) = happyShift action_145
action_151 (83) = happyShift action_183
action_151 (88) = happyShift action_26
action_151 (98) = happyShift action_27
action_151 (100) = happyShift action_147
action_151 (34) = happyGoto action_181
action_151 (35) = happyGoto action_13
action_151 (38) = happyGoto action_182
action_151 (39) = happyGoto action_143
action_151 (44) = happyGoto action_16
action_151 _ = happyFail

action_152 (47) = happyShift action_17
action_152 (48) = happyShift action_18
action_152 (53) = happyShift action_45
action_152 (54) = happyShift action_46
action_152 (55) = happyShift action_47
action_152 (56) = happyShift action_48
action_152 (57) = happyShift action_49
action_152 (58) = happyShift action_50
action_152 (69) = happyShift action_55
action_152 (70) = happyShift action_56
action_152 (75) = happyShift action_57
action_152 (77) = happyShift action_58
action_152 (89) = happyShift action_61
action_152 (91) = happyShift action_155
action_152 (92) = happyShift action_62
action_152 (93) = happyShift action_63
action_152 (98) = happyShift action_64
action_152 (22) = happyGoto action_38
action_152 (26) = happyGoto action_152
action_152 (27) = happyGoto action_42
action_152 (29) = happyGoto action_180
action_152 (44) = happyGoto action_44
action_152 (46) = happyGoto action_154
action_152 _ = happyReduce_110

action_153 _ = happyReduce_36

action_154 _ = happyReduce_60

action_155 (47) = happyShift action_17
action_155 (48) = happyShift action_18
action_155 (53) = happyShift action_45
action_155 (54) = happyShift action_46
action_155 (55) = happyShift action_47
action_155 (56) = happyShift action_48
action_155 (57) = happyShift action_49
action_155 (58) = happyShift action_50
action_155 (69) = happyShift action_55
action_155 (70) = happyShift action_56
action_155 (75) = happyShift action_57
action_155 (77) = happyShift action_58
action_155 (89) = happyShift action_61
action_155 (92) = happyShift action_62
action_155 (93) = happyShift action_63
action_155 (98) = happyShift action_64
action_155 (22) = happyGoto action_38
action_155 (26) = happyGoto action_179
action_155 (27) = happyGoto action_42
action_155 (44) = happyGoto action_44
action_155 _ = happyFail

action_156 (47) = happyShift action_17
action_156 (48) = happyShift action_18
action_156 (53) = happyShift action_45
action_156 (54) = happyShift action_46
action_156 (55) = happyShift action_47
action_156 (56) = happyShift action_48
action_156 (57) = happyShift action_49
action_156 (58) = happyShift action_50
action_156 (69) = happyShift action_55
action_156 (70) = happyShift action_56
action_156 (75) = happyShift action_57
action_156 (77) = happyShift action_58
action_156 (89) = happyShift action_61
action_156 (92) = happyShift action_62
action_156 (93) = happyShift action_63
action_156 (98) = happyShift action_64
action_156 (22) = happyGoto action_38
action_156 (26) = happyGoto action_178
action_156 (27) = happyGoto action_42
action_156 (44) = happyGoto action_44
action_156 _ = happyFail

action_157 _ = happyReduce_39

action_158 _ = happyReduce_40

action_159 (74) = happyShift action_177
action_159 _ = happyFail

action_160 (47) = happyShift action_17
action_160 (48) = happyShift action_18
action_160 (50) = happyShift action_144
action_160 (64) = happyShift action_19
action_160 (75) = happyShift action_145
action_160 (80) = happyShift action_21
action_160 (83) = happyShift action_146
action_160 (84) = happyShift action_23
action_160 (85) = happyShift action_24
action_160 (87) = happyShift action_25
action_160 (88) = happyShift action_26
action_160 (98) = happyShift action_27
action_160 (100) = happyShift action_147
action_160 (33) = happyGoto action_169
action_160 (34) = happyGoto action_141
action_160 (35) = happyGoto action_13
action_160 (38) = happyGoto action_170
action_160 (39) = happyGoto action_143
action_160 (42) = happyGoto action_176
action_160 (44) = happyGoto action_16
action_160 _ = happyFail

action_161 (47) = happyShift action_17
action_161 (48) = happyShift action_18
action_161 (53) = happyShift action_45
action_161 (54) = happyShift action_46
action_161 (55) = happyShift action_47
action_161 (56) = happyShift action_48
action_161 (57) = happyShift action_49
action_161 (58) = happyShift action_50
action_161 (62) = happyShift action_51
action_161 (66) = happyShift action_52
action_161 (67) = happyShift action_53
action_161 (68) = happyShift action_54
action_161 (69) = happyShift action_55
action_161 (70) = happyShift action_56
action_161 (75) = happyShift action_57
action_161 (77) = happyShift action_58
action_161 (85) = happyShift action_59
action_161 (86) = happyShift action_60
action_161 (89) = happyShift action_61
action_161 (92) = happyShift action_62
action_161 (93) = happyShift action_63
action_161 (98) = happyShift action_64
action_161 (20) = happyGoto action_37
action_161 (22) = happyGoto action_38
action_161 (24) = happyGoto action_175
action_161 (25) = happyGoto action_40
action_161 (26) = happyGoto action_41
action_161 (27) = happyGoto action_42
action_161 (32) = happyGoto action_43
action_161 (44) = happyGoto action_44
action_161 _ = happyFail

action_162 _ = happyReduce_29

action_163 _ = happyReduce_27

action_164 _ = happyReduce_54

action_165 (47) = happyShift action_17
action_165 (48) = happyShift action_18
action_165 (53) = happyShift action_45
action_165 (54) = happyShift action_46
action_165 (55) = happyShift action_47
action_165 (56) = happyShift action_48
action_165 (57) = happyShift action_49
action_165 (58) = happyShift action_50
action_165 (62) = happyShift action_51
action_165 (66) = happyShift action_52
action_165 (67) = happyShift action_53
action_165 (68) = happyShift action_54
action_165 (69) = happyShift action_55
action_165 (70) = happyShift action_56
action_165 (75) = happyShift action_57
action_165 (77) = happyShift action_58
action_165 (85) = happyShift action_59
action_165 (86) = happyShift action_60
action_165 (89) = happyShift action_61
action_165 (92) = happyShift action_62
action_165 (93) = happyShift action_63
action_165 (98) = happyShift action_64
action_165 (20) = happyGoto action_37
action_165 (22) = happyGoto action_38
action_165 (24) = happyGoto action_174
action_165 (25) = happyGoto action_40
action_165 (26) = happyGoto action_41
action_165 (27) = happyGoto action_42
action_165 (32) = happyGoto action_43
action_165 (44) = happyGoto action_44
action_165 _ = happyFail

action_166 (81) = happyShift action_173
action_166 _ = happyFail

action_167 (47) = happyShift action_17
action_167 (48) = happyShift action_18
action_167 (53) = happyShift action_45
action_167 (54) = happyShift action_46
action_167 (55) = happyShift action_47
action_167 (56) = happyShift action_48
action_167 (57) = happyShift action_49
action_167 (58) = happyShift action_50
action_167 (69) = happyShift action_55
action_167 (70) = happyShift action_56
action_167 (75) = happyShift action_57
action_167 (77) = happyShift action_58
action_167 (89) = happyShift action_61
action_167 (92) = happyShift action_62
action_167 (93) = happyShift action_63
action_167 (98) = happyShift action_64
action_167 (22) = happyGoto action_38
action_167 (26) = happyGoto action_172
action_167 (27) = happyGoto action_42
action_167 (44) = happyGoto action_44
action_167 _ = happyFail

action_168 (47) = happyShift action_17
action_168 (48) = happyShift action_18
action_168 (50) = happyShift action_144
action_168 (64) = happyShift action_19
action_168 (75) = happyShift action_145
action_168 (80) = happyShift action_21
action_168 (83) = happyShift action_146
action_168 (84) = happyShift action_23
action_168 (85) = happyShift action_24
action_168 (87) = happyShift action_25
action_168 (88) = happyShift action_26
action_168 (98) = happyShift action_27
action_168 (100) = happyShift action_147
action_168 (33) = happyGoto action_169
action_168 (34) = happyGoto action_141
action_168 (35) = happyGoto action_13
action_168 (38) = happyGoto action_170
action_168 (39) = happyGoto action_143
action_168 (42) = happyGoto action_171
action_168 (44) = happyGoto action_16
action_168 _ = happyFail

action_169 _ = happyReduce_102

action_170 _ = happyReduce_103

action_171 (74) = happyShift action_228
action_171 _ = happyFail

action_172 _ = happyReduce_51

action_173 _ = happyReduce_33

action_174 (80) = happyShift action_77
action_174 (23) = happyGoto action_227
action_174 _ = happyReduce_32

action_175 _ = happyReduce_35

action_176 _ = happyReduce_64

action_177 (47) = happyShift action_17
action_177 (48) = happyShift action_18
action_177 (53) = happyShift action_45
action_177 (54) = happyShift action_46
action_177 (55) = happyShift action_47
action_177 (56) = happyShift action_48
action_177 (57) = happyShift action_49
action_177 (58) = happyShift action_50
action_177 (62) = happyShift action_51
action_177 (66) = happyShift action_52
action_177 (67) = happyShift action_53
action_177 (68) = happyShift action_54
action_177 (69) = happyShift action_55
action_177 (70) = happyShift action_56
action_177 (75) = happyShift action_57
action_177 (77) = happyShift action_58
action_177 (85) = happyShift action_59
action_177 (86) = happyShift action_60
action_177 (89) = happyShift action_61
action_177 (92) = happyShift action_62
action_177 (93) = happyShift action_63
action_177 (98) = happyShift action_64
action_177 (20) = happyGoto action_37
action_177 (22) = happyGoto action_38
action_177 (24) = happyGoto action_226
action_177 (25) = happyGoto action_40
action_177 (26) = happyGoto action_41
action_177 (27) = happyGoto action_42
action_177 (32) = happyGoto action_43
action_177 (44) = happyGoto action_44
action_177 _ = happyFail

action_178 _ = happyReduce_50

action_179 (47) = happyShift action_17
action_179 (48) = happyShift action_18
action_179 (53) = happyShift action_45
action_179 (54) = happyShift action_46
action_179 (55) = happyShift action_47
action_179 (56) = happyShift action_48
action_179 (57) = happyShift action_49
action_179 (58) = happyShift action_50
action_179 (69) = happyShift action_55
action_179 (70) = happyShift action_56
action_179 (75) = happyShift action_57
action_179 (77) = happyShift action_58
action_179 (89) = happyShift action_61
action_179 (91) = happyShift action_155
action_179 (92) = happyShift action_62
action_179 (93) = happyShift action_63
action_179 (98) = happyShift action_64
action_179 (22) = happyGoto action_38
action_179 (26) = happyGoto action_152
action_179 (27) = happyGoto action_42
action_179 (29) = happyGoto action_225
action_179 (44) = happyGoto action_44
action_179 (46) = happyGoto action_154
action_179 _ = happyReduce_110

action_180 _ = happyReduce_61

action_181 (47) = happyShift action_17
action_181 (48) = happyShift action_18
action_181 (53) = happyShift action_45
action_181 (54) = happyShift action_46
action_181 (55) = happyShift action_47
action_181 (56) = happyShift action_48
action_181 (57) = happyShift action_49
action_181 (58) = happyShift action_50
action_181 (69) = happyShift action_55
action_181 (70) = happyShift action_56
action_181 (75) = happyShift action_57
action_181 (77) = happyShift action_58
action_181 (89) = happyShift action_61
action_181 (90) = happyShift action_114
action_181 (92) = happyShift action_62
action_181 (93) = happyShift action_63
action_181 (95) = happyShift action_224
action_181 (98) = happyShift action_64
action_181 (22) = happyGoto action_38
action_181 (26) = happyGoto action_113
action_181 (27) = happyGoto action_42
action_181 (44) = happyGoto action_44
action_181 _ = happyFail

action_182 (74) = happyShift action_223
action_182 _ = happyFail

action_183 (47) = happyShift action_70
action_183 (73) = happyShift action_71
action_183 (43) = happyGoto action_222
action_183 _ = happyFail

action_184 (47) = happyShift action_17
action_184 (48) = happyShift action_18
action_184 (50) = happyShift action_144
action_184 (64) = happyShift action_19
action_184 (75) = happyShift action_145
action_184 (80) = happyShift action_21
action_184 (83) = happyShift action_146
action_184 (84) = happyShift action_23
action_184 (85) = happyShift action_24
action_184 (87) = happyShift action_25
action_184 (88) = happyShift action_26
action_184 (98) = happyShift action_27
action_184 (100) = happyShift action_147
action_184 (33) = happyGoto action_169
action_184 (34) = happyGoto action_141
action_184 (35) = happyGoto action_13
action_184 (38) = happyGoto action_170
action_184 (39) = happyGoto action_143
action_184 (42) = happyGoto action_221
action_184 (44) = happyGoto action_16
action_184 _ = happyFail

action_185 _ = happyReduce_22

action_186 (82) = happyShift action_220
action_186 _ = happyFail

action_187 (76) = happyShift action_219
action_187 _ = happyFail

action_188 _ = happyReduce_85

action_189 (47) = happyShift action_17
action_189 (48) = happyShift action_18
action_189 (53) = happyShift action_45
action_189 (54) = happyShift action_46
action_189 (55) = happyShift action_47
action_189 (56) = happyShift action_48
action_189 (57) = happyShift action_49
action_189 (58) = happyShift action_50
action_189 (69) = happyShift action_55
action_189 (70) = happyShift action_56
action_189 (75) = happyShift action_57
action_189 (77) = happyShift action_58
action_189 (89) = happyShift action_61
action_189 (90) = happyShift action_192
action_189 (92) = happyShift action_62
action_189 (93) = happyShift action_63
action_189 (98) = happyShift action_64
action_189 (22) = happyGoto action_38
action_189 (26) = happyGoto action_188
action_189 (27) = happyGoto action_42
action_189 (36) = happyGoto action_189
action_189 (37) = happyGoto action_218
action_189 (44) = happyGoto action_44
action_189 (46) = happyGoto action_191
action_189 _ = happyReduce_110

action_190 _ = happyReduce_95

action_191 _ = happyReduce_87

action_192 (47) = happyShift action_17
action_192 (48) = happyShift action_18
action_192 (75) = happyShift action_66
action_192 (98) = happyShift action_27
action_192 (35) = happyGoto action_217
action_192 (44) = happyGoto action_16
action_192 _ = happyFail

action_193 (47) = happyShift action_17
action_193 (48) = happyShift action_18
action_193 (50) = happyShift action_144
action_193 (75) = happyShift action_145
action_193 (83) = happyShift action_183
action_193 (88) = happyShift action_26
action_193 (98) = happyShift action_27
action_193 (100) = happyShift action_147
action_193 (34) = happyGoto action_181
action_193 (35) = happyGoto action_13
action_193 (38) = happyGoto action_216
action_193 (39) = happyGoto action_143
action_193 (44) = happyGoto action_16
action_193 _ = happyFail

action_194 (47) = happyShift action_17
action_194 (48) = happyShift action_18
action_194 (64) = happyShift action_19
action_194 (75) = happyShift action_66
action_194 (80) = happyShift action_21
action_194 (83) = happyShift action_67
action_194 (84) = happyShift action_23
action_194 (85) = happyShift action_24
action_194 (87) = happyShift action_25
action_194 (88) = happyShift action_26
action_194 (98) = happyShift action_27
action_194 (33) = happyGoto action_215
action_194 (34) = happyGoto action_12
action_194 (35) = happyGoto action_13
action_194 (44) = happyGoto action_16
action_194 _ = happyFail

action_195 (47) = happyShift action_17
action_195 (48) = happyShift action_18
action_195 (50) = happyShift action_144
action_195 (64) = happyShift action_19
action_195 (75) = happyShift action_145
action_195 (80) = happyShift action_21
action_195 (83) = happyShift action_146
action_195 (84) = happyShift action_23
action_195 (85) = happyShift action_24
action_195 (87) = happyShift action_25
action_195 (88) = happyShift action_26
action_195 (98) = happyShift action_27
action_195 (100) = happyShift action_147
action_195 (33) = happyGoto action_127
action_195 (34) = happyGoto action_141
action_195 (35) = happyGoto action_13
action_195 (38) = happyGoto action_214
action_195 (39) = happyGoto action_143
action_195 (44) = happyGoto action_16
action_195 _ = happyFail

action_196 (82) = happyShift action_213
action_196 _ = happyFail

action_197 _ = happyReduce_66

action_198 (47) = happyShift action_17
action_198 (48) = happyShift action_18
action_198 (64) = happyShift action_19
action_198 (75) = happyShift action_66
action_198 (80) = happyShift action_21
action_198 (83) = happyShift action_67
action_198 (84) = happyShift action_23
action_198 (85) = happyShift action_24
action_198 (87) = happyShift action_25
action_198 (88) = happyShift action_26
action_198 (98) = happyShift action_27
action_198 (33) = happyGoto action_212
action_198 (34) = happyGoto action_12
action_198 (35) = happyGoto action_13
action_198 (44) = happyGoto action_16
action_198 _ = happyFail

action_199 (74) = happyShift action_211
action_199 _ = happyFail

action_200 (74) = happyShift action_210
action_200 _ = happyFail

action_201 (74) = happyShift action_209
action_201 _ = happyFail

action_202 (81) = happyShift action_208
action_202 _ = happyFail

action_203 _ = happyReduce_10

action_204 (74) = happyShift action_207
action_204 _ = happyFail

action_205 (74) = happyShift action_206
action_205 _ = happyFail

action_206 (47) = happyShift action_32
action_206 (49) = happyShift action_33
action_206 (59) = happyShift action_10
action_206 (11) = happyGoto action_29
action_206 (14) = happyGoto action_239
action_206 (15) = happyGoto action_240
action_206 (18) = happyGoto action_31
action_206 _ = happyReduce_13

action_207 _ = happyReduce_8

action_208 _ = happyReduce_77

action_209 (47) = happyShift action_17
action_209 (48) = happyShift action_18
action_209 (64) = happyShift action_19
action_209 (75) = happyShift action_20
action_209 (80) = happyShift action_21
action_209 (83) = happyShift action_22
action_209 (84) = happyShift action_23
action_209 (85) = happyShift action_24
action_209 (87) = happyShift action_25
action_209 (88) = happyShift action_26
action_209 (98) = happyShift action_27
action_209 (99) = happyShift action_28
action_209 (33) = happyGoto action_11
action_209 (34) = happyGoto action_12
action_209 (35) = happyGoto action_13
action_209 (40) = happyGoto action_238
action_209 (41) = happyGoto action_15
action_209 (44) = happyGoto action_16
action_209 _ = happyFail

action_210 (47) = happyShift action_17
action_210 (48) = happyShift action_18
action_210 (64) = happyShift action_19
action_210 (75) = happyShift action_66
action_210 (80) = happyShift action_21
action_210 (83) = happyShift action_67
action_210 (84) = happyShift action_23
action_210 (85) = happyShift action_24
action_210 (87) = happyShift action_25
action_210 (88) = happyShift action_26
action_210 (98) = happyShift action_27
action_210 (33) = happyGoto action_237
action_210 (34) = happyGoto action_12
action_210 (35) = happyGoto action_13
action_210 (44) = happyGoto action_16
action_210 _ = happyFail

action_211 (47) = happyShift action_17
action_211 (48) = happyShift action_18
action_211 (64) = happyShift action_19
action_211 (75) = happyShift action_66
action_211 (80) = happyShift action_21
action_211 (83) = happyShift action_67
action_211 (84) = happyShift action_23
action_211 (85) = happyShift action_24
action_211 (87) = happyShift action_25
action_211 (88) = happyShift action_26
action_211 (98) = happyShift action_27
action_211 (33) = happyGoto action_236
action_211 (34) = happyGoto action_12
action_211 (35) = happyGoto action_13
action_211 (44) = happyGoto action_16
action_211 _ = happyFail

action_212 _ = happyReduce_72

action_213 (75) = happyShift action_235
action_213 (99) = happyShift action_28
action_213 (41) = happyGoto action_234
action_213 _ = happyFail

action_214 _ = happyReduce_91

action_215 _ = happyReduce_23

action_216 _ = happyReduce_90

action_217 _ = happyReduce_86

action_218 _ = happyReduce_88

action_219 _ = happyReduce_94

action_220 (47) = happyShift action_17
action_220 (48) = happyShift action_18
action_220 (50) = happyShift action_144
action_220 (64) = happyShift action_19
action_220 (75) = happyShift action_145
action_220 (80) = happyShift action_21
action_220 (83) = happyShift action_146
action_220 (84) = happyShift action_23
action_220 (85) = happyShift action_24
action_220 (87) = happyShift action_25
action_220 (88) = happyShift action_26
action_220 (98) = happyShift action_27
action_220 (100) = happyShift action_147
action_220 (33) = happyGoto action_169
action_220 (34) = happyGoto action_141
action_220 (35) = happyGoto action_13
action_220 (38) = happyGoto action_170
action_220 (39) = happyGoto action_143
action_220 (42) = happyGoto action_233
action_220 (44) = happyGoto action_16
action_220 _ = happyFail

action_221 (76) = happyShift action_232
action_221 _ = happyFail

action_222 (82) = happyShift action_231
action_222 _ = happyFail

action_223 _ = happyReduce_17

action_224 (47) = happyShift action_17
action_224 (48) = happyShift action_18
action_224 (50) = happyShift action_144
action_224 (75) = happyShift action_145
action_224 (83) = happyShift action_183
action_224 (88) = happyShift action_26
action_224 (98) = happyShift action_27
action_224 (100) = happyShift action_147
action_224 (34) = happyGoto action_181
action_224 (35) = happyGoto action_13
action_224 (38) = happyGoto action_214
action_224 (39) = happyGoto action_143
action_224 (44) = happyGoto action_16
action_224 _ = happyFail

action_225 _ = happyReduce_62

action_226 _ = happyReduce_34

action_227 (78) = happyShift action_230
action_227 _ = happyFail

action_228 (47) = happyShift action_17
action_228 (48) = happyShift action_18
action_228 (64) = happyShift action_19
action_228 (75) = happyShift action_66
action_228 (80) = happyShift action_21
action_228 (83) = happyShift action_67
action_228 (84) = happyShift action_23
action_228 (85) = happyShift action_24
action_228 (87) = happyShift action_25
action_228 (88) = happyShift action_26
action_228 (98) = happyShift action_27
action_228 (33) = happyGoto action_229
action_228 (34) = happyGoto action_12
action_228 (35) = happyGoto action_13
action_228 (44) = happyGoto action_16
action_228 _ = happyFail

action_229 _ = happyReduce_69

action_230 _ = happyReduce_56

action_231 (47) = happyShift action_17
action_231 (48) = happyShift action_18
action_231 (50) = happyShift action_144
action_231 (64) = happyShift action_19
action_231 (75) = happyShift action_145
action_231 (80) = happyShift action_21
action_231 (83) = happyShift action_146
action_231 (84) = happyShift action_23
action_231 (85) = happyShift action_24
action_231 (87) = happyShift action_25
action_231 (88) = happyShift action_26
action_231 (98) = happyShift action_27
action_231 (100) = happyShift action_147
action_231 (33) = happyGoto action_169
action_231 (34) = happyGoto action_141
action_231 (35) = happyGoto action_13
action_231 (38) = happyGoto action_170
action_231 (39) = happyGoto action_143
action_231 (42) = happyGoto action_244
action_231 (44) = happyGoto action_16
action_231 _ = happyFail

action_232 _ = happyReduce_24

action_233 (74) = happyShift action_243
action_233 _ = happyFail

action_234 _ = happyReduce_78

action_235 (47) = happyShift action_17
action_235 (48) = happyShift action_18
action_235 (64) = happyShift action_19
action_235 (75) = happyShift action_20
action_235 (80) = happyShift action_21
action_235 (83) = happyShift action_22
action_235 (84) = happyShift action_23
action_235 (85) = happyShift action_24
action_235 (87) = happyShift action_25
action_235 (88) = happyShift action_26
action_235 (98) = happyShift action_27
action_235 (99) = happyShift action_28
action_235 (33) = happyGoto action_11
action_235 (34) = happyGoto action_12
action_235 (35) = happyGoto action_13
action_235 (40) = happyGoto action_110
action_235 (41) = happyGoto action_15
action_235 (44) = happyGoto action_16
action_235 _ = happyFail

action_236 _ = happyReduce_71

action_237 _ = happyReduce_70

action_238 _ = happyReduce_96

action_239 (46) = happyGoto action_242
action_239 _ = happyReduce_110

action_240 (47) = happyShift action_32
action_240 (49) = happyShift action_33
action_240 (59) = happyShift action_10
action_240 (11) = happyGoto action_29
action_240 (14) = happyGoto action_241
action_240 (15) = happyGoto action_240
action_240 (18) = happyGoto action_31
action_240 _ = happyReduce_13

action_241 _ = happyReduce_14

action_242 _ = happyReduce_7

action_243 (47) = happyShift action_17
action_243 (48) = happyShift action_18
action_243 (50) = happyShift action_144
action_243 (64) = happyShift action_19
action_243 (75) = happyShift action_145
action_243 (80) = happyShift action_21
action_243 (83) = happyShift action_146
action_243 (84) = happyShift action_23
action_243 (85) = happyShift action_24
action_243 (87) = happyShift action_25
action_243 (88) = happyShift action_26
action_243 (98) = happyShift action_27
action_243 (100) = happyShift action_147
action_243 (33) = happyGoto action_229
action_243 (34) = happyGoto action_141
action_243 (35) = happyGoto action_13
action_243 (38) = happyGoto action_246
action_243 (39) = happyGoto action_143
action_243 (44) = happyGoto action_16
action_243 _ = happyFail

action_244 (74) = happyShift action_245
action_244 _ = happyFail

action_245 (47) = happyShift action_17
action_245 (48) = happyShift action_18
action_245 (50) = happyShift action_144
action_245 (75) = happyShift action_145
action_245 (83) = happyShift action_183
action_245 (88) = happyShift action_26
action_245 (98) = happyShift action_27
action_245 (100) = happyShift action_147
action_245 (34) = happyGoto action_181
action_245 (35) = happyGoto action_13
action_245 (38) = happyGoto action_246
action_245 (39) = happyGoto action_143
action_245 (44) = happyGoto action_16
action_245 _ = happyFail

action_246 _ = happyReduce_89

happyReduce_7 = happyReduce 7 10 happyReduction_7
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

happyReduce_8 = happyReduce 5 11 happyReduction_8
happyReduction_8 ((HappyTerminal (Token happy_var_5 (TSym "."))) `HappyStk`
	(HappyAbsSyn37  happy_var_4) `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 TImport)) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Import (pos2Txt happy_var_1) (tTxt happy_var_2) happy_var_3 happy_var_4 (pos2Txt happy_var_5)
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_0  12 happyReduction_9
happyReduction_9  =  HappyAbsSyn12
		 (NoOptAs
	)

happyReduce_10 = happySpecReduce_2  12 happyReduction_10
happyReduction_10 (HappyTerminal happy_var_2)
	_
	 =  HappyAbsSyn12
		 (SomeOptAs (tTxt happy_var_2)
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_0  13 happyReduction_11
happyReduction_11  =  HappyAbsSyn13
		 (ImportsStart
	)

happyReduce_12 = happySpecReduce_2  13 happyReduction_12
happyReduction_12 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn13
		 (ImportsNext happy_var_1 happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_0  14 happyReduction_13
happyReduction_13  =  HappyAbsSyn14
		 (CmdsStart
	)

happyReduce_14 = happySpecReduce_2  14 happyReduction_14
happyReduction_14 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (CmdsNext happy_var_1 happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  15 happyReduction_15
happyReduction_15 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn15
		 (ImportCmd happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  15 happyReduction_16
happyReduction_16 (HappyTerminal (Token happy_var_2 (TSym ".")))
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn15
		 (DefTermOrType happy_var_1 (pos2Txt happy_var_2)
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happyReduce 5 15 happyReduction_17
happyReduction_17 ((HappyTerminal (Token happy_var_5 (TSym "."))) `HappyStk`
	(HappyAbsSyn38  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (DefKind (tPosTxt happy_var_1) (tTxt happy_var_1) happy_var_2 happy_var_4 (pos2Txt happy_var_5)
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_0  16 happyReduction_18
happyReduction_18  =  HappyAbsSyn16
		 (NoCheckType
	)

happyReduce_19 = happySpecReduce_2  16 happyReduction_19
happyReduction_19 (HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (Type happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_0  17 happyReduction_20
happyReduction_20  =  HappyAbsSyn17
		 (ParamsNil
	)

happyReduce_21 = happySpecReduce_2  17 happyReduction_21
happyReduction_21 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn17
		 (ParamsCons happy_var_1 happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happyReduce 4 18 happyReduction_22
happyReduction_22 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (DefTerm (tPosTxt happy_var_1) (tTxt happy_var_1) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 5 18 happyReduction_23
happyReduction_23 ((HappyAbsSyn33  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn38  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (DefType (tPosTxt happy_var_1) (tTxt happy_var_1) happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 5 19 happyReduction_24
happyReduction_24 ((HappyTerminal (Token happy_var_5 (TSym ")"))) `HappyStk`
	(HappyAbsSyn42  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "("))) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (Decl (pos2Txt happy_var_1) (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_4 (pos2Txt happy_var_5)
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_1  20 happyReduction_25
happyReduction_25 (HappyTerminal (Token happy_var_1 TTheta))
	 =  HappyAbsSyn20
		 ((Abstract       , pos2Txt happy_var_1)
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  20 happyReduction_26
happyReduction_26 (HappyTerminal (Token happy_var_1 TThetaEq))
	 =  HappyAbsSyn20
		 ((AbstractEq     , pos2Txt happy_var_1)
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  20 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn21  happy_var_2)
	(HappyTerminal (Token happy_var_1 TThetaVars))
	 =  HappyAbsSyn20
		 ((AbstractVars happy_var_2, pos2Txt happy_var_1)
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  21 happyReduction_28
happyReduction_28 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn21
		 (VarsStart (tTxt happy_var_1)
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  21 happyReduction_29
happyReduction_29 (HappyAbsSyn21  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn21
		 (VarsNext  (tTxt happy_var_1) happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  22 happyReduction_30
happyReduction_30 (HappyTerminal (Token happy_var_1 TRhoPlain))
	 =  HappyAbsSyn22
		 ((RhoPlain, pos2Txt happy_var_1)
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  22 happyReduction_31
happyReduction_31 (HappyTerminal (Token happy_var_1 TRhoPlus))
	 =  HappyAbsSyn22
		 ((RhoPlus , pos2Txt happy_var_1)
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_0  23 happyReduction_32
happyReduction_32  =  HappyAbsSyn23
		 (NoTerm
	)

happyReduce_33 = happySpecReduce_3  23 happyReduction_33
happyReduction_33 (HappyTerminal (Token happy_var_3 (TSym "}")))
	(HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (SomeTerm happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happyReduce 5 24 happyReduction_34
happyReduction_34 ((HappyAbsSyn24  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyAbsSyn32  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Lam (snd happy_var_1) (fst happy_var_1) (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 4 24 happyReduction_35
happyReduction_35 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 TLet)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Let (pos2Txt happy_var_1) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_36 = happySpecReduce_3  24 happyReduction_36
happyReduction_36 (HappyAbsSyn29  happy_var_3)
	(HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (Theta (snd happy_var_1) (fst happy_var_1) happy_var_2 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  24 happyReduction_37
happyReduction_37 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  25 happyReduction_38
happyReduction_38 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (App happy_var_1 NotErased happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  25 happyReduction_39
happyReduction_39 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (App happy_var_1 Erased    happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  25 happyReduction_40
happyReduction_40 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (AppTp happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  25 happyReduction_41
happyReduction_41 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_2  26 happyReduction_42
happyReduction_42 (HappyAbsSyn23  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "β")))
	 =  HappyAbsSyn24
		 (Beta    (pos2Txt happy_var_1) happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  26 happyReduction_43
happyReduction_43 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEps))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) Both               EpsHnf  happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  26 happyReduction_44
happyReduction_44 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsM))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) Both               EpsHanf happy_var_2
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  26 happyReduction_45
happyReduction_45 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsL))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) CedilleTypes.Left  EpsHnf  happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  26 happyReduction_46
happyReduction_46 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsLM))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) CedilleTypes.Left  EpsHanf happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  26 happyReduction_47
happyReduction_47 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsR))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) CedilleTypes.Right EpsHnf  happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_2  26 happyReduction_48
happyReduction_48 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 TEpsRM))
	 =  HappyAbsSyn24
		 (Epsilon (pos2Txt happy_var_1) CedilleTypes.Right EpsHanf happy_var_2
	)
happyReduction_48 _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_2  26 happyReduction_49
happyReduction_49 (HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "ς")))
	 =  HappyAbsSyn24
		 (Sigma (pos2Txt happy_var_1) happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happyReduce 4 26 happyReduction_50
happyReduction_50 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_2) `HappyStk`
	(HappyAbsSyn22  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Rho (snd happy_var_1) (fst happy_var_1) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_51 = happyReduce 4 26 happyReduction_51
happyReduction_51 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "χ"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Chi (pos2Txt happy_var_1) happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_52 = happySpecReduce_1  26 happyReduction_52
happyReduction_52 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  27 happyReduction_53
happyReduction_53 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn24
		 (Var (tPosTxt happy_var_1) (tTxt happy_var_1)
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  27 happyReduction_54
happyReduction_54 (HappyTerminal (Token happy_var_3 (TSym ")")))
	(HappyAbsSyn24  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "(")))
	 =  HappyAbsSyn24
		 (Parens (pos2Txt happy_var_1) happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_2  27 happyReduction_55
happyReduction_55 (HappyTerminal happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (IotaProj happy_var_1 (tTxt happy_var_2) (tPosTxt happy_var_2)
	)
happyReduction_55 _ _  = notHappyAtAll 

happyReduce_56 = happyReduce 6 27 happyReduction_56
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

happyReduce_57 = happySpecReduce_1  27 happyReduction_57
happyReduction_57 (HappyTerminal (Token happy_var_1 (TSym "●")))
	 =  HappyAbsSyn24
		 (Hole (pos2Txt happy_var_1)
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  28 happyReduction_58
happyReduction_58 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn28
		 (Atype happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_0  28 happyReduction_59
happyReduction_59  =  HappyAbsSyn28
		 (NoAtype
	)

happyReduce_60 = happySpecReduce_1  29 happyReduction_60
happyReduction_60 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn29
		 (LtermsNil  happy_var_1
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_2  29 happyReduction_61
happyReduction_61 (HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn29
		 (LtermsCons NotErased happy_var_1 happy_var_2
	)
happyReduction_61 _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  29 happyReduction_62
happyReduction_62 (HappyAbsSyn29  happy_var_3)
	(HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (LtermsCons Erased    happy_var_2 happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_0  30 happyReduction_63
happyReduction_63  =  HappyAbsSyn30
		 (NoClass
	)

happyReduce_64 = happySpecReduce_2  30 happyReduction_64
happyReduction_64 (HappyAbsSyn42  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (SomeClass happy_var_2
	)
happyReduction_64 _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_0  31 happyReduction_65
happyReduction_65  =  HappyAbsSyn31
		 (NoType
	)

happyReduce_66 = happySpecReduce_2  31 happyReduction_66
happyReduction_66 (HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn31
		 (SomeType happy_var_2
	)
happyReduction_66 _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  32 happyReduction_67
happyReduction_67 (HappyTerminal (Token happy_var_1 (TSym "Λ")))
	 =  HappyAbsSyn32
		 ((ErasedLambda, pos2Txt happy_var_1)
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  32 happyReduction_68
happyReduction_68 (HappyTerminal (Token happy_var_1 (TSym "λ")))
	 =  HappyAbsSyn32
		 ((KeptLambda  , pos2Txt happy_var_1)
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happyReduce 6 33 happyReduction_69
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

happyReduce_70 = happyReduce 6 33 happyReduction_70
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

happyReduce_71 = happyReduce 6 33 happyReduction_71
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

happyReduce_72 = happyReduce 5 33 happyReduction_72
happyReduction_72 ((HappyAbsSyn33  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_3) `HappyStk`
	(HappyAbsSyn43  happy_var_2) `HappyStk`
	(HappyTerminal (Token happy_var_1 (TSym "ι"))) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (Iota     (pos2Txt happy_var_1) (tPosTxt happy_var_2) (tTxt happy_var_2) happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_73 = happySpecReduce_3  33 happyReduction_73
happyReduction_73 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (TpArrow happy_var_1 ErasedArrow   happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  33 happyReduction_74
happyReduction_74 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (TpArrow happy_var_1 UnerasedArrow happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  33 happyReduction_75
happyReduction_75 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  33 happyReduction_76
happyReduction_76 (HappyTerminal (Token happy_var_3 TRSpan))
	(HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn33
		 (NoSpans happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happyReduce 5 33 happyReduction_77
happyReduction_77 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (TpEq happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_78 = happyReduce 6 34 happyReduction_78
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

happyReduce_79 = happySpecReduce_3  34 happyReduction_79
happyReduction_79 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (TpApp happy_var_1 happy_var_3
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_2  34 happyReduction_80
happyReduction_80 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (TpAppt happy_var_1 happy_var_2
	)
happyReduction_80 _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  34 happyReduction_81
happyReduction_81 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn33
		 (happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  35 happyReduction_82
happyReduction_82 (HappyTerminal (Token happy_var_3 (TSym ")")))
	(HappyAbsSyn33  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "(")))
	 =  HappyAbsSyn33
		 (TpParens (pos2Txt happy_var_1) happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  35 happyReduction_83
happyReduction_83 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn33
		 (TpVar (tPosTxt happy_var_1) (tTxt happy_var_1)
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  35 happyReduction_84
happyReduction_84 (HappyTerminal (Token happy_var_1 (TSym "●")))
	 =  HappyAbsSyn33
		 (TpHole (pos2Txt happy_var_1)
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  36 happyReduction_85
happyReduction_85 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn36
		 (TermArg happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_2  36 happyReduction_86
happyReduction_86 (HappyAbsSyn33  happy_var_2)
	_
	 =  HappyAbsSyn36
		 (TypeArg happy_var_2
	)
happyReduction_86 _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  37 happyReduction_87
happyReduction_87 (HappyAbsSyn46  happy_var_1)
	 =  HappyAbsSyn37
		 (ArgsNil happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_2  37 happyReduction_88
happyReduction_88 (HappyAbsSyn37  happy_var_2)
	(HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn37
		 (ArgsCons happy_var_1 happy_var_2
	)
happyReduction_88 _ _  = notHappyAtAll 

happyReduce_89 = happyReduce 6 38 happyReduction_89
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

happyReduce_90 = happySpecReduce_3  38 happyReduction_90
happyReduction_90 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (KndArrow   happy_var_1 happy_var_3
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_3  38 happyReduction_91
happyReduction_91 (HappyAbsSyn38  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn38
		 (KndTpArrow happy_var_1 happy_var_3
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  38 happyReduction_92
happyReduction_92 (HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn38
		 (happy_var_1
	)
happyReduction_92 _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_1  39 happyReduction_93
happyReduction_93 (HappyTerminal (Token happy_var_1 (TSym "★")))
	 =  HappyAbsSyn38
		 (Star (pos2Txt happy_var_1)
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_3  39 happyReduction_94
happyReduction_94 (HappyTerminal (Token happy_var_3 (TSym ")")))
	(HappyAbsSyn38  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "(")))
	 =  HappyAbsSyn38
		 (KndParens  (pos2Txt happy_var_1) happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_94 _ _ _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_2  39 happyReduction_95
happyReduction_95 (HappyAbsSyn37  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn38
		 (KndVar (tPosTxt happy_var_1) (tTxt happy_var_1) happy_var_2
	)
happyReduction_95 _ _  = notHappyAtAll 

happyReduce_96 = happyReduce 6 40 happyReduction_96
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

happyReduce_97 = happySpecReduce_3  40 happyReduction_97
happyReduction_97 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (LiftArrow   happy_var_1 happy_var_3
	)
happyReduction_97 _ _ _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_3  40 happyReduction_98
happyReduction_98 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn40
		 (LiftTpArrow happy_var_1 happy_var_3
	)
happyReduction_98 _ _ _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  40 happyReduction_99
happyReduction_99 (HappyAbsSyn40  happy_var_1)
	 =  HappyAbsSyn40
		 (happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  41 happyReduction_100
happyReduction_100 (HappyTerminal (Token happy_var_1 (TSym "☆")))
	 =  HappyAbsSyn40
		 (LiftStar (pos2Txt happy_var_1)
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_3  41 happyReduction_101
happyReduction_101 (HappyTerminal (Token happy_var_3 (TSym ")")))
	(HappyAbsSyn40  happy_var_2)
	(HappyTerminal (Token happy_var_1 (TSym "(")))
	 =  HappyAbsSyn40
		 (LiftParens  (pos2Txt happy_var_1) happy_var_2 (pos2Txt happy_var_3)
	)
happyReduction_101 _ _ _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  42 happyReduction_102
happyReduction_102 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn42
		 (Tkt happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  42 happyReduction_103
happyReduction_103 (HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn42
		 (Tkk happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  43 happyReduction_104
happyReduction_104 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_1  43 happyReduction_105
happyReduction_105 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_105 _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  44 happyReduction_106
happyReduction_106 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_106 _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_1  44 happyReduction_107
happyReduction_107 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_107 _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_1  45 happyReduction_108
happyReduction_108 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_108 _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_1  45 happyReduction_109
happyReduction_109 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn43
		 (happy_var_1
	)
happyReduction_109 _  = notHappyAtAll 

happyReduce_110 = happyMonadReduce 0 46 happyReduction_110
happyReduction_110 (happyRest) tk
	 = happyThen (( getPos)
	) (\r -> happyReturn (HappyAbsSyn46 r))

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	Token _ TEOF -> action 101 101 tk (HappyState action) sts stk;
	Token _ (TVar _) -> cont 47;
	Token _ (TQvar _) -> cont 48;
	Token _ (TKvar _) -> cont 49;
	Token _ (TQKvar _) -> cont 50;
	Token _ (TFpth _) -> cont 51;
	Token _ (TProj _) -> cont 52;
	Token happy_dollar_dollar TEps -> cont 53;
	Token happy_dollar_dollar TEpsM -> cont 54;
	Token happy_dollar_dollar TEpsL -> cont 55;
	Token happy_dollar_dollar TEpsLM -> cont 56;
	Token happy_dollar_dollar TEpsR -> cont 57;
	Token happy_dollar_dollar TEpsRM -> cont 58;
	Token happy_dollar_dollar TImport -> cont 59;
	Token happy_dollar_dollar TModule -> cont 60;
	Token happy_dollar_dollar TAs -> cont 61;
	Token happy_dollar_dollar TLet -> cont 62;
	Token happy_dollar_dollar TIn -> cont 63;
	Token happy_dollar_dollar TLSpan -> cont 64;
	Token happy_dollar_dollar TRSpan -> cont 65;
	Token happy_dollar_dollar TTheta -> cont 66;
	Token happy_dollar_dollar TThetaEq -> cont 67;
	Token happy_dollar_dollar TThetaVars -> cont 68;
	Token happy_dollar_dollar TRhoPlain -> cont 69;
	Token happy_dollar_dollar TRhoPlus -> cont 70;
	Token happy_dollar_dollar (TSym "=") -> cont 71;
	Token happy_dollar_dollar (TSym ">") -> cont 72;
	Token _  (TSym "_") -> cont 73;
	Token happy_dollar_dollar (TSym ".") -> cont 74;
	Token happy_dollar_dollar (TSym "(") -> cont 75;
	Token happy_dollar_dollar (TSym ")") -> cont 76;
	Token happy_dollar_dollar (TSym "[") -> cont 77;
	Token happy_dollar_dollar (TSym "]") -> cont 78;
	Token happy_dollar_dollar (TSym ",") -> cont 79;
	Token happy_dollar_dollar (TSym "{") -> cont 80;
	Token happy_dollar_dollar (TSym "}") -> cont 81;
	Token happy_dollar_dollar (TSym ":") -> cont 82;
	Token happy_dollar_dollar (TSym "Π") -> cont 83;
	Token happy_dollar_dollar (TSym "∀") -> cont 84;
	Token happy_dollar_dollar (TSym "λ") -> cont 85;
	Token happy_dollar_dollar (TSym "Λ") -> cont 86;
	Token happy_dollar_dollar (TSym "ι") -> cont 87;
	Token happy_dollar_dollar (TSym "↑") -> cont 88;
	Token happy_dollar_dollar (TSym "β") -> cont 89;
	Token happy_dollar_dollar (TSym "·") -> cont 90;
	Token happy_dollar_dollar (TSym "-") -> cont 91;
	Token happy_dollar_dollar (TSym "ς") -> cont 92;
	Token happy_dollar_dollar (TSym "χ") -> cont 93;
	Token happy_dollar_dollar (TSym "➾") -> cont 94;
	Token happy_dollar_dollar (TSym "➔") -> cont 95;
	Token happy_dollar_dollar (TSym "≃") -> cont 96;
	Token happy_dollar_dollar (TSym "◂") -> cont 97;
	Token happy_dollar_dollar (TSym "●") -> cont 98;
	Token happy_dollar_dollar (TSym "☆") -> cont 99;
	Token happy_dollar_dollar (TSym "★") -> cont 100;
	_ -> happyError' tk
	})

happyError_ 101 tk = happyError' tk
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
  happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn10 z -> happyReturn z; _other -> notHappyAtAll })

types = happySomeParser where
  happySomeParser = happyThen (happyParse action_1) (\x -> case x of {HappyAbsSyn33 z -> happyReturn z; _other -> notHappyAtAll })

term = happySomeParser where
  happySomeParser = happyThen (happyParse action_2) (\x -> case x of {HappyAbsSyn24 z -> happyReturn z; _other -> notHappyAtAll })

maybetype = happySomeParser where
  happySomeParser = happyThen (happyParse action_3) (\x -> case x of {HappyAbsSyn16 z -> happyReturn z; _other -> notHappyAtAll })

deftermtype = happySomeParser where
  happySomeParser = happyThen (happyParse action_4) (\x -> case x of {HappyAbsSyn18 z -> happyReturn z; _other -> notHappyAtAll })

cmd = happySomeParser where
  happySomeParser = happyThen (happyParse action_5) (\x -> case x of {HappyAbsSyn15 z -> happyReturn z; _other -> notHappyAtAll })

liftingtype = happySomeParser where
  happySomeParser = happyThen (happyParse action_6) (\x -> case x of {HappyAbsSyn40 z -> happyReturn z; _other -> notHappyAtAll })

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
{-# LINE 8 "<command-line>" #-}
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc/include/ghcversion.h" #-}

















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc8814_0/ghc_2.h" #-}


































































































































































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}








{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 256 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

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

{-# LINE 322 "templates/GenericTemplate.hs" #-}
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

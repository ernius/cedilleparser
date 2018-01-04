# Cedille Parser [![Build Status](https://travis-ci.org/ernius/cedilleparser.svg?branch=master)](https://travis-ci.org/ernius/cedilleparser)

Cedille dependant typed programming language parser

Must review:

* Reserved words: **import**, **module**, **as**, **let**, **in** and other several symbols.

* White spaces treatment in rules.

* Some term application associations desambiguation in terms and arrow operator in kinds.

For example the following term production rules:

```
aterm -> aterm ws maybeErased aterm .

maybeErased -> .
maybeErased -> '-' ows 
```
are replaced by:

```
Aterm ->  Aterm     Lterm
Aterm ->  Aterm '-' Lterm
```

So terms applications explicitly associates from left to right. Notation: name of grammar variables begin with uppercase, while tokens begin with lowercase or are quoted. Another change implied by the last rule, is that the left `aterm` and the `'-'` symbols could produce a string without any white spaces between them (equivalent to a rule `aterm -> aterm **ows** maybeErased aterm`)

The following kind production rule:

```
kind -> kind ows '➔' ows kind
```

is replaced by:

```
Kind -> LKind '➔' Kind
```

So arrow symbol associates explicitly from right to left. This precedence could also be reproduced by the use of Happy Context-Dependent Operator Precedence mechanism.
   
* Because of a reduce/reduce conflict with variables and holes in types and terms I added brackets to terms equality type syntax. That is, the following rule:

```
Type -> Term '≃' Term
```

is replaced by:

```
Type -> '{' Term '≃' Term '}'
```
  
* Position information should be converted into a string and verified.

* Verification of generated asts against previous parser.

* There exist three shift/reduce conflicts, two of them seems to be acceptable, but the following one requires further study.

```
State 242

	LiftingType -> 'Π' Bvar ':' Type . '.' LiftingType    (rule 95)
	Tk -> Type .                                          (rule 101)

	'.'            shift, and enter state 243
			(reduce using rule 101)
```

# Cedille Parser [![Build Status](https://travis-ci.org/ernius/cedilleparser.svg?branch=master)](https://travis-ci.org/ernius/cedilleparser)

Dependant typed programming language (called Cedille) parser developed in Haskell.

## Project details

Source code:
 * Lexer  [src/CedilleLexer.x](src/CedilleLexer.x)
 * Parser [src/CedilleParser.y](src/CedilleParser.y)

Some working examples tested in [test](test) project sub folder.

Haskell parser exported to Agda. Haskell AST datatype ([src/CedilleTypes.hs](src/CedilleTypes.agda)) export to Agda AST datatype ([src/cedille-types.agda](src/cedille-types.agda)), and minimal example calling the Haskell's parser from Agda ([src/test.agda](src/test.agda)).

Makefile/Cabal commands:
 * Build: `cabal build`.
 * Running tests: `cabal test` or `make tests`.
 * Running tests in debug mode: `make tests-debug`.
 * Rebuild parser info file: `make info`.
 * Running agda test: `make agda-test`.



## Must review:

* Reserved words (tokens): 

Description	          | Symbols
----------------------|----------
module system         | import, module, as
projections           | .0 .1 .. .9
general               | . , _ ( ) { } [ ] : - Π ∀ λ ● ι ↑ ➾ ➔ ☆ β · ≃ > Λ ς χ ★ ◂ =]
lifting types         | Πl ➔l
epsilon symbols       | ε ε- εl εl- εr εr-
theta symbols         | θ θ+ θ<
rho symbols           | ρ ρ+
span symbols          | {^ ^}
   
* Syntax Changes: 

Description   | Previous Rule                                                 | Updated Rule
--------------|---------------------------------------------------------------|----------------
Equality Type | `Type -> Term '≃' Term`                                    | `Type -> '{' Term '≃' Term '}'`
Lifting Types |	`LiftingType -> 'Π' Bvar ':' Type '.' LiftingType`     | `LiftingType -> 'Πl' Bvar ':' Type '.' LiftingType`
              | `LiftingType -> LliftingType  '➔' LiftingType`         | `LiftingType -> LliftingType  '➔l' LiftingType`
              | `LiftingType -> Type          '➔' LiftingType`         | `LiftingType -> Type          '➔l' LiftingType`
Let/in        |	`'let' DefTermOrType 'in' Term`                          | `'[' DefTermOrType ']' '-' Term`

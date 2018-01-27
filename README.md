# Cedille Parser [![Build Status](https://travis-ci.org/ernius/cedilleparser.svg?branch=master)](https://travis-ci.org/ernius/cedilleparser)

Dependant typed programming language (called Cedille) parser developed in Haskell.

## Project details

### Source code:
 * Lexer  [src/CedilleLexer.x](src/CedilleLexer.x)
 * Parser [src/CedilleParser.y](src/CedilleParser.y)

Some working examples tested in [test](test) project sub folder.

Haskell parser exported to Agda. Haskell AST datatype ([src/CedilleTypes.hs](src/CedilleTypes.agda)) export to Agda AST datatype ([src/cedille-types.agda](src/cedille-types.agda)), and minimal example calling the Haskell's parser from Agda ([src/test.agda](src/test.agda)).

### Makefile/Cabal commands:
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
general               | . , _ ( ) { } [ ] : - Π ∀ λ ● ι ↑ ➾ ➔ ☆ β · ≃ > Λ ς χ ★ ◂ =
lifting               | Π↑ ➔↑
epsilon               | ε ε- εl εl- εr εr-
theta                 | θ θ+ θ<
rho                   | ρ ρ+
span symbols          | {^ ^}
   
* Syntax Changes: 

Description     | Previous Rule                                            | Updated Rule
----------------|----------------------------------------------------------|----------------
Equality Type   | `Term '≃' Term`                                        | `'{' Term '≃' Term '}'`
Lifting Type    | `'Π' Bvar ':' Type '.' LiftingType`                 | `'Π↑' Bvar ':' Type '.' LiftingType`
Lifting Type    | `LliftingType  '➔' LiftingType`                      | `LliftingType  '➔↑' LiftingType`
Lifting Type    | `Type          '➔' LiftingType`                      | `Type          '➔↑' LiftingType`
Let/in          | `'let' DefTermOrType 'in' Term`                      | `'[' DefTermOrType ']' '-' Term`


* Another grammar change:

Changed `Term -> '{' Term '≃' Term '}'` to `LType -> '{' Term '≃' Term '}'`, so now the following term:
```
({ x ≃ x' }) ➔ Q x' ➔ X
```
can be written as:

```
{ x ≃ x' } ➔ Q x' ➔ X
```

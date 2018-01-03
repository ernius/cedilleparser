# Cedille Parser [![Build Status](https://travis-ci.org/ernius/cedilleparser.svg?branch=master)](https://travis-ci.org/ernius/cedilleparser)

Cedille dependant typed programming language parser

Must review:

- White spaces treatment in rules.
- Reserved words: import, module, as, let, in and several symbols.
- Some arrows association desambiguation in terms and types.
- Because of previous point I moved term equality from Type to Ltype grammar variable, in order to allow types equalities at the left of an arrow.
- Because of a reduce/reduce conflict with variables and holes in types and terms I added brackets to terms equality type.
- Position information should be converted into a string and verified.


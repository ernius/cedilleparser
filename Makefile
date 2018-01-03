console:
	cabal repl

test-console:
	cabal repl tests

backup: clean
	tar czvf ../cedilleparser-$(shell date --iso=seconds).tar.gz .

tests:
	cabal test

tests-debug: compile-tests-debug
	./test/Tests

compile-tests-debug: parser-debug lexer ast
	cd test; ghc -i../src Tests.hs; 

ast:    lexer
	cd src; ghc CedilleTypes.hs

parser-debug : lexer
	cd src;	happy -i -d -a CedilleParser.y

parser: ./src/CedilleParser.y lexer 
	cd src;	happy -i CedilleParser.y

lexer:  ./src/CedilleLexer.x
	cd src; alex CedilleLexer.x 

info:   
	happy -i src/CedilleParser.y; rm -f src/CedilleParser.hs; rm -f src/CedilleLexer.hs ; rm -f src/*.hi; rm -f src/*.o

clean:
	rm -f src/*.info; rm -f src/CedilleParser.hs; rm -f src/CedilleParser.info; rm -f src/CedilleLexer.hs ; rm -f src/*.hi; rm -f src/*.o; rm -f *~; rm -f src/*~; rm -f test/*~; rm -rf dist; rm -f test/*.o; rm -f test/*.hi; rm -f test/Tests



parser: parser.o lexer.o
	g++ -std=c++11 parser.o lexer.o -o parser

parser.o: rekurzivni_spust.cpp parser.tab.hpp
	g++ -std=c++11 -c rekurzivni_spust.cpp -o parser.o

lexer.o: lex.yy.c
	g++ -std=c++11 -c lex.yy.c -o lexer.o

lex.yy.c: lexer.l parser.tab.hpp
	flex lexer.l

.PHONY: clean

clean:
	rm -rf *.o *.yy.* parser

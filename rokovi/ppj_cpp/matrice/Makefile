parser: matrice.o lex.yy.o parser.tab.o
	g++ -std=c++11 matrice.o lex.yy.o parser.tab.o -o parser

matrice.o: matrice.hpp matrice.cpp
	g++ -std=c++11 -c matrice.cpp -o matrice.o

lex.yy.o: lex.yy.c parser.tab.hpp
	g++ -std=c++11 -c lex.yy.c -o lex.yy.o

parser.tab.o: parser.tab.cpp parser.tab.hpp matrice.cpp matrice.hpp
	g++ -std=c++11 -c parser.tab.cpp -o parser.tab.o

lex.yy.c: lexer.l parser.tab.hpp
	flex lexer.l

parser.tab.cpp parser.tab.hpp: parser.ypp
	bison -d -v parser.ypp
	
PHONY: clean

clean:
	rm -f parser *.tab.* *.yy.* *.o *.output

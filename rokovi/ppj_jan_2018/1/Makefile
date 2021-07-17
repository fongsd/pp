parser: parser.o lexer.o
	g++ -Wall -std=c++11 parser.o lexer.o -o parser -lm

lexer.o: lex.yy.c parser.tab.hpp
	g++ -Wall -std=c++11 -c lex.yy.c -o lexer.o

parser.o: parser.tab.cpp parser.tab.hpp
	g++ -Wall -std=c++11 -c parser.tab.cpp -o parser.o -lm

lex.yy.c: lexer.l
	flex lexer.l

parser.tab.cpp parser.tab.hpp: parser.ypp
	bison -v -d parser.ypp

.PHONY: clean

clean:
	rm -rf *.tab.* *.yy.* *.o *.output parser

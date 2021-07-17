parser: lexer.o parser.o
	g++ -Wall -std=c++11 lexer.o parser.o -o parser
lexer.o: lex.yy.c parser.tab.hpp
	g++ -Wall -std=c++11 -c lex.yy.c -o lexer.o

parser.o: parser.tab.cpp parser.tab.hpp
	g++ -Wall -std=c++11 -c parser.tab.cpp -o parser.o

lex.yy.c: lexer.l
	flex lexer.l

parser.tab.cpp parser.tab.hpp: parser.ypp
	bison -d -v parser.ypp

.PHONY: clean

clean:
	rm -rf *~ *.tab.* *.output *.o *.yy.* parser

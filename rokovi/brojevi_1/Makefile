parser: lexer.o parser.o
	g++ -std=c++11 parser.o lexer.o -o parser
	rm -rf *.tab.* *.output *.yy.* *.o

lexer.o: lex.yy.c parser.tab.hpp
	g++ -std=c++11 -c lex.yy.c -o lexer.o

parser.o: parser.tab.hpp parser.tab.cpp
	g++ -std=c++11 -c parser.tab.cpp -o parser.o

lex.yy.c: lexer.l
	flex lexer.l

parser.tab.cpp parser.tab.hpp: parser.ypp
	bison -d -v parser.ypp

.PHONY: clean

clean:
	rm -rf *.tab.* *.output parser *.yy.* *.o
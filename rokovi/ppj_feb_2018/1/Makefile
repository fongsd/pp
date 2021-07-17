parser: parser.o lexer.o
	g++ -Wall -std=c++11 parser.o lexer.o -o parser

parser.o: parser.tab.cpp parser.tab.hpp
	g++ -Wall -std=c++11 -c parser.tab.cpp -o parser.o

lexer.o: lex.yy.c parser.tab.hpp
	g++ -Wall -std=c++11 -c lex.yy.c -o lexer.o

lex.yy.c: lexer.l parser.tab.hpp
	flex lexer.l

parser.tab.cpp parser.tab.hpp: parser.ypp
	bison -v -d parser.ypp

.PHONY: clean

clean:
	rm -rf ~* *.tab.* *.yy.* *.output *.o parser

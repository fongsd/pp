parser: parser.o lexer.o
	g++ -Wall -std=c++11 parser.o lexer.o -o parser

parser.o: potisni_automat.cpp parser.tab.hpp
	g++ -Wall -std=c++11 -c potisni_automat.cpp -o parser.o

lexer.o: lex.yy.c parser.tab.hpp
	g++ -Wall -std=c++11 -c lex.yy.c -o lexer.o

lex.yy.c: lexer.l parser.tab.hpp
	flex lexer.l

.PHONY: clean

clean:
	rm -rf ~* *.yy.* *.o parser

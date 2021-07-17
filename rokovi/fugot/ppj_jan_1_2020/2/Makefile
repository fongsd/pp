parser: parser.o lexer.o
	g++ -std=c++11 parser.o lexer.o -o parser

parser.o: potisni_automat.cpp parser.tab.hpp
	g++ -std=c++11 -c potisni_automat.cpp -o parser.o

lexer.o: lex.yy.c
	g++ -std=c++11 -c lex.yy.c -o lexer.o

lex.yy.c: lexer.l parser.tab.hpp
	flex -i lexer.l

.PHONY: clean

clean:
	rm -rf *.o *.yy.* parser

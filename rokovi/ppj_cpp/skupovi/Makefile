parser: skup.o lex.yy.o parser.tab.o
	g++ -std=c++11 skup.o lex.yy.o parser.tab.o -o parser

skup.o: skup.cpp skup.hpp
	g++ -std=c++11 -c skup.cpp -o skup.o

lex.yy.o: lex.yy.c parser.tab.hpp
	g++ -std=c++11 -c lex.yy.c -o lex.yy.o

parser.tab.o: parser.tab.cpp parser.tab.hpp
	g++ -std=c++11 -c parser.tab.cpp -o parser.tab.o

lex.yy.c: lexer.l parser.tab.hpp
	flex -l lexer.l

parser.tab.cpp parser.tab.hpp: parser.ypp skup.cpp skup.hpp
	bison -d -v parser.ypp
	
.PHONY: clean

clean:
	rm -f parser *.tab.* *.o *.yy.* *.output

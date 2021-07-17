parser: lex.yy.o polinom.o parser.tab.o
	g++ -std=c++11 lex.yy.o polinom.o parser.tab.o -o parser

lex.yy.o: lex.yy.c parser.tab.hpp
	g++ -std=c++11 -c lex.yy.c -o lex.yy.o

parser.tab.o: parser.tab.cpp parser.tab.hpp
	g++ -std=c++11 -c parser.tab.cpp -o parser.tab.o

polinom.o: polinom.cpp polinom.hpp
	g++ -std=c++11 -c polinom.cpp -o polinom.o

lex.yy.c: lexer.l parser.tab.hpp
	flex lexer.l

parser.tab.cpp parser.tab.hpp: parser.ypp
	bison -d -v parser.ypp

.PHONY: clean

clean:
	rm -f parser *.tab.* *.yy.* *.o *.output

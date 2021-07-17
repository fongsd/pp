PROG = parser
CC = gcc
LEX = flex
YACC = yacc
CFLAGS = -Wall

parser: lex.yy.o y.tab.o
	$(CC) $(CFLAGS) -o $@ $^
lex.yy.o: lex.yy.c y.tab.h
	$(CC) $(CFLAGS) -c -o $@ $<
lex.yy.c: primer.l 
	$(LEX) $<
y.tab.o: y.tab.c y.tab.h
	$(CC) $(CFLAGS) -c -o $@ $<
y.tab.c y.tab.h : primer.y
	$(YACC) -d $<

.PHONY: clean

clean:
	-rm *~ $(PROG) *.o *.c *.h

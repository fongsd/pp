%option noyywrap
%{
  /* Ukljucujemo zaglavlja u kome su definisani tokeni i stdlib zbog atoi */
  #include<stdlib.h>
  #include "y.tab.h"
  /* Fju yyerror koristimo iz fajla primer.y */
  extern void yyerror(char *s);
%}
/* Regularne definicije */
DIGIT [0-9]
WHITE [\n \t]
%%
printf		{ return print1; }
print		{ return print2; }
brojilac	{ return brojilac; }
imenilac	{ return imenilac; }
recip		{ return recip; }
skrati		{ return skratiti; }
[-+*/()\[\],;]	{ return *yytext; }
[+-]?{DIGIT}+	{
		  yylval.v = atoi(yytext);
		  return num;
		}
{WHITE}		{}
.		{ yyerror("Greska u leksickom analizatoru"); }
%%

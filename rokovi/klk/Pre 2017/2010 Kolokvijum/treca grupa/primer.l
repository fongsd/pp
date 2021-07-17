%option noyywrap
%{
  /* Ukljucujemo zaglavlje u kome su definisani tokeni */
  #include "y.tab.h"
  /* F-ju yyerror koristicemo iz fajla primer.y */
  extern void yyerror(char *s);
%}
/* Regularne definicije */
LETTER [a-z]
WHITE [\n \t]

%%

print		{ return print; }
complement	{ return complement; }
number		{ return number; }
isinset		{ return isinset; }
"/\\"		{ return presek; }
"\\/"		{ return unija; }
[{},;\\]	{ return *yytext; }
{LETTER}	{ 
		  yylval.c = *yytext;
		  return slovo;
		}
{WHITE}		{}
.		{ yyerror("Greska u leksickom analizatoru"); }

%%

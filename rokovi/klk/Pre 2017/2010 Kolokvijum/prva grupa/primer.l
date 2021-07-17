%option noyywrap
%{
  /* Ukljucujmo zaglavla sa tokenima, i stdlib zbog atof */
  #include<stdlib.h>
  #include "y.tab.h"
  /* Fju yyerror koristimo iz primer.y */
  extern void yyerror(char *s);
%}
/* regluarne definicije */
DIGIT [0-9]
WHITE [\n \t]

%%
printf				{ return print; }
real				{ return real; }
complex				{ return complex; }
arg				{ return arg; }
[-+*/()\[\],;|]			{ return *yytext; }
[+-]?{DIGIT}+(\.{DIGIT}+)?	{
				  yylval.v = atof(yytext);
				  return num;
				}
{WHITE}				{}
.				{ yyerror("Greska u leksickom analizatoru"); }
%%

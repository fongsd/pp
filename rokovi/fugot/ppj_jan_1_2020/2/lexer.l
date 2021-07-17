%option noyywrap

%{
#include <iostream>

#include "parser.tab.hpp"
%}

%%

"ktnxbye"	{ return BYE_T; }
"iz"		{ return IZ_T; }
"rofl"		{ return PRINT_T; }
"orly?"		{ return COND_T; }
"uber"		{ return GT_T; }
"liek"		{ return EQ_T; }
"nope"		{ return NEG_T; }

lo{1,48}l	{ return ID_T; }
[0-9]+		{ return BROJ_T; }

[\n+*()-]	{ return *yytext; }
"++"		{ return INC_T; } 
"--"		{ return DEC_T; }

[ \t]		{ }
.			{
				std::cerr << "Leksicka greska " << yytext << std::endl;
				exit(EXIT_FAILURE);
			}

%%

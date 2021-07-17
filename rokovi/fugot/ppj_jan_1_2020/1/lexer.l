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

lo{1,48}l	{
				for(int i = 0; yytext[i] != '\0'; i++)
					yytext[i] = toupper(yytext[i]);
				yylval.ime = new std::string(yytext);
				return ID_T;
			}
[0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]	{
				yylval.vrednost = strtol(yytext, NULL, 10);
				return BROJ_T;
			}

[\n+*()-]	{ return *yytext; }
"++"		{ return INC_T; } 
"--"		{ return DEC_T; }

[ \t]		{ }
.			{
				std::cerr << "Leksicka greska " << yytext << std::endl;
				exit(EXIT_FAILURE);
			}

%%

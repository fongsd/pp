%option noyywrap

%{
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <vector>

#include "parser.tab.hpp"
%}

%%

"print"			{ return PRINT_T; }
"ugao"			{ return UGAO_T; }
"eqv"			{ return EKV_T; }
":="			{ return ASGN_T; }
[,()<>;+*-\.|]	{ return *yytext; }
[a-z]			{
					yylval.ime = *yytext;
					return ID_T;
				}
(0|[1-9][0-9]*)(\.[0-9]*)?	{
					yylval.vrednost = strtof(yytext, NULL);
					return BROJ_T;
				}
[ \t\n]			{ }
.				{
					std::cerr << "Leksicka greska: " << yytext << std::endl;
					exit(EXIT_FAILURE);
				}

%%

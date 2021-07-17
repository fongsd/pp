%option noyywrap

%{
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <map>
#include <string>

#include "kvaternion.hpp"
#include "parser.tab.hpp"
%}

%%

"def"				{ return DEF_T; }
"print"				{ return PRINT_T; }
"norm"				{ return NORM_T; }
":="				{ return EQ_T; }

[+-]?[0-9]+(\.[0-9]*)?	{
							yylval.vrednost = atof(yytext);
							return BROJ_T;
						}
\"[^"]+\"				{
							yylval.niska = new std::string(yytext);
							return FORMAT_T;
						}
[a-z]+					{
							yylval.niska = new std::string(yytext);
							return ID_T;
						}

[:;,()+*/-]				{ return *yytext; }
[ \t\n]					{ }
.						{
							std::cerr << "Leksiscka greska: " << yytext << std::endl;
							exit(EXIT_FAILURE);
						}

%%

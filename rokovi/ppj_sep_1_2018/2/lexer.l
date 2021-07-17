%option noyywrap

%{
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <map>
#include <string>

#include "parser.tab.hpp"
%}

%%

"def"				{ return DEF_T; }
"print"				{ return PRINT_T; }
"norm"				{ return NORM_T; }
":="				{ return EQ_T; }

[+-]?[0-9]+(\.[0-9]*)?	{ return BROJ_T; }
\"[^"]+\"				{ return FORMAT_T; }
[a-z]+					{ return ID_T; }

[:;,()+*/-]				{ return *yytext; }
[ \t\n]					{ }
.						{
							std::cerr << "Leksiscka greska: " << yytext << std::endl;
							exit(EXIT_FAILURE);
						}

%%

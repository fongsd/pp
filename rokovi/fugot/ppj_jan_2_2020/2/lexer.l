%option noyywrap

%{
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <cstring>
#include <map>

#include "parser.tab.hpp"
%}

%%

"print"					{ return PRINT_T; }
"$"[a-zA-Z0-9_]+		{ return ID_T; }
[0-9]+					{ return CONST_T; }
\"[^\"]*\"				{ return CONST_T; }
[=.,x;()\[\]+*/-]		{ return *yytext; }
[ \t\n]					{ }
.						{
							std::cerr << "Leksicka greska: " << yytext << std::endl;
							exit(EXIT_FAILURE);
						}

%%

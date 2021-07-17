%option noyywrap

%{
#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <vector>
#include <map>

#include "parser.tab.hpp"
%}

%%

"max"										{ return MAX_T; }
"min"										{ return MIN_T; }
"prosek"									{ return PROSEK_T; }
"rad"										{ return RAD_T; }
"<"											{ return LT_T; }
">"											{ return GT_T; }
"<="										{ return LTE_T; }
">="										{ return GTE_T; }
"=="										{ return EQ_T; }
"!="										{ return NEQ_T; }
[a-z][a-z0-9]*								{
												yylval.ime = new std::string(yytext);
												return ID_T;
											}
[A-Z][a-zA-Z0-9]*							{
												yylval.ime = new std::string(yytext);
												return IDL_T;
											}
[0-9]+										{
												yylval.vrednost = atoi(yytext);
												return BROJ_T;
											}
[\.\n()\[\],=*/+-]							{ return *yytext; }
[ \t]										{ }
.											{
												std::cerr << "Leksicka greska: " << yytext << std::endl;
												exit(EXIT_FAILURE);
											}

%%

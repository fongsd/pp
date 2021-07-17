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

"False"					{
							yylval.vrednost = 2;
							return VAL_T;
						}
"True"					{
							yylval.vrednost = 1;
							return VAL_T;
						}
"Undef"					{
							yylval.vrednost = 0;
							return VAL_T;
						}
"head"					{ return HEAD_T; }
"tail"					{ return TAIL_T; }
":="					{ return EQ_T; }
"/\\"					{ return AND_T; }
"\\/"					{ return OR_T; }
"=>"					{ return IMPL_T; }
"<=>"					{ return EQUI_T; }
"!"						{ return NEG_T; }
[\n()\[\],]				{ return *yytext; }
0|[1-9][0-9]*			{
							yylval.vrednost = strtol(yytext, NULL, 10);
							return BROJ_T;
						}
[a-z][a-z0-9]*			{
							yylval.ime = new std::string(yytext);
							return ID_T;
						}
[A-Z][A-Z0-9]*			{
							yylval.ime = new std::string(yytext);
							return IDL_T;
						}
[ \t]					{ }
.						{
							std::cerr << "Leksicka greska: " << yytext << std::endl;
							exit(EXIT_FAILURE);
						}

%%

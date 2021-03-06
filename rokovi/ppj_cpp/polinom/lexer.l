%option noyywrap
%option noinput
%option nounput

%{

#include <iostream>
#include <cstdlib>
#include <string>

using namespace std;

#include "polinom.hpp"
#include "parser.tab.hpp"

%}

%%

[a-zA-Z_][a-zA-Z0-9_]*		{
								yylval.ime = new string(yytext);
								return ID;
							}
[+-]?[0-9]+(\.[0-9]+)?		{
								yylval.x = atof(yytext);
								return BROJ;
							}
":="						{return DODELA;}
"=="						{return EQ;}
"!="						{return NEQ;}
[<>,'$|+*\[\]\n()-]			{return *yytext;}
[ \t]						{ }
.							{
								cerr<<"Leksicka greska: "<<yytext<<endl;
								exit(EXIT_FAILURE);
							}


%%

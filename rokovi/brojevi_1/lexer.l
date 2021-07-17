%option noyywrap

%{

#include <bits/stdc++.h>

using namespace std;

#include "parser.tab.hpp"

%}

%%

print                       {return PRINT_T;}
int                         {return INT_T;}
list                        {return LIST_T;}
[a-zA-Z_]                   {yylval.id = new string(yytext); return ID;}
0x[0-9A-F]+                 {yylval.v = strtol(yytext, NULL, 16);return BROJ;}
0[0-7]+                     {yylval.v = strtol(yytext, NULL, 8);return BROJ;}
[0-9]+                      {yylval.v = atoi(yytext);return BROJ;}
"<<"                        {return SHL_T;}
">>"                        {return SHR_T;}
"=="                        {return EQ_T;}
[\n\[\]+*/()&|,=-]          {return *yytext;}             
[ \t]                       {}
.                           {cerr << "Leksicka greska: " << yytext << endl; exit(EXIT_FAILURE);}

%%
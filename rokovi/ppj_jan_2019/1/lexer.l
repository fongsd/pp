%option noyywrap

%{
#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>

#include "parser.tab.hpp"
    
%}


%%
int                     {return INT_T;}
print                   {return PRINT_T;}
list                    {return LIST_T;}
"<<"                    {return SHL_T;}
">>"                    {return SHR_T;}
"=="                    {return EQL_T;}
[_][A-Za-z][A-Za-z0-9]* {
                          yylval.ime = new std::string(yytext);
                          return ID_T;
                        }
[l][A-Za-z0-9_]+        {
                          yylval.ime = new std::string(yytext);
                          return LID_T;
                        }
(0|[1-9][0-9]*)         {
                          yylval.broj = atoi(yytext);
                          return BROJ;
                        }
0x(0|[1-9A-F][0-9A-F]*) {
                          sscanf(yytext, "%x", &yylval.broj);
                          return BROJ;
                        }
0(0|[1-7][0-7]*)        {
                          sscanf(yytext, "%o", &yylval.broj);
                          return BROJ;
                        }  
[=+\-*/&|^,();\[\]~]  {return *yytext;}
[ \n\t]                 {}
.                       {
                            std::cerr << "Leksicka greska: " << yytext << std::endl;
                            exit(EXIT_FAILURE);
                        } 
%%

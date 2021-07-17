%option noyywrap

%{
#include <iostream>
#include <string>
#include <cstdlib>
#include <vector>

#include "parser.tab.hpp"
%}

%%
"min"                       {return MIN_T;}
"max"                       {return MAX_T;}
"prosek"                    {return PROSEK_T;}
"<="                        {return LTEQ_T;}
">="                        {return GTEQ_T;}
"=="                        {return EQ_T;}
"!="                        {return NEQ_T;}
"rad"                       {return RAD_T;}
[a-z][a-z0-9]*              {
                                yylval.ime = new std::string(yytext);
                                return ID_T;
                            }
[A-Z][a-zA-Z0-9]*           {
                                yylval.ime = new std::string(yytext);
                                return LID_T;
                            }
0|[1-9][0-9]*               {
                                yylval.vrednost = strtol(yytext, NULL, 10);
                                return BROJ_T;
                            }
[-+=*/().<>\]\[,\n]         {return *yytext;}
[ \t]                       {}
.                           {
                                std::cerr << "Leksicka greska: Nepoznata leksema " << yytext << std::endl;
                                exit(EXIT_FAILURE);
                            }          
%%

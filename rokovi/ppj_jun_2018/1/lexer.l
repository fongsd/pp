%option noyywrap

%{
#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>
    
#include "parser.tab.hpp"
%}

%%
"disp"              {return DISP_T;}
"size"              {return SIZE_T;}
"\.\+"              {return PKSABIRANJE_T;}
"\.\*"              {return PKMNOZENJE_T;}
"'"                 {return TRANS_T;}
([a-z]|[A-Z])       {
                        yylval.ime = new std::string(yytext);
                        return ID_T;
                    }    
(-)?(0|[1-9][0-9]*) {
                        yylval.vrednost = atoi(yytext);
                        return BROJ_T;
                    }
[=\[\];,()*\n]      {return *yytext;}
[ \t]               {}
.                   {
                        std::cerr << "Leksicka greska: Neprepoznat token " << yytext << std::endl;
                        exit(EXIT_FAILURE);
                    }
%%

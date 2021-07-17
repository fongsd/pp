%option noyywrap

%{
    #include <iostream>
    #include <string>
    #include <vector>
    #include <cstdlib>

    #include "parser.tab.hpp"
%}

 
%%
check                   {return CHECK_T;}
UniversalSet            {
                            return USID_T;
                        }
card                    {return CARD_T;}
print                   {return PRINT_T;}
[A-Z][A-Z0-9]*          {
                            yylval.ime = new std::string(yytext);
                            return ID_T;
                        }
(-)?(0|[1-9][0-9]*)     {
                            yylval.vrednost = atoi(yytext);
                            return BROJ_T;
                        }
"\\/"                    {return UNIJA_T;}
"/\\"                    {return PRESEK_T;}
"\\"                     {return RAZLIKA_T;}
".."                    {return INTERVAL_T;}
[={},;:<~]              {return *yytext;}
[ \t\n]                 {}    
.                       {
                            std::cerr << "Leksicka greska: Nepoznat token. " << yytext << std::endl;
                            exit(EXIT_FAILURE);
                        }

%%

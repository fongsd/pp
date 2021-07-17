%option noyywrap

%{
#include <iostream>
#include <cstdlib>
#include <string>


#include "parser.tab.hpp"    
%}

%%
"niska"                 {return NISKA_T;}
".obrni()"              {return OBRNI_T;}
".sortiraj()"           {return SORTIRAJ_T;}
".velika()"             {return VELIKA_T;}
".mala()"               {return MALA_T;}
"stampaj"               {return STAMPAJ_T;}
"duzina"                {return DUZINA_T;}
".podniska"             {return PODNISKA_T;}
\"([^\\\"]|\\.)*\"      {
                            yylval.ime = new std::string(yytext+1, strlen(yytext)-2);
                            return CONST_T;
                        }
[a-zA-Z][A-Za-z_0-9]*   {
                            yylval.ime = new std::string(yytext);
                            return ID_T;
                        }
"=="                    {return EQ_T;}
"+="                    {return EQPLUS_T;}
0|[1-9][0-9]*           {
                            yylval.indeks = atoi(yytext);
                            return BROJ_T;
                        }
[=*\[\],();.<>+]          {return *yytext;}
[ \t\n]                 {}
.                       {
                            std::cerr << "Leksicka greska: Neprepoznata leksema: " << yytext << std::endl;
                            exit(EXIT_FAILURE);
                        }
%%

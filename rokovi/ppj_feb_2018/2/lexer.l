%option noyywrap

%{
#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>

#include "parser.tab.hpp"
%}


%%
"True"              {
                        return CONST_T;
                    }
"False"             {
                        return CONST_T;
                    }       
"Undef"             {
                        return CONST_T;
                    }    
"/\\"               {return KONJ_T;}       
"\\/"               {return DISJ_T;}
"=>"                {return IMPL_T;}
"<=>"               {return EKV_T;}
":="                {return DODELA_T;}
"!"                 {return NEG_T;}
"head"              {return HEAD_T;}
"tail"              {return TAIL_T;}
[a-z][a-z0-9]*      {
                        return ID_T;
                    }  
[A-Z][A-Z0-9]*      {
                        return LID_T;
                    }
0|[1-9][0-9]*       {
                        return BROJ_T;
                    }
[,\[\]\n()]          {return *yytext;}
[ \t]               {}
.                   {
                        std::cerr << "Leksicka greska: Neprepoznat token " << yytext << std::endl;
                        exit(EXIT_FAILURE);
                    }

%%

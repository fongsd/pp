#include <iostream>
#include <stack>
#include <string>

#include "parser.tab.hpp"

extern int yylex();

/*
P ->    N \n PP
PP ->   N \n PP
        | eps               
N ->    ID_T DODELA_T I
        | I
I -> A IP
IP -> KONJ_T A IP
      | DISJ_T A IP
      | eps
A -> '!' B
      | '(' B ')'
      | B
B -> ID_T
    | TRUE_T
    | UNDEF_T
    | FALSE_T
*/

int main(int argc, char **argv){
    
    return 0;
}

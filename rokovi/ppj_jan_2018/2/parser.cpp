#include <iostream>
#include <cstdlib>
#include <stack>
#include <vector>

#include "parser.tab.hpp"

extern int yylex();

std::stack<int> s; 
#define EOI 0

#define P 1000
#define PP 1001
#define N 1002
#define I 1003
#define IP 1004
#define A 1005
#define B 1006
#define L 1007
#define EL 1008
#define ELP 1009

void greska(){
    std::cerr << "Sintaksna greska" << std::endl;
    exit(EXIT_FAILURE);
}
 
 /*
 * P -> N ; PP              {ID_T PRINT_T}
 * PP -> N ; PP             {ID_T PRINT_T}
 *      | eps               {EOI}
 * N -> ID_T DODELA_T I     {ID_T}
 *      | PRINT_T ( I )     {PRINT_T}
 * I -> A IP                {BROJ_T < ID_T}
 * IP -> + A IP             {+}
 *      | - A IP            {-}
 *      | eps               {; )}
 * A -> BROJ_T * B          {BROJ_T}
 *      | B                 {< ID_T}
 * B -> L                   {<}
 *      | ID_T              {ID_T}
 * L -> < EL >              {<}
 * EL -> BROJ_T ELP         {BROJ_T}
 * ELP -> , BROJ_T ELP      {,}
 *        | eps             {>}
 *
 */
 
int main(int argc, char **argv){
    int preduvid = yylex();
    s.push(P);
    
    while(!s.empty()){
        switch(s.top()){
            case P:
                if(preduvid == ID_T || preduvid == PRINT_T){
                    s.pop();
                    s.push(PP);
                    s.push(';');
                    s.push(N);
                }else {
                    greska();
                }
                break;
            case PP:
                if(preduvid == ID_T || preduvid == PRINT_T){
                    s.pop();
                    s.push(PP);
                    s.push(';');
                    s.push(N);
                }else if(preduvid == EOI){
                    s.pop();
                }else{
                    greska();
                }
                break;
            case N:
                if(preduvid == ID_T){
                    s.pop();
                    s.push(I);
                    s.push(DODELA_T);
                    s.push(ID_T);
                }else if(preduvid == PRINT_T){
                    s.pop();
                    s.push(')');
                    s.push(I);
                    s.push('(');
                    s.push(PRINT_T);
                }else {
                    greska();
                }
                break;
            case I:
                if(preduvid == BROJ_T || preduvid == '<' || preduvid == ID_T){
                    s.pop();
                    s.push(IP);
                    s.push(A);
                }else {
                    greska();
                }
                break;
            case IP:
                if(preduvid == '+'){
                    s.pop();
                    s.push(IP);
                    s.push(A);
                    s.push('+');
                }else if(preduvid == '-'){
                    s.pop();
                    s.push(IP);
                    s.push(A);
                    s.push('-');
                }else if(preduvid == ';' || preduvid == ')')
                {
                    s.pop();
                }
                else{
                    greska();
                }
                break;
            case A:
                if(preduvid == BROJ_T){
                    s.pop();
                    s.push(B);
                    s.push('*');
                    s.push(BROJ_T);
                }else if(preduvid == '<' || preduvid == ID_T){
                    s.pop();
                    s.push(B);
                }else {
                    greska();
                }
                break;
            case B:
                if(preduvid == '<'){
                    s.pop();
                    s.push(L);
                }else if(preduvid == ID_T){
                    s.pop();
                    s.push(ID_T);
                }else {
                    greska();
                }
                break;
            case L:
                if(preduvid == '<'){
                    s.pop();
                    s.push('>');
                    s.push(EL);
                    s.push('<');
                }else {
                    greska();
                }
                break;
            case EL:
                if(preduvid == BROJ_T){
                    s.pop();
                    s.push(ELP);
                    s.push(BROJ_T);
                }else {
                    greska();
                }
                break;
            case ELP:
                if(preduvid == ','){
                    s.pop();
                    s.push(ELP);
                    s.push(BROJ_T);
                    s.push(',');
                }else if(preduvid == '>'){
                    s.pop();
                }else {
                    greska();
                }
                break;
            default: 
                if(s.top() == preduvid)
				{
					s.pop();
					preduvid = yylex();
				}
				else
				{
					greska();
				}
                break;
        }
    }
    
    if(preduvid == EOI){
        std::cout << "Sve ok" << std::endl;
    }else {
        std::cout << "Nije ok" << std::endl;
    }
    
    
    return 0;
}

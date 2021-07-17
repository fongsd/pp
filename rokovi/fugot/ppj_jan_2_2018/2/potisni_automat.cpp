#include <iostream>
#include <stack>
#include <vector>
#include "parser.tab.hpp"

extern int yylex();

#define EOI	0
#define P	1000
#define PP	1001
#define N	1002
#define NP	1003
#define Q	1004
#define I	1005
#define IP	1006
#define A	1007
#define AP	1008
#define B	1009
#define C	1010
#define R	1011
#define S	1012

/*
P -> N \n PP		{ID_T, (, VAL_T, NEG_T}
PP -> N \n PP		{ID_T, (, VAL_T, NEG_T}
	| eps			{EOI}
N -> ID_T R			{ID_T}
	| VAL_T S		{VAL_T}
	| ( I )			{(}
	| NEG_T I		{NEG_T}
R -> NP				{EQ_T, AND_T, OR_T}
	| eps			{\n}
S -> Q				{AND_T, OR_T}
	| eps			{\n}
NP -> EQ_T I		{EQ_T}
	| Q				{AND_T, OR_T}	
Q -> AND_T I		{AND_T}
	| OR_T I		{OR_T}
I -> A IP			{NEG_T, (, ID_T, VAL_T}
IP -> OR_T A IP		{OR_T}
	| eps			{), \n}
A -> B AP			{NEG_T, (, ID_T, VAL_T}
AP -> AND_T B AP	{AND_T}
	| eps			{OR_T, ), \n}
B -> NEG_T B		{NEG_T}
	| C				{(, ID_T, VAL_T}
C -> ( I )			{(}
	| ID_T			{ID_T}
	| VAL_T			{VAL_T}
*/

int main(int argc, char *argv[]) {
	std::stack<int> stek;
	int preduvid = yylex();
	
	stek.push(P);
	while(!stek.empty())
	{
		switch(stek.top())
		{
			case P:
				if(preduvid == ID_T || preduvid == '(' || preduvid == VAL_T || preduvid == NEG_T)
				{
					stek.pop();
					stek.push(PP);
					stek.push('\n');
					stek.push(N);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case PP:
				if(preduvid == ID_T || preduvid == '(' || preduvid == VAL_T || preduvid == NEG_T)
				{
					stek.pop();
					stek.push(PP);
					stek.push('\n');
					stek.push(N);
				}
				else if(preduvid == EOI)
					stek.pop();
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case N:
				if(preduvid == ID_T)
				{
					stek.pop();
					stek.push(R);
					stek.push(ID_T);
				}
				else if(preduvid == '(')
				{
					stek.pop();
					stek.push(')');
					stek.push(I);
					stek.push('(');
				}
				else if(preduvid == VAL_T)
				{
					stek.pop();
					stek.push(S);
					stek.push(VAL_T);
				}
				else if(preduvid == NEG_T)
				{
					stek.pop();
					stek.push(I);
					stek.push(NEG_T);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case R:
				if(preduvid == EQ_T || preduvid == AND_T || preduvid == OR_T)
				{
					stek.pop();
					stek.push(NP);
				}
				else if(preduvid == '\n')
					stek.pop();
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case S:
				if(preduvid == AND_T || preduvid == OR_T)
				{
					stek.pop();
					stek.push(Q);
				}
				else if(preduvid == '\n')
					stek.pop();
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case NP:
				if(preduvid == EQ_T)
				{
					stek.pop();
					stek.push(I);
					stek.push(EQ_T);
				}
				else if(preduvid == AND_T || preduvid == OR_T)
				{
					stek.pop();
					stek.push(Q);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case Q:
				if(preduvid == AND_T)
				{
					stek.pop();
					stek.push(I);
					stek.push(AND_T);
				}
				else if(preduvid == OR_T)
				{
					stek.pop();
					stek.push(I);
					stek.push(OR_T);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case I:
				if(preduvid == NEG_T || preduvid == '(' || preduvid == ID_T || preduvid == VAL_T)
				{
					stek.pop();
					stek.push(IP);
					stek.push(A);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case IP:
				if(preduvid == OR_T)
				{
					stek.pop();
					stek.push(OR_T);
				}
				else if(preduvid == ')' || preduvid == '\n')
					stek.pop();
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case A:
				if(preduvid == NEG_T || preduvid == '(' || preduvid == ID_T || preduvid == VAL_T)
				{
					stek.pop();
					stek.push(AP);
					stek.push(B);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case AP:
				if(preduvid == AND_T)
				{
					stek.push(AP);
					stek.push(B);
					stek.push(AND_T);
				}
				else if(preduvid == OR_T || preduvid == ')' || preduvid == '\n')
					stek.pop();
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case B:
				if(preduvid == NEG_T)
				{
					stek.pop();
					stek.push(B);
					stek.push(NEG_T);
				}
				else if(preduvid == '(' || preduvid == ID_T || preduvid == VAL_T)
				{
					stek.pop();
					stek.push(C);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case C:
				if(preduvid == '(')
				{
					stek.pop();
					stek.push(')');
					stek.push(I);
					stek.push('(');
				}
				else if(preduvid == ID_T)
				{
					stek.pop();
					stek.push(ID_T);
				}
				else if(preduvid == VAL_T)
				{
					stek.pop();
					stek.push(VAL_T);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			default:
				if(stek.top() == preduvid)
				{
					stek.pop();
					preduvid = yylex();
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
		}
	}
	
	if(preduvid == EOI)
		std::cout << "Program je sintaksno ispravan" << std::endl;
	else
		std::cout << "Program nije sintaksno ispravan - visak tokena na ulazu" << std::endl;
	
	exit(EXIT_SUCCESS);
}

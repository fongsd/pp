#include <iostream>
#include <stack>

#include "parser.tab.hpp"

#define EOI	0
#define P	1
#define NN	2
#define NNP 3
#define N	4
#define NP	5

extern int yylex();

std::stack<int> stek;

/*
P -> NN BYE_T \n	{ID_T}
	|BYE_T \n		{BYE_T}
NN -> N \n NNP		{ID_T}
NNP -> N \n NNP		{ID_T}
	|eps			{BYE_T}
N -> ID_T IZ_T NP	{ID_T}
NP -> BROJ_T		{BROJ_T}
	|ID_T			{ID_T}
*/

int main(int argc, char *argv[]) {
	int preduvid = yylex();
	stek.push(P);
	
	while(!stek.empty())
	{
		switch(stek.top())
		{
			case P:
				if(preduvid == ID_T)
				{
					stek.pop();
					stek.push('\n');
					stek.push(BYE_T);
					stek.push(NN);
				}
				else if(preduvid == BYE_T)
				{
					stek.pop();
					stek.push('\n');
					stek.push(BYE_T);
				}
				else
				{
					std::cout << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case NN:
				if(preduvid == ID_T)
				{
					stek.pop();
					stek.push(NNP);
					stek.push('\n');
					stek.push(N);
				}
				else
				{
					std::cout << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case NNP:
				if(preduvid == ID_T)
				{
					stek.pop();
					stek.push(NNP);
					stek.push('\n');
					stek.push(N);
				}
				else if(preduvid == BYE_T)
					stek.pop();
				else
				{
					std::cout << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case N:
				if(preduvid == ID_T)
				{
					stek.pop();
					stek.push(NP);
					stek.push(IZ_T);
					stek.push(ID_T);
				}
				else
				{
					std::cout << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case NP:
				if(preduvid == BROJ_T)
				{
					stek.pop();
					stek.push(BROJ_T);
				}
				else if(preduvid == ID_T)
				{
					stek.pop();
					stek.push(ID_T);
				}
				else
				{
					std::cout << "Sintaksna greska" << std::endl;
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
					std::cout << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
		}
	}
	
	if(preduvid == EOI)
		std::cout << "Izraz je sintaksno ispravan" << std::endl;
	else
		std::cout << "Sintaksna greska: visak tokena na ulazu" << std::endl;
	
	exit(EXIT_SUCCESS);
}

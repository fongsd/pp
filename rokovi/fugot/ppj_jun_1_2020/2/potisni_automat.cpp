/*
P -> N \n PP		{ID_T, UGAO_T, BROJ_T, (}
PP -> N \n PP		{ID_T, UGAO_T, BROJ_T, (}
	| eps			{EOI}
N -> ID_T R			{ID_T}
	| UGAO_T NP		{UGAO_T}
	| BROJ_T * I	{BROJ_T}
	| ( I )			{(}
R -> = I			{=}
	| NP			{+, -, *}
NP -> + I			{+}
	| - I			{-}
	| * BROJ_T NP	{*}
	| eps			{\n}
I -> A IP			{BROJ_T, ID_T, UGAO_T, (}
IP -> + A IP		{+}
	| - A IP		{-}
	| eps			{), \n}
A -> BROJ_T * B		{BROJ_T}
	| B Z			{(, ID_T, UGAO_T}
Z -> * BROJ_T		{*}
	| / BROJ_T		{/}
	| eps			{+, -, ), \n}
B -> ( I )			{(}
	| ID_T			{ID_T}
	| UGAO_T		{UGAO_T}
*/

#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <vector>
#include <stack>

#include "parser.tab.hpp"

extern int yylex();

#define EOI	0
#define P	1001
#define PP	1002
#define N	1003
#define NP	1004
#define I	1005
#define IP	1006
#define A	1007
#define Z	1008
#define B	1009
#define R	1010

int main(int argc, char *argv[]) {
	std::stack<int> stek;
	
	int preduvid = yylex();
	stek.push(P);
	
	while(!stek.empty())
	{
		std::cout << stek.top() << std::endl;
		switch(stek.top())
		{
			case P:
				if(preduvid == ID_T || preduvid == UGAO_T || preduvid == BROJ_T || preduvid == '(')
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
				if(preduvid == ID_T || preduvid == UGAO_T || preduvid == BROJ_T || preduvid == '(')
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
				else if(preduvid == UGAO_T)
				{
					stek.pop();
					stek.push(NP);
					stek.push(UGAO_T);
				}
				else if(preduvid == BROJ_T)
				{
					stek.pop();
					stek.push(I);
					stek.push('*');
					stek.push(BROJ_T);
				}
				else if(preduvid == '(')
				{
					stek.pop();
					stek.push(')');
					stek.push(I);
					stek.push('(');
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case R:
				if(preduvid == '=')
				{
					stek.pop();
					stek.push(I);
					stek.push('=');
				}
				else if(preduvid == '+' || preduvid == '-' || preduvid == '*')
				{
					stek.pop();
					stek.push(NP);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case NP:
				if(preduvid == '+')
				{
					stek.pop();
					stek.push(I);
					stek.push('+');
				}
				else if(preduvid == '-')
				{
					stek.pop();
					stek.push(I);
					stek.push('-');
				}
				else if(preduvid == '*')
				{
					stek.pop();
					stek.push(NP);
					stek.push(BROJ_T);
					stek.push('*');
				}
				else if(preduvid == '\n')
					stek.pop();
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case I:
				if(preduvid == BROJ_T || preduvid == ID_T || preduvid == UGAO_T || preduvid == '(')
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
				if(preduvid == '+')
				{
					stek.pop();
					stek.push(IP);
					stek.push(A);
					stek.push('+');
				}
				else if(preduvid == '-')
				{
					stek.pop();
					stek.push(IP);
					stek.push(A);
					stek.push('-');
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
				if(preduvid == BROJ_T)
				{
					stek.pop();
					stek.push(B);
					stek.push('*');
					stek.push(BROJ_T);
				}
				else if(preduvid == '(' || preduvid == ID_T || preduvid == UGAO_T)
				{
					stek.pop();
					stek.push(Z);
					stek.push(B);
				}
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case Z:
				if(preduvid == '*')
				{
					stek.pop();
					stek.push(BROJ_T);
					stek.push('*');
				}
				else if(preduvid == '/')
				{
					stek.pop();
					stek.push(BROJ_T);
					stek.push('/');
				}
				else if(preduvid == '+' || preduvid == '-' || preduvid == ')' || preduvid == '\n')
					stek.pop();
				else
				{
					std::cerr << "Sintaksna greska" << std::endl;
					exit(EXIT_FAILURE);
				}
				break;
			case B:
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
				else if(preduvid == UGAO_T)
				{
					stek.pop();
					stek.push(UGAO_T);
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
				break;
		}
	}
	
	if(preduvid == EOI)
		std::cout << "Program je sintaksno ispravan" << std::endl;
	else
		std::cout << "Program nije sintaksno ispravan" << std::endl;
	
	exit(EXIT_SUCCESS);
}

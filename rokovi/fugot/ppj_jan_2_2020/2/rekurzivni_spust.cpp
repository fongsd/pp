#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <cstring>
#include <map>

#include "parser.tab.hpp"

#define EOI	0

/*
P -> N ; PP		{ID_T}
PP -> N ; PP	{ID_T}
	| eps		{EOI}
N -> ID_T = I	{ID_T}
I -> A IP		{-, (, ID_T, CONST_T}
IP -> + A IP	{+}
	| - A IP	{-}
	| . A IP	{.}
	| eps		{), ;}
A -> B AP		{-, (, ID_T, CONST_T}
AP -> * B AP	{*}
	| / B AP	{/}
	| x B AP	{x}
	| eps		{+, -, ., ), ;}
B -> - B		{-}
	| C			{(, ID_T, CONST_T}
C -> ( I )		{(}
	| ID_T		{ID_T}
	| CONST_T	{CONST_T}
*/

extern int yylex();

int preduvid = 0;

void P();
void PP();
void N();
void I();
void IP();
void A();
void AP();
void B();
void C();

int main(int argc, char *argv[]) {
	preduvid = yylex();
	
	P();
	
	if(preduvid == EOI)
		std::cout << "Program je sintaksno ispravan" << std::endl;
	else
		std::cout << "Program nije sintaksno ispravan - visak tokena na ulazu" << std::endl;
	
	exit(EXIT_SUCCESS);
}

void P() {
	if(preduvid == ID_T)
	{
		N();
		if(preduvid != ';')
		{
			std::cerr << "Sintaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		PP();
	}
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void PP() {
	if(preduvid == ID_T)
	{
		N();
		if(preduvid != ';')
		{
			std::cerr << "Sintaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		PP();
	}
	else if(preduvid == EOI)
		return;
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void N() {
	if(preduvid == ID_T)
	{
		preduvid = yylex();
		if(preduvid != '=')
		{
			std::cerr << "Sintaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		I();
	}
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void I() {
	if(preduvid == '-' || preduvid == '(' || preduvid == ID_T || preduvid == CONST_T)
	{
		A();
		IP();
	}
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void IP() {
	if(preduvid == '+')
	{
		preduvid = yylex();
		A();
		IP();
	}
	else if(preduvid == '-')
	{
		preduvid = yylex();
		A();
		IP();
	}
	else if(preduvid == '.')
	{
		preduvid = yylex();
		A();
		IP();
	}
	else if(preduvid == ')' || preduvid == ';')
		return;
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void A() {
	if(preduvid == '-' || preduvid == '(' || preduvid == ID_T || preduvid == CONST_T)
	{
		B();
		AP();
	}
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void AP() {
	if(preduvid == '*')
	{
		preduvid = yylex();
		B();
		AP();
	}
	else if(preduvid == '/')
	{
		preduvid = yylex();
		B();
		AP();
	}
	else if(preduvid == 'x')
	{
		preduvid = yylex();
		B();
		AP();
	}
	else if(preduvid == '+' || preduvid == '-' || preduvid == '.' || preduvid == ')' || preduvid == ';')
		return;
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void B() {
	if(preduvid == '-')
	{
		preduvid = yylex();
		B();
	}
	else if(preduvid == '(' || preduvid == ID_T || preduvid == CONST_T)
		C();
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void C() {
	if(preduvid == '(')
	{
		preduvid = yylex();
		I();
		if(preduvid != ')')
		{
			std::cerr << "Sintaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
	}
	else if(preduvid == ID_T)
		preduvid = yylex();
	else if(preduvid == CONST_T)
		preduvid = yylex();
	else
	{
		std::cerr << "Sintaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

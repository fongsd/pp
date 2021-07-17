#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <map>
#include <string>

#include "parser.tab.hpp"

#define EOI 0

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
void E();

/*
P -> N ; PP								{DEF_T PRINT_T ID_T}
PP -> N ; PP							{DEF_T PRINT_T ID_T}
	| eps								{EOI}
N -> DEF_T ( ID_T , E , E , E , E )		{DEF_T}
	| PRINT_T ( ID_T )					{PRINT_T}
	| ID_T EQ_T I						{ID_T}
I -> A IP								{- ( ID_T}
IP -> + A IP							{+}
	| - A IP							{-}
	| eps								{) ; EOI}
A -> B AP								{- ( ID_T}
AP -> * B AP							{*}
	| / B AP							{/}
	| eps								{+ - ) ; EOI}
B -> - B								{-}
	| C									{( ID_T}
C -> ( I )								{(}
	| ID_T								{ID_T}
E -> ID_T : BROJ_T						{ID_T}
*/

int main(int argc, char *argv[]) {
	preduvid = yylex();
	
	P();
	
	if(preduvid == EOI)
		std::cout << "Program je sintaksno ispravan" << std::endl;
	else
		std::cout << "Program nije sintaksno ispravan" << std::endl;
	
	exit(EXIT_SUCCESS);
}

void P() {
	if(preduvid == DEF_T || preduvid == PRINT_T || preduvid == ID_T)
	{
		N();
		if(preduvid != ';')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		PP();
	}
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void PP() {
	if(preduvid == DEF_T || preduvid == PRINT_T || preduvid == ID_T)
	{
		N();
		if(preduvid != ';')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		PP();
	}
	else if(preduvid == EOI)
		return;
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void N() {
	if(preduvid == DEF_T)
	{
		preduvid = yylex();
		if(preduvid != '(')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		if(preduvid != ID_T)
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		if(preduvid != ',')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		E();
		if(preduvid != ',')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		E();
		if(preduvid != ',')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		E();
		if(preduvid != ',')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		E();
		if(preduvid != ')')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
	}
	else if(preduvid == PRINT_T)
	{
		preduvid = yylex();
		if(preduvid != '(')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		if(preduvid != ID_T)
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		if(preduvid != ')')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
	}
	else if(preduvid == ID_T)
	{
		preduvid = yylex();
		if(preduvid != EQ_T)
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		I();
	}
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void I() {
	if(preduvid == '-' || preduvid == '(' || preduvid == ID_T)
	{
		A();
		IP();
	}
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
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
	else if(preduvid == ')' || preduvid == ';' || preduvid == EOI)
		return;
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void A() {
	if(preduvid == '-' || preduvid == '(' || preduvid == ID_T)
	{
		B();
		AP();
	}
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
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
	else if(preduvid == '+' || preduvid == '-' || preduvid == ')' || preduvid == ';' || preduvid == EOI)
		return;
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void B() {
	if(preduvid == '-')
	{
		preduvid = yylex();
		B();
	}
	else if(preduvid == '(' || preduvid == ID_T)
		C();
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
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
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
	}
	else if(preduvid == ID_T)
		preduvid = yylex();
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void E() {
	if(preduvid == ID_T)
	{
		preduvid = yylex();
		if(preduvid != ':')
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		if(preduvid != BROJ_T)
		{
			std::cerr << "Sitnaksna greska" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
	}
	else
	{
		std::cerr << "Sitnaksna greska" << std::endl;
		exit(EXIT_FAILURE);
	}
}

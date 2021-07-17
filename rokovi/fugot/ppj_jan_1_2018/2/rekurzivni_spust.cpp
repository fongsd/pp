#include <iostream>
#include <vector>
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
void B();
void V();
void L();
void LP();
void broj();

int main(int argc, char *argv[]) {
	preduvid = yylex();
	
	P();
	
	if(preduvid == EOI)
		std::cout << "Da" << std::endl;
	else
		std::cout << "Ne" << std::endl;
	
	exit(EXIT_SUCCESS);
}

/*
P -> N ; PP				{ID_T PRINT_T}
PP -> N ; PP			{ID_T PRINT_T}
	| eps				{EOI}
N -> ID_T ASGN_T I		{ID_T}
	| PRINT_T ( I )		{PRINT_T}
I -> A IP				{BROJ_T - < ID_T}
IP -> + A IP			{+}
	| - A IP			{-}
	| eps				{) ;}
A -> broj * B			{BROJ_T -}
	| B					{< ID_T}
B -> V					{<}
	| ID_T				{ID_T}
V -> < L >				{<}
L -> broj LP			{BROJ_T -}
LP -> , broj LP			{,}
	| eps				{>}
broj -> BROJ_T			{BROJ_T}
	| - BROJ _T			{-}
*/

void P() {
	if(preduvid == ID_T || preduvid == PRINT_T)
	{
		N();
		if(preduvid == ';')
			preduvid = yylex();
		else
		{
			std::cout << "Ne" << std::endl;
			exit(EXIT_FAILURE);
		}
		PP();
	}
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void PP() {
	if(preduvid == ID_T || preduvid == PRINT_T)
	{
		N();
		if(preduvid == ';')
			preduvid = yylex();
		else
		{
			std::cout << "Ne" << std::endl;
			exit(EXIT_FAILURE);
		}
		PP();
	}
	else if(preduvid == EOI)
		return;
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void N() {
	if(preduvid == ID_T)
	{
		preduvid = yylex();
		if(preduvid == ASGN_T)
		{
			preduvid = yylex();
			I();
		}
		else
		{
			std::cout << "Ne" << std::endl;
			exit(EXIT_FAILURE);
		}
	}
	else if(preduvid == PRINT_T)
	{
		preduvid = yylex();
		if(preduvid != '(')
		{
			std::cout << "Ne" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		I();
		if(preduvid != ')')
		{
			std::cout << "Ne" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
	}
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void I() {
	if(preduvid == BROJ_T || preduvid == '<' || preduvid == '-' || preduvid == ID_T)
	{
		A();
		IP();
	}
	else
	{
		std::cout << "Ne" << std::endl;
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
	else if(preduvid == ')' || preduvid == ';')
		return;
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void A() {
	if(preduvid == BROJ_T || preduvid == '-')
	{
		broj();
		if(preduvid != '*')
		{
			std::cout << "Ne" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
		B();
	}
	else if(preduvid == '<' || preduvid == ID_T)
		B();
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void B() {
	if(preduvid == '<')
		V();
	else if(preduvid == ID_T)
		preduvid = yylex();
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void V() {
	if(preduvid == '<')
	{
		preduvid = yylex();
		L();
		if(preduvid != '>')
		{
			std::cout << "Ne" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
	}
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void L() {
	if(preduvid == BROJ_T || preduvid == '-')
	{
		broj();
		LP();
	}
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void LP() {
	if(preduvid == ',')
	{
		preduvid = yylex();
		broj();
		LP();
	}
	else if(preduvid == '>')
		return;
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void broj() {
	if(preduvid == BROJ_T)
		preduvid = yylex();
	else if(preduvid == '-')
	{
		preduvid = yylex();
		if(preduvid != BROJ_T)
		{
			std::cout << "Ne" << std::endl;
			exit(EXIT_FAILURE);
		}
		preduvid = yylex();
	}
	else
	{
		std::cout << "Ne" << std::endl;
		exit(EXIT_FAILURE);
	}
}

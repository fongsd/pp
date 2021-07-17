%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <math.h>

  /* duzina pomocne promenljive koja nam sluzi za pomocni upis */
  #define LENGTH 32

  /* Fja za obradu gresaka */
  void yyerror(char *str) {
    fprintf(stderr, "Pojavila se greska: %s\n", str);
    exit(EXIT_FAILURE);
  }
  /* Fju yylex za nas generise lex */
  extern int yylex();
%}

/* Unija koja predstvalja tip promenljive yylval
 * token num koga vraca leksicki analizator ima atribut v
 * a neterminal E ima kao atribut strukturu sa dve realne vrednosti.
 * koje predstavljaju realni i imaginarni deo kompleksnog broja */
%union {
  struct {
    double r;
    double c;
  } z;
  double v;
}
%token <v> num print real arg complex
%type <z> E

%left '+' '-'
%left '*' '/'
%left UMINUS

%%
/* Program je niz naredbi */
Program: Program Naredba
      | Naredba
      ;
/* Naredba moze biti nesto od sledecih 5 mogucnosti */
Naredba: print E ',' num ';'	{
				  /* Pisemo na izlaz kompleksni broj sa zadatom racnoscu */
				  char s[LENGTH];
				  sprintf(s, "%%.%df+", (int)$4);
				  if ($2.c<0)
				    s[strlen(s)-1] = '\0';
				  sprintf(s+strlen(s), "%%.%dfi\n",(int)$4);
				  printf(s, $2.r, $2.c);
				}
      | real E ';'		{
				  /* Izdvajamo realni deo kompleksnog broja */
				  printf("%f\n", $2.r);
				}
      | complex E ';'		{
				  /* Izdvajamo imaginarni deo kompleksnog broja */
				  printf("%f\n", $2.c);
				}
      | arg E ';'		{
				  /* Izdvajamo argument kompleksnog broja */
				  printf("%f\n", atan($2.c/$2.r)+($2.r<0?3.14:0));
				}
      | '|' E '|' ';'		{
 				  /* Izdvajamo moduo kompleksnog broja */
				  printf("%f\n", sqrt($2.r*$2.r + $2.c*$2.c));
				}
      ;
E : E '+' E			{
				  /* Racunamo zbir kompleksnih brojeva */
				  $$.r = $1.r + $3.r;
				  $$.c = $1.c + $3.c;
				}
  | E '-' E			{
				  /* Racunamo razliku kompleksnih brojeva */
				  $$.r = $1.r - $3.r;
				  $$.c = $1.c - $3.c;
				}
  | E '*' E			{
				  /* Racunamo proizvod kompleksnih brojeva */
				  $$.r = $1.r * $3.r - $1.c * $3.c;
				  $$.c = $1.r * $3.c + $1.c * $3.r;
				}
  | E '/' E			{
				  /* Racunamo kolicnik kompleksnih brojeva */
				  int x;
				  if ((x = $3.r * $3.r + $3.c * $3.c)==0)
				    yyerror("Deljenje nulom");
				  $$.r = ($1.r * $3.r + $1.c * $3.c) / x;
				  $$.c = (-$1.r * $3.c + $1.c * $3.r) / x;
				}
  | '(' E ')'			{ $$ = $2; }
  | '-' E	%prec UMINUS	{ $$.r = -$2.r; $$.c = -$2.c; }
  | '[' num ',' num ']'		{
				  /* Pravimo kompleksni broj na osnovu [num,num] */
				  $$.r = $2; $$.c = $4;
				}
  ;
%%
/* Glavna fja */
int main() {
  /* parsiramo ulaz */
  yyparse();
  /* Uspesno zavrsavamo program */
  return 0;
}


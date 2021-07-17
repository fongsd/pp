%{
  #include <stdio.h>
  #include <stdlib.h>
  /* Fja za obradu greska */
  void yyerror(char *str) {
    fprintf(stderr, "Pojavila se greska: %s\n", str);
    exit(EXIT_FAILURE);
  }
  /* Fju yylex za nas generise lex */
  extern int yylex();

  /* Fja koja racuna za dva cela broja najveci zajednicki delilac */
  int nzd(int x, int y) {
    int i = x<y?x:y;
    for (;;i--) {
      if (x%i==0 && y%i==0)
	return i;
    }
  }

%}
/* Unija koja predstvalja tip promenljive yylval
 * token num koga vraca leksicki analizator ima atribut v
 * a neterminal E ima kao atribut strukturu sa dve celobrojne vrednosti.
 * koje predstavljaju brojilac i imenilac razlomka */
%union {
  struct {
    int b;
    int i;
  } r;
  int v;
}
%token <v> num print1 print2 brojilac imenilac recip skratiti
%type <r> E

%left '+' '-'
%left '*' '/'
%left UMINUS

%%
/* Program je niz naredbi */
Program: Program Naredba
      | Naredba
      ;
/* Naredba moze biti nesto od sledecih 6 mogucnosti */
Naredba: print1 E ';'		{ 
				  /* stampamo razlomak, vodeci racuna o znacima */
				  if ($2.b * $2.i < 0)
				    putchar('-');
				  printf("%d/%d\n", abs($2.b), abs($2.i));
				}
      | print2 E ';'		{ 
				  /* stampamo decimalnu vrednost razlomka */
				  printf("%f\n", $2.b/(float)$2.i);
				}
      | brojilac E ';'		{
				  /* stampamo brojilac razlomka */
				  printf("%d\n", $2.b);
				}
      | imenilac E ';'		{
				  /* stampamo imenilac razlomka */
				  printf("%d\n", $2.i);
				}
      | recip E ';'		{
				  /* stampamo reciprocni razlomak, vodeci racuna o znacima */
				  if ($2.b * $2.i < 0)
				    putchar('-');
				  printf("%d/%d\n", abs($2.i), abs($2.b));
				}
      | skratiti E ';'		{
				  /* stampamo skracen razlomak */
				  int x = nzd(abs($2.b), abs($2.i));
				  if ($2.b * $2.i < 0)
				    putchar('-');
				  printf("%d/%d\n", abs($2.b)/x, abs($2.i)/x);
				}
      ;
E : E '+' E			{
				  /* Racunamo zbir dva razlomka */
				  if ($1.i == $3.i) {
				    $$.i = $1.i;
				    $$.b = $1.b + $3.b;
				  }
				  else {
				    $$.i = $1.i * $3.i;
				    $$.b = $1.b * $3.i + $3.b * $1.i;
				  }
				}
  | E '-' E			{
				  /* Racunamo razliku dva razlomka */
				  if ($1.i == $3.i) {
				    $$.i = $1.i;
				    $$.b = $1.b - $3.b;
				  }
				  else {
				    $$.i = $1.i * $3.i;
				    $$.b = $1.b * $3.i - $3.b * $1.i;
				  }
				}
  | E '*' E			{
				  /* Racunamo proizvod dva razlomka */
				  $$.b = $1.b * $3.b; $$.i = $1.i * $3.i;
				}
  | E '/' E			{
				  /* Racunamo kolicnik dva razlomka */
				  if ($3.b==0)
				    yyerror("Deljenje nulom");
				  $$.b = $1.b * $3.i; $$.i = $1.i * $3.b;
				}
  | '(' E ')'			{ $$ = $2; }
  | '-' E	%prec UMINUS	{ $$.b = -$2.b; }
  | '[' num ',' num ']'		{
				  /* na osnovu [num,num] pravimo razlomak */
				  $$.b = $2;
				  if (!($$.i = $4))
				    yyerror("Imenilac ne sme biti nula");
				}
  ;
%%
/* main fja */
int main() {
  /* parsiramo ulaz */
  yyparse();
  /* uspesno zavrsavamo program */
  return 0;
}


%{
  #include <stdio.h>
  #include <stdlib.h>

  /* Fja za obradu greska */
  void yyerror(char *str) {
    fprintf(stderr, "Pojavila se greska: %s\n", str);
    exit(EXIT_FAILURE);
  }
  /* Fju yylex generise lex */
  extern int yylex();

%}

/* Unija koja predstvalja tip promenljive yylval
 * token slovo koga vraca leksicki analizator ima atribut c
 * a neterminali Lista i E imaju kao atribut niz duzime 26.
 * Ovaj staticki niz sadrzi 0 ili 1 na i-tom mestu, ako se
 * karakter 'a' + i ne nalazi, tl. nalazi u skupu */
%union {
  char c;
  int skup[26];
}

%token <c> slovo print complement number isinset
%type <skup> E Lista

%left unija
%left presek '\\'

%%
/* Program je niz naredbi */
Program: Program Naredba
      | Naredba
      ;
/* naredbe mogu biti sledece cetiri */
Naredba: print E ';'		{
				  /* Ako se slovo nalazi u skupu koga predstavljamo
				   * pomocu $2 stampamo ga, imace nista */
				  int i;
				  for (i=0; i<='z'-'a'; i++)
				    if ($2[i] == 1)
				      printf("%c ", i+'a');
				  putchar('\n');
				}
      | complement E ';'	{
				  /* Ako se slovo ne nalazi u skupu koga predstavljamo
				   * pomocu $2 stampamo ga, imace nista */
				  int i;
				  for (i=0; i<='z'-'a'; i++)
				    if ($2[i] == 0)
				      printf("%c ", i+'a');
				  putchar('\n');
				}
      | number E ';'		{
				  /* Brojimo koliko imamo elemenata u skupu, tj.
				   * koliko imamo jedinica u nizu $2 */
				  int i, j = 0;
				  for (i=0; i<='z'-'a'; i++)
				    if ($2[i] == 1)
				      j++;
				  printf("%d\n", j);
				}
      | isinset E ',' slovo ';'	{
				  /* Proveravamo da li se slovo nalazi u skupu */
				  if ($2[$4-'a']==1)
				    printf("yes\n");
				  else
				    printf("no\n");
				}
      ;
E : E unija E			{
				  /* Pravimo skup koji je unija prethodna dva
				   * tj. na osnovu nizova $1 i $3 pravimo niz $$ */
				  int i;
				  for (i=0; i<='z'-'a'; i++)
				    if ($1[i] == 1 || $3[i] == 1)
				      $$[i] = 1;
				}
  | E presek E			{
				  /* Pravimo skup koji je presek prethodna dva
				   * tj. na osnovu nizova $1 i $3 pravimo niz $$ */
				  int i;
				  for (i=0; i<='z'-'a'; i++)
				    if ($1[i] == 1 && $3[i] == 1)
				      $$[i] = 1;
				    else
				      $$[i] = 0;
				}
  | E '\\' E			{
				  /* Pravimo skup koji je razlika prethodna dva
				   * tj. na osnovu nizova $1 i $3 pravimo niz $$ */
				  int i;
				  for (i=0; i<='z'-'a'; i++)
				    if ($1[i] == 1 )
				      $$[i] = 1;
				  for (i=0; i<='z'-'a'; i++)
				    if ($3[i] == 1 )
				      $$[i] = 0;
				}
  | '{' Lista '}'		{
				  /* Niz kojim predstavljamo skup koji reprezentuje listu
				   * prepisujemo u niz koji reprezentuje E */
				  int i;
				  for (i=0; i<='z'-'a'; i++)
				    if ($2[i] == 1 )
				      $$[i] = 1;
				}
  | '{' '}'			{
				  /* E dobija kao atribut prazan niz,
				   * ali posto je niz globalna promenljiva,
				   * on ce vec imati sve nule u sebi */
				}
  ;
Lista : slovo ',' Lista		{
				  /* Prepisujemo niz koji reprezentuje desnu listu
				   * u niz koji reprezentuje levu listu */
				  int i;
				  for (i=0; i<='z'-'a'; i++)
				    if ($3[i] == 1 )
				      $$[i] = 1;
				  /* i njemu dodajemo slovo sa desne strane */
				  $$[$1-'a'] = 1;
				}
      | slovo			{
				  /* postavljamo niz koji reprezentuje listu sa leve na niz koji sadrzi samo jednu jedinicu*/
				  $$[$1-'a'] = 1;
				}
      ;
%%
/* main fja */
int main() {
  /* radimo parsiranje ulaza */
  yyparse();
  /* uspesno zavrsavamo program */
  return 0;
}


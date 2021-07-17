#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

void greska(char *s)
{
    printf("%s\n", s);
    exit(EXIT_FAILURE);
}


int main(){

    // Dohvatanje broja za sledeceg korisnika

    // printf("bug in %d\n", __LINE__);
    FILE *ulaz  = fopen("brojac_korisnika.txt", "r+");

    if (ulaz == NULL)
    {
        greska("fajl ne postoji ili je greska nastala prilikom otvaranja");
    }

    // size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream);
    char *ispitanik = malloc(sizeof(char) * 1000);
    int fd = open("brojac_korisnika.txt", O_RDWR);

    if (-1 == read(fd, ispitanik, sizeof(ispitanik)))
    {
        greska("failed to read file");
    }
    if (0 != ftruncate(fd, 0))
    {
        greska("truncate failed");
    }
    int br_ispitanika = atoi(ispitanik);
    char *naziv_fajla = malloc(sizeof(char) * 100);
    sprintf(naziv_fajla, "%d", br_ispitanika);
    // printf("%s.txt\n", naziv_fajla);
    // printf("%s\n", ispitanik);
    br_ispitanika +=1;
    fprintf(ulaz, "%d", br_ispitanika);
    // printf("%s\n", ispitanik);


    // KREIRANJE FAJLA ZA KORISNIKA I OTVARANJE

    FILE *korisnik = fopen(naziv_fajla, "w");

    if (korisnik == NULL)
    {
        greska("failed to create specified customer's file");
    }
    FILE *pitanja = fopen("pitanja.txt", "r");

    if (pitanja == NULL)
    {
        greska("pitanja failed");
    }
    ssize_t broj_procitanih;
    char *c = malloc(sizeof(char) * 5000);
    size_t len = 0;

    fprintf(korisnik, "Broj godina: \n\n");
    fprintf(korisnik, "Pol: \n\n");
    fprintf(korisnik, "Duzina treniranja: \n\n");

    while ((broj_procitanih = getline(&c , &len, pitanja)) != -1)
    {
        fprintf(korisnik, "%s\n", c);
    }


    char *cmd = malloc(sizeof(char) * 100);
    cmd = "code ";
    // printf("%s\n", cmd);
    // strcat(cmd, ispitanik);
    // system(cmd);
    char *cmd_fajl = malloc(sizeof(char) * 100);

    sprintf(cmd_fajl, "%s%s\n", cmd, ispitanik);
    printf("%s", cmd_fajl);
    system(cmd_fajl);
    return 0;
}
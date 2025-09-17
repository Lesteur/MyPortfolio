#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "f_sdl.h"

int VICTOIRE = 0; //utilisée pour la fin de la partie

typedef struct {
    // Lignes et colonnes de la grille
    int ** puzzle;
    // Taille de la grille
    int taille;
    // Cordonnées de la case vide
    int vide_y;
    int vide_x;
} Taquin;

int ** CreerTab(int n);
Taquin * ImportTaquin(FILE * file);
Taquin * CreerTaquin(int n);
void FreeTaquin(Taquin * puzzle);
void BougeTaquin(Taquin * puzzle, char touche);
void InitTaquin(Taquin * puzzle, int iter);
int VerifTab(Taquin * taquin);
bool AfficherTaquin(Taquin* taquin, SDL_Renderer * renderer, TTF_Font * font);

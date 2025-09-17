#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "f_sdl.h"
#include <errno.h>
#include <time.h>
#include <unistd.h>

// Couleur rouge pour le terminal
#define PRINT_COLOR_RED "\x1b[31m"
// Couleur jaune pour le terminal
#define PRINT_COLOR_YELLOW "\x1b[33m"

#define PRINT_COLOR_GREEN "\x1b[32m"

// Couleur par défaut pour le terminal
#define PRINT_COLOR_RESET "\x1b[0m"

// Variable globale
extern bool g_Victoire;

typedef struct {
    // Lignes et colonnes de la grille
    int ** puzzle;
    // Taille de la grille
    int taille;
    // Cordonnées de la case vide
    int vide_y;
    int vide_x;
} Taquin;

typedef enum {
    HAUT,
    BAS,
    GAUCHE,
    DROITE
} TaquinMouvement;

int ** CreerTab(int n);
Taquin * ImportTaquin(FILE * file);
Taquin * CreerTaquin(int n);
Taquin * CreerTaquinVide(int n);
void FreeTaquin(Taquin * puzzle);
void BougeTaquin(Taquin * puzzle, TaquinMouvement touche);
void InitTaquin(Taquin * puzzle, int iter);
void AfficheTab(Taquin * taquin);
void AfficherTaquinTextuel(Taquin * taquin);
bool VerifTab(Taquin * taquin);
bool AfficherTaquin(Taquin* taquin, SDL_Renderer * renderer, TTF_Font * font);
bool AfficherImage(Taquin* taquin, SDL_Surface * image, SDL_Renderer * renderer);

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

// Couleur rouge pour le terminal
#define PRINT_COLOR_RED    "\x1b[31m"        
// Couleur jaune pour le terminal
#define PRINT_COLOR_YELLOW "\x1b[33m"
// Couleur par défaut pour le terminal
#define PRINT_COLOR_RESET  "\x1b[0m"

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
bool VerifTab(Taquin * taquin);

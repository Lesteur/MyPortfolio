#include "f_taquin.h"

int ** CreerTab(int n) {
    int ** tab = malloc(sizeof(int*) * n);
    for (int i = 0; i < n; i++) {
        tab[i] = malloc(sizeof(int) * n);
        for (int j = 0; j < n; j++) {
            tab[i][j] = i*n+j + 1;
        }
    }
    tab[n-1][n-1] = 0;
    return tab;
}

bool ContientValeur(Taquin * taquin, int valeur) {
    for (int i = 0; i < taquin->taille; i++) {
        for (int j = 0; j < taquin->taille; j++) {
            if (taquin->puzzle[i][j] == valeur) {
                return true;
            }
        }
    }
    return false;
}

Taquin * ImportTaquin(FILE * file) {
    int n;
    fscanf(file, "%d", &n);

    Taquin * taquin = CreerTaquinVide(n);
    if (taquin == NULL) {
        return NULL;
    }

    int val_saisie = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            fscanf(file, "%d", &val_saisie);
            if (!ContientValeur(taquin, val_saisie)) {
                taquin->puzzle[i][j] = val_saisie;
            } else if (i != n-1 && j != n-1) {
                // Taquin invalide
                FreeTaquin(taquin);
                fclose(file);
                return NULL;
            }
        }
    }

    fclose(file);
    return taquin;
}

Taquin * CreerTaquin(int n) {
    Taquin * taquin = malloc(sizeof(Taquin));
    if (taquin == NULL) {
        return NULL;
    }

    taquin->puzzle = CreerTab(n);
    taquin->taille = n;
    // La case vide commence au coin inférieur droit
    taquin->vide_y = n - 1;
    taquin->vide_x = n - 1;

    return taquin;
}

Taquin * CreerTaquinVide(int n) {
    Taquin * taquin = malloc(sizeof(Taquin));
    if (taquin == NULL) {
        return NULL;
    }

    taquin->puzzle = malloc(sizeof(int*) * n);
    for (int i = 0; i < n; i++) {
        taquin->puzzle[i] = calloc(n, sizeof(int));
    }

    taquin->taille = n;
    // La case vide commence au coin inférieur droit
    taquin->vide_y = n - 1;
    taquin->vide_x = n - 1;

    return taquin;
}

void FreeTaquin(Taquin * puzzle) {
    if (puzzle == NULL) return;

    for (int i = 0; i < puzzle->taille; i++) {
        free(puzzle->puzzle[i]);
    }
    free(puzzle->puzzle);
    free(puzzle);
}

void BougeTaquin(Taquin * puzzle, TaquinMouvement touche) {
  int ** tab = puzzle->puzzle;
  int i = puzzle->vide_y;
  int j = puzzle->vide_x;
  int n = puzzle->taille;

  switch (touche) {
    case GAUCHE:
        if (j != 0) {
            tab[i][j] = tab[i][j-1];
            tab[i][j-1] = 0;
            puzzle->vide_x = j-1;
        }
        break;
    case DROITE:
        if (j != n-1) {
            tab[i][j] = tab[i][j+1];
            tab[i][j+1] = 0;
            puzzle->vide_x = j+1;
        }
        break;
    case HAUT:
        if (i != 0) {
            tab[i][j] = tab[i-1][j];
            tab[i-1][j] = 0;
            puzzle->vide_y = i-1;
        }
        break;
    case BAS:
        if (i != n-1) {
            tab[i][j] = tab[i+1][j];
            tab[i+1][j] = 0;
            puzzle->vide_y = i+1;
        }
        break;
    }
}

void InitTaquin(Taquin * puzzle, int iter) {
    for (int i = 0; i < iter; i++) {
        BougeTaquin(puzzle, rand() % 4);
    }

    int n = puzzle->taille - puzzle->vide_x - 1;
    for (int i = 0; i < n; i++) {
        BougeTaquin(puzzle, DROITE);
    }

    n = puzzle->taille - puzzle->vide_y - 1;
    for (int j = 0; j < n; j++) {
        BougeTaquin(puzzle, BAS);
    }
}

bool VerifTab(Taquin * taquin) {
    int ** tab = taquin->puzzle;
    int n = taquin->taille;
    int indice = 1;

    if (tab[n-1][n-1] != 0) {
        return false;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if ((tab[i][j] != indice) && ((i != n-1) || (j != n-1))) {
                return false;
            }
            indice++;
        }
    }

    return true;
}

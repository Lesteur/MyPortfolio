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

Taquin * ImportTaquin(FILE * file) {
    int n;
    Taquin * puzzle = malloc(sizeof(Taquin));
    fscanf(file, "%d", &n);
    puzzle->taille = n;
    int ** tab = malloc(sizeof(int*) * n);
    for (int i = 0; i < n; i++) {
        tab[i] = malloc(sizeof(int) * n);
        for (int j = 0; j < n; j++) {
            fscanf(file, "%d", &tab[i][j]);
        }
    }
    tab[n-1][n-1] = 0;
    puzzle->puzzle = tab;
    puzzle->vide_y = n - 1;
    puzzle->vide_x = n - 1;
    fclose(file);
    return puzzle;
}

Taquin * CreerTaquin(int n) {
    Taquin * puzzle = malloc(sizeof(Taquin));
    puzzle->puzzle = CreerTab(n);
    puzzle->taille = n;
    // La case vide commence au coin inférieur droit
    puzzle->vide_y = n - 1;
    puzzle->vide_x = n - 1;
    return puzzle;
}

void FreeTaquin(Taquin * puzzle) {
    for (int i = 0; i < puzzle->taille; i++) {
        free(puzzle->puzzle[i]);
    }
    free(puzzle->puzzle);
    free(puzzle);
}

void BougeTaquin(Taquin * puzzle, char touche) {
  int ** tab = puzzle->puzzle;
  int i = puzzle->vide_y;
  int j = puzzle->vide_x;
  int n = puzzle->taille;

  switch (touche) {
    case 'g':
        if (j != 0) {
            tab[i][j] = tab[i][j-1];
            tab[i][j-1] = 0;
            puzzle->vide_x = j-1;
        }
        break;
    case 'd':
        if (j != n-1) {
            tab[i][j] = tab[i][j+1];
            tab[i][j+1] = 0;
            puzzle->vide_x = j+1;
        }
        break;
    case 'h':
        if (i != 0) {
            tab[i][j] = tab[i-1][j];
            tab[i-1][j] = 0;
            puzzle->vide_y = i-1;
        }
        break;
    case 'b':
        if (i != n-1) {
            tab[i][j] = tab[i+1][j];
            tab[i+1][j] = 0;
            puzzle->vide_y = i+1;
        }
        break;
    }
}

void InitTaquin(Taquin * puzzle, int iter) {
    int nb, n;
    for (int i = 0; i < iter; i++) {
        nb = rand() % 4;
        switch (nb) {
            case 0:
                BougeTaquin(puzzle, 'g');
                break;
            case 1:
                BougeTaquin(puzzle, 'd');
                break;
            case 2:
                BougeTaquin(puzzle, 'h');
                break;
            case 3:
                BougeTaquin(puzzle, 'b');
                break;
        }
    }

    n = puzzle->taille - puzzle->vide_x - 1;
    for (int i = 0; i < n; i++) {
        BougeTaquin(puzzle, 'd');
    }

    n = puzzle->taille - puzzle->vide_y - 1;
    for (int j = 0; j < n; j++) {
        BougeTaquin(puzzle, 'b');
    }
}

int VerifTab(Taquin * taquin) {
    int ** tab = taquin->puzzle;
    int n = taquin->taille;
    int indice = 1;

    if (tab[n-1][n-1] != 0) {
        return -1;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if ((tab[i][j] != indice) && ((i != n-1) || (j != n-1))) {
                return -1;
            }
            indice++;
        }
    }

    return 0;
}

bool AfficherTaquin(Taquin* taquin, SDL_Renderer * renderer, TTF_Font * font) {
    SDL_Color WHITE = {255, 255, 255, 255};
    SDL_Color RED = {255, 0, 0, 255};
    SDL_Color GREEN = {0,255,0,255};

    // Itère à travers toute les cases de la grille de jeu
    for (int i = 0; i < taquin->taille; i++) {
        for (int j = 0; j < taquin->taille; j++) {
            // On considère qu'on aura pas de case avec des nombres qui ont plus de 3 chiffres
            char str[3];
            int align = 0;
            // Converti la valeur de la case actuelle en entier
            sprintf(str, "%d", taquin->puzzle[i][j]);

            SDL_Surface * surf;
            if (i == taquin->vide_y && j == taquin->vide_x) {
                surf = CreerTexte(font, str, RED);
            } else {
                if (VICTOIRE == 1) {
                    surf = CreerTexte(font, str, GREEN);
                   //rempli en vert le nombre
                }
                else {
                    surf = CreerTexte(font, str, WHITE);
                }
            }

            if (surf == NULL) {
                return false;
            }

            SDL_Texture * text = CreerTexture(renderer, surf);
            if (text == NULL) {
                return false;
            }

            SDL_Rect rect;
            rect.w = surf->w;
            rect.h = surf->h;

            if (taquin->puzzle[i][j] < 10)
            {
                align = 14;
            }
            rect.x = 80*j + 15 + align;
            rect.y = 80*i + 15;

            SDL_RenderCopy(renderer, text, NULL, &rect);

            SDL_FreeSurface(surf);
            SDL_DestroyTexture(text);

            if (VICTOIRE == 1) {
                SDL_Delay(500);
                SDL_RenderPresent(renderer);
            }
        }

    }

    SDL_RenderPresent(renderer);
    return true;
};

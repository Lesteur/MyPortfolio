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

bool ContientValeur(Taquin * taquin, int l_max,int c_max,int valeur) {
    /*
    **l_max = ligne maximale à atteindre;
    **c_max = colonne maximale à atteindre
    **taille = taille du tableau
    **elm = l'élément recherché
    ** false = l'élément n'est pas dans le puzzle
    ** true = élément dans puzzle
    **
    */
    int taille = taquin->taille;
    int nb_elem = taille;
    for (int i = 0;i<=l_max;i++) {
        if (i == l_max) nb_elem = c_max; //colonne max pour la ligne max
        for (int j = 0;j<nb_elem;j++) {
		if (taquin->puzzle[i][j] == valeur) {
		    printf("Présence de l'élément %d en %d|%d\n", valeur,i,j);
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
             if ((val_saisie >= n*n) || (val_saisie < 0) || ContientValeur(taquin,i,j,val_saisie) ) {
                 printf("Valeur %d invalide  \n",val_saisie);
                FreeTaquin(taquin);
                fclose(file);
                return NULL;

             }
             else {
                taquin->puzzle[i][j] = val_saisie;}
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

void AfficheTab(Taquin * taquin)
{
    int n = taquin->taille;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", taquin->puzzle[i][j]);
        }
        printf("\n");
    }
}

void AfficherTaquinTextuel(Taquin * taquin)
{
  int nb;
  int n = taquin->taille;
  printf("Utilisez les touches suivantes pour résoudre le taquin :\ng (gauche)\nd (droite)\nh (haut)\nb (bas)\n");
  printf("+");
  for (int j = 0; j < n; j++)
      printf("---+");
  printf("\n");
  for (int i = 0; i < n; i++)
  {
    printf("|");
    for (int j = 0; j < n; j++)
    {
      nb = taquin->puzzle[i][j];
      if (nb >= 10)
        printf("%d |", nb);
      else if (nb == 0)
        printf("   |");
      else
        printf("%d  |", nb);
    }
    printf("\n+");
    for (int j = 0; j < n; j++)
      printf("---+");
    printf("\n");
  }
}

bool AfficherTaquin(Taquin * taquin, SDL_Renderer * renderer, TTF_Font * font) {
    SDL_Color WHITE = {255, 255, 255, 255};
    SDL_Color RED = {255, 0, 0, 255};
    SDL_Color GREEN = {0, 255, 0, 255};

    // Itère à travers toute les cases de la grille de jeu
    for (int i = 0; i < taquin->taille; i++) {
        for (int j = 0; j < taquin->taille; j++) {
            // On considère qu'on aura pas de case avec des nombres qui ont plus de 3 chiffres
            char str[3];
            int align = 0;
            // Converti la valeur de la case actuelle en entier
            sprintf(str, "%d", taquin->puzzle[i][j]);

            SDL_Surface * surf;
            if (g_Victoire) {
                // Colorie le nombre en vert
                surf = CreerTexte(font, str, GREEN);
            } else if (i == taquin->vide_y && j == taquin->vide_x) {
                surf = CreerTexte(font, str, RED);
            } else {
                surf = CreerTexte(font, str, WHITE);
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

            if (taquin->puzzle[i][j] < 10) {
                align = 14;
            }
            rect.x = 80*j + 15 + align;
            rect.y = 80*i + 15;

            SDL_RenderCopy(renderer, text, NULL, &rect);

            SDL_FreeSurface(surf);
            SDL_DestroyTexture(text);

            if (g_Victoire) {
                SDL_RenderPresent(renderer);
                SDL_Delay(500);
            }
        }
    }

    SDL_RenderPresent(renderer);
    return true;
}

bool AfficherImage(Taquin * taquin, SDL_Surface * image, SDL_Renderer * renderer) {

    int n = taquin->taille;
    // Itère à travers toute les cases de la grille de jeu
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
        
            SDL_Rect rect;
            rect.w = image->w / n;
            rect.h = image->w / n;
            
            rect.x = ((taquin->puzzle[i][j]-1) % n) * rect.w;
            rect.y = ((taquin->puzzle[i][j]-1) / n) * rect.h;
            
            if (g_Victoire && i == n-1 && j == n-1)
            {
            	rect.x = (n-1) * rect.w;
            	rect.y = (n-1) * rect.h;
            }

            SDL_Surface * surf = NULL;
            
            surf = SDL_CreateRGBSurface(0, rect.w, rect.h, 32, 0, 0, 0, 0);
            SDL_BlitSurface(image, &rect, surf, NULL);

            if (surf == NULL) {
                return false;
            }

            SDL_Texture * text = CreerTexture(renderer, surf);
            if (text == NULL) {
                return false;
            }
            
            rect.x = rect.w*j;
            rect.y = rect.h*i;

            SDL_RenderCopy(renderer, text, NULL, &rect);

            SDL_FreeSurface(surf);
            SDL_DestroyTexture(text);

            if (g_Victoire) {
                SDL_RenderPresent(renderer);
                SDL_Delay(500);
            }
        }
    }

    SDL_RenderPresent(renderer);
    return true;
}

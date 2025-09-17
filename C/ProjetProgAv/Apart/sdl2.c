#include <stdio.h>
#include <stdlib.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include <time.h>
#include <stdbool.h>

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

int error = 0;

SDL_Window * CreerFenetre(char * title, int width, int height) {
    SDL_Window * window = SDL_CreateWindow(title, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, width, height, SDL_WINDOW_RESIZABLE);
    if (window == NULL) {
        fprintf(stderr, "Création de la fenêtre échouée : %s\n", SDL_GetError());
        error = 1;
    }
    return window;
}

SDL_Renderer * CreerRendu(SDL_Window * window) {
    SDL_Renderer * rendu = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (rendu == NULL) {
        fprintf(stderr, "Erreur lors de la création du rendu : %s\n", SDL_GetError());
        error = 1;
    }
    return rendu;
}

void SDL_InitAll() {
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        fprintf(stderr, "Erreur lors de l'initialisation de SDL : %s\n", SDL_GetError());
        SDL_Quit();
        exit(EXIT_FAILURE);
    }
    if (TTF_Init() != 0) {
        fprintf(stderr, "Erreur lors de l'initialisation de SDL_ttf : %s\n", TTF_GetError());
        SDL_Quit();
        exit(EXIT_FAILURE);
    }
}

SDL_Surface * CreerTexte(TTF_Font * font, char * str, SDL_Color textColor) {
    SDL_Surface * textSurface = TTF_RenderText_Blended(font, str, textColor);
    if (textSurface == NULL) {
        fprintf(stderr, "Erreur lors de la création de la surface de texte : %s\n", TTF_GetError());
        error = 1;
    }
    return textSurface;
}

SDL_Texture * CreerTexture(SDL_Renderer * renderer, SDL_Surface * surface) {
    SDL_Texture * textTexture = SDL_CreateTextureFromSurface(renderer, surface);
    if (textTexture == NULL) {
        fprintf(stderr, "Erreur lors de la création de la surface de texte : %s\n", TTF_GetError());
        error = 1;
    }
    return textTexture;
}

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
}

int main(int argc, char ** argv) {
    int n = 4;
    int menu = 1;
    int rep = 0;
    char str_file[30];
    Taquin * taquin;
    if (argc == 2 && atoi(argv[1]) >= 2) {
        n = atoi(argv[1]);
    }
    srand(time(NULL));
    SDL_InitAll();
    system("clear");

    while (menu != 0)
    {
        FILE * file;
        printf("Quel taquin voulez-vous faire ?\n\n1) Un aléatoire \n2) Un importé d'un fichier\n");
        scanf("%d", &rep);
        switch(rep)
        {
            case 1:
                menu = 0;
                taquin = CreerTaquin(n);
                InitTaquin(taquin, 100);
                break;
            case 2:
                printf("Entrez le nom du fichier : ");
                scanf("%s", str_file);
                file = fopen(str_file, "r");
                if (file != NULL)
                {
                    menu = 0;
                    taquin = ImportTaquin(file);
                } else {
                    system("clear");
                    printf("Ce fichier est inexistant.\n\n");
                    //SDL_Delay(1000);
                }
                break;
        }
    }

    SDL_Window * window = CreerFenetre("Taquin", 80*n, 80*n);
    if (!window) {
        return 1;
    }

    SDL_Renderer * renderer = CreerRendu(window);
    if (!renderer) {
        return 1;
    }

    SDL_Event event;
    TTF_Font * font = TTF_OpenFont("police.ttf", 40);
    //Taquin * taquin = CreerTaquin(n);
    //InitTaquin(taquin, 100);

    if (!AfficherTaquin(taquin, renderer, font)) {
        return 1;
    }

    while (true) {
        SDL_WaitEvent(&event);

        switch(event.type) {
            case SDL_WINDOWEVENT:
                if (event.window.event == SDL_WINDOWEVENT_CLOSE) {
                    goto end;
                }
                break;
            break;
        }

        switch(event.type) {
            case SDL_WINDOWEVENT:
                if (event.window.event == SDL_WINDOWEVENT_CLOSE) {
                    goto end;
                }
                break;
            case SDL_KEYUP:
                SDL_RenderClear(renderer);

                switch (event.key.keysym.sym) {
                    case SDLK_UP:
                        BougeTaquin(taquin, 'h');
                        break;
                    case SDLK_DOWN:
                        BougeTaquin(taquin, 'b');
                        break;
                    case SDLK_LEFT:
                        BougeTaquin(taquin, 'g');
                        break;
                    case SDLK_RIGHT:
                        BougeTaquin(taquin, 'd');
                        break;
                    case 'q':
                        goto end;
                }

                if (VerifTab(taquin) == 0) {
                    VICTOIRE = 1; //variable globale modfiée pour la fonction 
                                //AfficherTaquin
                                //afin de remlir en vert chaque n° du puzzle
                }

                AfficherTaquin(taquin, renderer, font);

                if (VICTOIRE == 1) {
                    goto end;
                }
            break;
        }
    }
 end:
    // Libérer les ressources
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    FreeTaquin(taquin);
    return 0;
}

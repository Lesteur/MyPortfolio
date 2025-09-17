#include "f_taquin.h"
#include "f_sdl.h"

// Utilisé pour la fin de partie
bool g_Victoire = false;

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

int main(int argc, char ** argv) {
    Taquin * taquin;

    int n = 4;
    if (argc == 2 && atoi(argv[1]) >= 2) {
        n = atoi(argv[1]);
    }

    srand(time(NULL));
    SDL_InitAll();
    
    system("clear");

    int menu = 1;
    while (menu != 0) {
        char rep;

        printf("Quel taquin voulez-vous faire ?\n\n1) Un aléatoire \n2) Un importé d'un fichier\n3) Quitter\n");
        scanf("%c", &rep);

        switch(rep) {
            case '1': {
                menu = 0;
                taquin = CreerTaquin(n);
                InitTaquin(taquin, 100);
                break;
            }
            case '2': {
                printf("Entrez le nom du fichier : ");

                char str_file[30];
                scanf("%s", str_file);

                FILE * file = fopen(str_file, "r");
                if (file != NULL) {
                    taquin = ImportTaquin(file);
                    if (taquin == NULL) {
                        printf(PRINT_COLOR_RED"Fichier invalide selon le modèle donné...\n"PRINT_COLOR_RESET);
                        break;
                    }
                    menu = 0;
                } else {
                    system("clear");
                    printf(PRINT_COLOR_RED"Ce fichier est inexistant ou invalide.\n\n"PRINT_COLOR_RESET);
                }
                break;
            }
            default: {
                free(taquin); // on libère le taquin
                SDL_Quit(); //on quitte la sdl
                printf(PRINT_COLOR_RED"Arrêt du programme via l'option '3'\n"PRINT_COLOR_RESET);
                exit(EXIT_SUCCESS); // on arrête la fonction principale
                break;
            }
        }
    }

    SDL_Window * window = CreerFenetre("Taquin", 80*n, 80*n);
    if (!window) {
        exit(EXIT_FAILURE);
    }

    SDL_Renderer * renderer = CreerRendu(window);
    if (!renderer) {
        exit(EXIT_FAILURE);
    }

    SDL_Event event;
    TTF_Font * font = TTF_OpenFont("police.ttf", 40);

    if (!AfficherTaquin(taquin, renderer, font)) {
        // goto end?
        return 1;
    }

    while (true) {
        SDL_WaitEvent(&event);

        switch(event.type) {
            case SDL_WINDOWEVENT:
                if (event.window.event == SDL_WINDOWEVENT_CLOSE) {
                    printf(PRINT_COLOR_RED"Arrêt du programme via fermeture manuelle\n"PRINT_COLOR_RESET);
                    goto end;
                }
                break;
            case SDL_KEYUP:
                SDL_RenderClear(renderer);

                switch (event.key.keysym.sym) {
                    case SDLK_UP:
                        BougeTaquin(taquin, HAUT);
                        break;
                    case SDLK_DOWN:
                        BougeTaquin(taquin, BAS);
                        break;
                    case SDLK_LEFT:
                        BougeTaquin(taquin, GAUCHE);
                        break;
                    case SDLK_RIGHT:
                        BougeTaquin(taquin, DROITE);
                        break;
                    case 'q':
                        printf(PRINT_COLOR_RED"Arrêt du programme via la touche 'q'\n"PRINT_COLOR_RESET);
                        goto end;
                }

                if (VerifTab(taquin)) {
                    // Variable globale modifée pour la fonction `AfficherTaquin` afin de remplir en
                    // vert chaque case du puzzle.
                    g_Victoire = true;
                }

                AfficherTaquin(taquin, renderer, font);

                if (g_Victoire) {
                    goto end;
                }
            break;
        }
    }
 end:
    // Libère les ressources
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    TTF_Quit();
    FreeTaquin(taquin);
    printf(PRINT_COLOR_YELLOW"Arrêt normal du programme après résolution du puzzle ! \n"PRINT_COLOR_RESET);
    exit(EXIT_SUCCESS);
}

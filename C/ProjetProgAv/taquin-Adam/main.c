#include "f_taquin.h"

// Utilisé pour la fin de partie
bool g_Victoire = false;

int main() {
    srand(time(NULL));
    SDL_InitAll();
    system("clear");
    
    Taquin * taquin;
    clock_t debut,fin; //début, fin d'exécution
    float temps_passe = 0.0;
    int mode = 0;
    int n = 1; //int saisie_taille = -1;
    int erreur_taille = 0;
    int menu = 1;
    char str_file[30];
    char touche;
    bool quit = false;
    SDL_Surface * image = NULL;
    
    while (menu != 0) {
        char rep;
        printf("Quel taquin voulez-vous faire ?\n\n1) Jeu aléatoire sur fenêtre \n2) Jeu sur fenêtre importé d'un fichier\n3) Jeu sur fenêtre avec une image importée \n4) Jeu classique aléatoire textuel \n5) Quitter\n");
        scanf("%c", &rep);

        switch(rep) {
            case '1': {
                while (n < 2) {
                    printf("Saisissez une taille supérieure ou égale à 2 : ");
                    if(scanf("%d",&n) != 1) {
                        menu = 1;
                        erreur_taille = 1;
                        break;
                    } else {
                        erreur_taille = 0;
                    }
                }
                if (erreur_taille == 0) {
                menu = 0;
                taquin = CreerTaquin(n);
                InitTaquin(taquin, 100);
                }
                else {
                    printf(PRINT_COLOR_RED"Saisie de la taille invalide !\n"PRINT_COLOR_RESET);
                }
                break;
            }
            case '2':
                printf("Entrez le nom du fichier (max 30 caractères) : ");

                scanf("%s", str_file);

                FILE * file = fopen(str_file, "r");
                if (file != NULL) {
                    taquin = ImportTaquin(file);
                    if (taquin == NULL) {
                        printf(PRINT_COLOR_RED"Fichier invalide selon le modèle donné...\n"PRINT_COLOR_RESET);
                        break;
                    }
                    n = taquin->taille; //n va recevoir la taille du taquin saisi
                    menu = 0;
                } else {
                    system("clear");
                    printf(PRINT_COLOR_RED"Ce fichier est inexistant ou invalide.\n\n"PRINT_COLOR_RESET);
                }
                break;
            case '3' :
            	printf("Entrez le nom du fichier (max 30 caractères), l'image doit être de dimension carrée : \n");
                scanf("%s", str_file);

                image = IMG_Load(str_file);
                if (image == NULL)
                {
                    printf(PRINT_COLOR_RED"Fichier inexistant...\n"PRINT_COLOR_RESET);
                    break;
                }
                if (image->h != image->w)
                {
                    printf(PRINT_COLOR_RED"Fichier invalide selon les dimensions de l'image"PRINT_COLOR_RESET);
                    break;
                }
                printf("Entrez une taille supérieure à 2.\n");
                if(scanf("%d",&n) != 1) {
                    menu = 1;
                    erreur_taille = 1;
                    break;
                } else {
                    erreur_taille = 0;
                }
                if (erreur_taille == 0) {
                    menu = 0;
                    mode = 1;
                    taquin = CreerTaquin(n);
                    InitTaquin(taquin, 100);
                }
                else {
                    printf(PRINT_COLOR_RED"Saisie de la taille invalide !\n"PRINT_COLOR_RESET);
                    SDL_FreeSurface(image);
                }

                break;
            case '4' : {
            	while (n < 2) {
                    printf("Saisissez une taille supérieure ou égale à 2 : ");
                    if(scanf("%d",&n) != 1) {
                        menu = 1;
                        erreur_taille = 1;
                        break;
                    } else {
                        erreur_taille = 0;
                    }
                }
                if (erreur_taille == 0) {
                    quit = false;
                    taquin = CreerTaquin(n);
                    InitTaquin(taquin, 100);
                    do
		    {
			system("clear");
			AfficherTaquinTextuel(taquin);
			printf("\nCommande ? \n");
			scanf("%c", &touche);
			switch (touche)
			{
				case 'g':
					BougeTaquin(taquin, GAUCHE);
					break;
				case 'd':
					BougeTaquin(taquin, DROITE);
					break;
				case 'h':
					BougeTaquin(taquin, HAUT);
					break;
				case 'b':
					BougeTaquin(taquin, BAS);
					break;
				case 'q':
					quit = true;
                        		
			}
		    } while (!VerifTab(taquin) && !quit);
		    menu = 1;
                }
                else {
                    printf(PRINT_COLOR_RED"Saisie de la taille invalide !\n"PRINT_COLOR_RESET);
                }
                break;
            }    
            case '5' : {
                free(taquin); // on libère le taquin
                SDL_Quit(); //on quitte la sdl
                printf(PRINT_COLOR_RED"Arrêt du programme via l'option '5'\n"PRINT_COLOR_RESET);
                exit(EXIT_SUCCESS); // on arrête la fonction principale
                break;
            }
            default :
            {
            	system("clear");
                //printf(PRINT_COLOR_RED"Saisie invalide ! \n"PRINT_COLOR_RESET);
                break;
            }
        }
    }

    SDL_Window * window = NULL;
    SDL_Renderer * renderer = NULL;
    TTF_Font * font = NULL;
    SDL_Event event;
    
    if (mode == 0)
    	window = CreerFenetre("Taquin", 80*n, 80*n);
    else if (mode == 1)
    	window = CreerFenetre("Taquin", image->w, image->h);
    
    if (mode != 2)
    {
	if (!window) {
	    exit(EXIT_FAILURE);
	}
	    
    	renderer = CreerRendu(window);
	if (!renderer) {
	    exit(EXIT_FAILURE);
	}
    }

    if (mode == 0) {
    	font = TTF_OpenFont("police.ttf", 40);
        if (!AfficherTaquin(taquin, renderer, font)) {
            // goto end?
            exit(EXIT_FAILURE);
        }
    } else if (mode == 1) {
        if (!AfficherImage(taquin, image, renderer)) {
            // goto end?
            exit(EXIT_FAILURE);
        }
    }

    debut = clock();
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
                    case 'l':
                        AfficheTab(taquin);
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
                
                if (mode == 1)
                    AfficherImage(taquin, image, renderer);
                else if (mode == 0)
                    AfficherTaquin(taquin, renderer, font);

                if (g_Victoire) {
                    fin = clock();
                    temps_passe = (float)(fin - debut) / CLOCKS_PER_SEC;
                    printf(PRINT_COLOR_YELLOW"Le puzzle a été résolu en %.3f secondes\n"PRINT_COLOR_RESET, temps_passe);
                    goto end;
                }
            break;
        }
    }
 end:
    // Libère les ressources
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    IMG_Quit();
    SDL_Quit();
    TTF_Quit();
    FreeTaquin(taquin);
    printf(PRINT_COLOR_RED"Arrêt normal du programme\n"PRINT_COLOR_RESET);
    exit(EXIT_SUCCESS);
}

#include "f_taquin.h"

// Utilisé pour la fin de partie
bool g_Victoire = false;

int main() {
    // Initialisation du générateur de nombre aléatoire
    srand(time(NULL));

    // Initialisation des librairies SDL
    SDL_InitAll();
    system("clear");

    Taquin * taquin = NULL;
    // Taille du taquin, entré par l'utilisateur
    int n;
    // Indique si une erreur de saisie a été détectée lors de l'entrée de la taille du taquin
    bool erreur_taille = false;

    // Temps mesuré au début et à la fin de la partie
    clock_t debut, fin;
    // Temps passé dans la partie
    float temps_passe = 0.0;

    // Contient le nom des fichiers (image ou texte du taquin)
    char str_file[30];
    // Contient l'image importée
    SDL_Surface * image = NULL;

    // Booléen servant à quitter le menu
    bool menu = true;
    while (menu) {
        printf("Quel taquin voulez-vous faire ?\n\n"
                "1) Jeu aléatoire sur fenêtre \n"
                "2) Jeu sur fenêtre importé d'un fichier\n"
                "3) Jeu sur fenêtre avec une image importée\n"
                "4) Jeu classique aléatoire textuel\n"
                "5) Quitter\n");

        char rep;
        scanf("%c", &rep);
        fgetc(stdin);

        switch (rep) {
        case '1':
            // Récupère la taille de taquin saisie par l'utilisateur
            do {
                printf("Saisissez une taille supérieure ou égale à 2 : ");
                if (!scanf("%d", &n)) {
                    erreur_taille = true;
                    printf(PRINT_COLOR_RED "Saisie de la taille invalide !\n" PRINT_COLOR_RESET);
                    break;
                }
            } while (n < 2);

            if (!erreur_taille) {
                menu = false;
                taquin = CreerTaquin(n);
                InitTaquin(taquin, 100);
            }

            break;
        case '2':
            printf("Entrez le nom du fichier (max 30 caractères) : ");

            // Lit la saisie de l'utilisateur tout en supprimant le retour à la ligne 
            fgets(str_file, sizeof(str_file), stdin);
            str_file[strcspn(str_file, "\n")] = 0;

            FILE * file = fopen(str_file, "r");
            if (file != NULL) {
                taquin = ImportTaquin(file);
                if (taquin == NULL) {
                    printf(PRINT_COLOR_RED "Fichier invalide selon le modèle "
                            "donné...\n" PRINT_COLOR_RESET);
                    break;
                }
                // n va recevoir la taille du taquin saisi
                n = taquin->taille;
                menu = false;
            } else {
                system("clear");
                printf(PRINT_COLOR_RED "Ce fichier est inexistant ou invalide.\n\n" 
                    PRINT_COLOR_RESET);
            }
            break;
        case '3':
            printf("Entrez le nom du fichier (max 30 caractères), l'image doit"
                    " être de dimension carrée :\n");

            // Lit la saisie de l'utilisateur tout en supprimant le retour à la ligne 
            fgets(str_file, sizeof(str_file), stdin);
            str_file[strcspn(str_file, "\n")] = 0;

            image = IMG_Load(str_file);
            if (image == NULL) {
                printf(PRINT_COLOR_RED "Fichier inexistant...\n" PRINT_COLOR_RESET);
                break;
            } else if (image->h != image->w) {
                printf(PRINT_COLOR_RED "Fichier invalide selon les dimensions "
                        "de l'image\n" PRINT_COLOR_RESET);
                break;
            }

            printf("Entrez une taille supérieure à 2.\n");

            if (!scanf("%d", &n)) {
                printf(PRINT_COLOR_RED "Saisie de la taille invalide !\n" PRINT_COLOR_RESET);
                SDL_FreeSurface(image);
                break;
            } else {
                menu = false;
                taquin = CreerTaquin(n);
                InitTaquin(taquin, 100);
            }

            break;
        case '4':
            // Récupère la taille de taquin saisie par l'utilisateur
            do {
                printf("Saisissez une taille supérieure ou égale à 2 : ");
                if (!scanf("%d", &n)) {
                    erreur_taille = true;
                    printf(PRINT_COLOR_RED "Saisie de la taille invalide !\n" PRINT_COLOR_RESET);
                    break;
                }
            } while (n < 2);

            // Indique la fin de la partie
            bool quit = false;
            if (!erreur_taille) {
                taquin = CreerTaquin(n);
                InitTaquin(taquin, 100);
                
                // Touche entrée pour le jeu textuel du taquin
                char touche;
                do {
                    system("clear");
                    printf("Utilisez les touches suivantes pour résoudre le taquin :\n"
                            "g (gauche)\n"
                            "d (droite)\n"
                            "h (haut)\n"
                            "b (bas)\n");
                    AfficheTab(taquin);

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
                        break;
                    default:
                        break;
                    }
                } while (!VerifTab(taquin) && !quit);
            }
            
            // Consomme le retour à la ligne de la saisie de l'utilisateur
            fgetc(stdin);

            break;
        case '5':
            printf(PRINT_COLOR_RED "Arrêt du programme via l'option '5'\n" PRINT_COLOR_RESET);

            FreeTaquin(taquin);
            SDL_Quit();
            exit(EXIT_SUCCESS);

            break;
        default:
            system("clear");
            printf(PRINT_COLOR_RED"Saisie invalide ! (%c)\n"PRINT_COLOR_RESET,rep);
            break;
        }
    }

    SDL_Window * window = NULL;
    SDL_Renderer * renderer = NULL;
    TTF_Font * font = NULL;

    // Créé la fenêtre taquin selon le mode de jeu (cases numérotées ou image)
    if (!image) {
        window = CreerFenetre("Taquin", 80 * n, 80 * n);
    } else {
        window = CreerFenetre("Taquin", image->w, image->h);
    }

    renderer = CreerRendu(window);
    if (!renderer) {
        exit(EXIT_FAILURE);
    }

    // Affiche le taquin selon le mode de jeu
    if (image) {
        if (!AfficherImage(taquin, image, renderer)) {
            exit(EXIT_FAILURE);
        }
    } else {
        font = TTF_OpenFont("police.ttf", 40);
        if (!font) {
            exit(EXIT_FAILURE);
        }

        if (!AfficherTaquin(taquin, renderer, font)) {
            exit(EXIT_FAILURE);
        }
    }

    debut = clock();

    SDL_Event event;
    while (true) {
        // Attend indéfiniment jusqu'au prochain événement
        SDL_WaitEvent(&event);

        switch (event.type) {
        case SDL_WINDOWEVENT:
            // Arrête le programme en cas de fermeture de la fenêtre
            if (event.window.event == SDL_WINDOWEVENT_CLOSE) {
                printf(PRINT_COLOR_RED "Arrêt du programme via fermeture manuelle\n" 
                    PRINT_COLOR_RESET);
                goto end;
            }
            break;
        case SDL_KEYUP:
            SDL_RenderClear(renderer);

            // Effectue les différentes actions selon la touche entrée par l'utilisateur
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
                // Affiche le puzzle en mode textuel
                AfficheTab(taquin);
                break;
            case 'q':
                printf(PRINT_COLOR_RED "Arrêt du programme via la touche 'q'\n" PRINT_COLOR_RESET);
                goto end;
            }

            // Vérifie si le taquin a été résolu
            if (VerifTab(taquin)) {
                // La variable globale `g_Victoire` est responsable des différentes animations de
                // fin de partie
                g_Victoire = true;
            }

            // Affiche le taquin, selon le mode de jeu. 
            // L'affichage est ainsi mis à jour à chaque mouvement du joueur.
            if (image) {
                AfficherImage(taquin, image, renderer);
            } else {
                AfficherTaquin(taquin, renderer, font);
            }

            // Affiche le temps écoulé et quitte le programme en cas de victoire
            if (g_Victoire) {
                fin = clock();
                temps_passe = (float)(fin - debut) / CLOCKS_PER_SEC;
                printf(PRINT_COLOR_YELLOW "Le puzzle a été résolu en %.3f secondes\n" 
                    PRINT_COLOR_RESET, temps_passe);
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
    printf(PRINT_COLOR_RED "Arrêt normal du programme\n" PRINT_COLOR_RESET);
    exit(EXIT_SUCCESS);
}

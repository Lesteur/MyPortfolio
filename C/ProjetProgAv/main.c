#include "f_taquin.h"

int main() {
    int n = 4;
    int menu = 1;
    int rep = 0;
    char str_file[30];
    Taquin * taquin;
    /*
    if (argc == 2 && atoi(argv[1]) >= 2) {
        n = atoi(argv[1]);
    }
    */
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

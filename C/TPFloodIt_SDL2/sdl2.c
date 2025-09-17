/**
 * \file sdl2.c
 * \brief Flood it SDL2
 * \author Adam Ibnouzahir
 * \version 1.0
 *
 * Programme pour le jeu de Flood it
 *
 */

/* Fichier modèle pour l'utilisation de la SDL2 
   Ne pas oublier l'édition des liens avec les bonnes bibliothèques 
    -lSDL2 -lSDL2_image -lSDL2_ttf 
   cela suffit pour ada et les machines virtuelles de l'ISIMA 
   pour vos installation, il faudra peut etre ajuster les options suivantes :
   -I/opt/local/include -L/opt/local/lib 

*/

#include "sdl2.h"

#include<SDL2/SDL.h>
#include<SDL2/SDL_image.h>
#include<SDL2/SDL_ttf.h>
#include <stdbool.h>

SDL_Window   * window   = NULL; // fenetre utilisee par le programme
SDL_Renderer * renderer = NULL; // moteur de rendu SDL
SDL_Texture  * logo     = NULL; // image chargee
TTF_Font     * font1    = NULL; // polices de caracteres
TTF_Font     * font2    = NULL;
int            width    = 560;  // largeur de la fenetre
int            height   = 560;  // hauteur de la fenetre

SDL_Event      event;
int            running = 1;
bool           img_init   = true;
bool           ttf_init   = true;

/*
   Cette fonction est appelee des qu'il est necessaire de dessiner la fenetre
*/
void dessinerBackground() {
   // on precise la transparence mais pour l'utiliser, il faut l'activer
   SDL_SetRenderDrawColor(renderer, 10, 10, 10, 0);
   SDL_RenderClear(renderer);

   // un seul appel a cette fonction est necessaire
   SDL_RenderPresent(renderer);
}


int init_sdl() {
    /* ********************************************************************* */
    /* SECTION DES INITIALISATIONS                                           */
    /* ********************************************************************* */
 
    // Note : je n'ai pas envie d'empiler les if/else imbriques
    // first of all : initialisation de la SDL
    if (SDL_Init(SDL_INIT_VIDEO) == -1)  /* SDL_INIT_EVERYTHING */ {
        fprintf(stderr, "Erreur d'initialisation de la SDL : %s\n", SDL_GetError());
        return EXIT_FAILURE;   
    } 

    // Initialisation de la bibliotheque SDL2_image
    int flags = IMG_INIT_JPG | IMG_INIT_PNG;
    int initted = IMG_Init(flags);
    if((initted&flags) != flags) {
        printf("IMG_Init: jpg et/ou png non supportes!\n");
        printf("IMG_Init: %s\n", IMG_GetError());
        img_init = false;   
    }

    // Initialisation de la bibliotheque SDL2_ttf
    if (TTF_Init() != 0) {
        fprintf(stderr, "Erreur d'initialisation TTF : %s\n", TTF_GetError());
        ttf_init = false;
    }

    if ((img_init) && (ttf_init)) {
        window = SDL_CreateWindow("Flood It", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, width, height, 
                                    // SDL_WINDOW_FULLSCREEN ); 
                                       SDL_WINDOW_SHOWN ); //  |  SDL_WINDOW_RESIZABLE);
    }
    
    if (window == 0) {
        fprintf(stderr, "Erreur a la creation de la fenetre : %s\n", SDL_GetError()); 
    } else {
        renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED ); /* | SDL_RENDERER_PRESENTVSYNC */
        if (renderer == 0) {
            fprintf(stderr, "Erreur de creation d'un renderer : %s\n", SDL_GetError());
        }
    }

    if ((window) && (renderer)) {
        // utilisation de la transparence ?
        // SDL_SetRenderDrawBlendMode(renderer, SDL_BLENDMODE_BLEND);
        // fenetre et moteur de rendu operationnels = chargement des ressources

        font1 = TTF_OpenFont("chlorinar.regular.ttf", 72 ); 
        font2 = TTF_OpenFont("fake.receipt.ttf", 72 ); 

        if ((font1 == 0) || (font2==0)) {
            fprintf(stderr, "Erreur d'initialisation police : %s\n", TTF_GetError());
            fprintf(stderr, "Avez-vous pense a mettre dans le repertoire le fichier de la police\n"); 
        }

        SDL_Surface * image = NULL;
        image = IMG_Load("loic.png");

        if(!image) {
            printf("IMG_Load: %s\n", IMG_GetError());
        } else {
            logo = SDL_CreateTextureFromSurface(renderer, image);
            SDL_FreeSurface(image);
        }
    }

    return 0;
}

void end_sdl() {
    /* ********************************************************************* */
    /* RENDU DES RESSOURCES                                                  */
    /* ********************************************************************* */

    if (font1) TTF_CloseFont(font1);
    if (font2) TTF_CloseFont(font2);
    if (logo)  SDL_DestroyTexture(logo);
        
    if (renderer) SDL_DestroyRenderer(renderer);
    if (window)   SDL_DestroyWindow(window);

    if (img_init) IMG_Quit();
    if (ttf_init) TTF_Quit();
    SDL_Quit(); // ouf, on a fini
}
/**
 * \file main.c
 * \brief Flood it SDL2
 * \author Adam Ibnouzahir
 * \version 1.0
 *
 * Programme pour le jeu de Flood it
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include <time.h>

#include "floodit.h"
#include "sdl2.h"

enum ETAT {
   INTRODUCTION, JEU, FIN
};

/**
 * @fn void dessinerCarre(int x, int y, int width, int height, palette_t color)
 * @brief Dessine un carré dans la fenêtre
 *
 * @param x Position en x du carré
 * @param y Position en y du carré
 * @param width Largeur du carré
 * @param height Hauteur du carré
 * @param color Couleur du carré
 * @return void
 */
void dessinerCarre(int x, int y, int width, int height, int color) {
    SDL_Rect r;
    r.x = x;
    r.y = y;
    r.w = width;
    r.h = height;

    switch (color) {
        case ROUGE:
            SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
            break;
        case VERT:
            SDL_SetRenderDrawColor(renderer, 0, 255, 0, 255);
            break;
        case BLEU:
            SDL_SetRenderDrawColor(renderer, 0, 0, 255, 255);
            break;
        case JAUNE:
            SDL_SetRenderDrawColor(renderer, 255, 255, 0, 255);
            break;
        case CYAN:
            SDL_SetRenderDrawColor(renderer, 0, 255, 255, 255);
            break;
        case MAGENTA:
            SDL_SetRenderDrawColor(renderer, 255, 0, 255, 255);
            break;
        case BLANC:
            SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
            break;
        case NOIR:
            SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
            break;
        default:
            SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
            break;
    }

    SDL_RenderFillRect(renderer, &r);
}

/**
 * @fn void dessinerGrille(int grille[TAILLE][TAILLE])
 * @brief Dessine la grille de jeu
 *
 * @param grille La grille de jeu
 * @return void
 */
void dessinerGrille(int grille[TAILLE][TAILLE]) {
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderClear(renderer);

    int i, j;

    for (i = 0; i < TAILLE; i++) {
        for (j = 0; j < TAILLE; j++) {
            dessinerCarre(j * (height/TAILLE), i * (width/TAILLE), (width/TAILLE), (height/TAILLE), grille[i][j]);
        }
    }

    SDL_RenderPresent(renderer);
}


void afficherIntroduction() {
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderClear(renderer);

    SDL_Rect r;
    r.x = width/2 - 100;
    r.y = height/2 - 50;
    r.w = 200;
    r.h = 100;

    SDL_Color     couleur  = {255, 255, 255, 255};

    SDL_Surface * surf     = TTF_RenderText_Blended(font1, "Flood It", couleur);
    SDL_Surface * surf2    = TTF_RenderText_Blended(font1, "Cliquez pour commencer", couleur);
    
    SDL_Texture * texttext  = SDL_CreateTextureFromSurface(renderer, surf);
    SDL_Texture * texttext2 = SDL_CreateTextureFromSurface(renderer, surf2);
    
    SDL_RenderCopy(renderer, texttext, NULL, &r);
    r.x = width/2 - 200;
    r.y += 100;

    r.w = 400;
    SDL_RenderCopy(renderer, texttext2, NULL, &r);

    SDL_RenderPresent(renderer);

    SDL_DestroyTexture(texttext);
    SDL_DestroyTexture(texttext2);
    SDL_FreeSurface(surf);
    SDL_FreeSurface(surf2);
}

void afficherFin() {
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderClear(renderer);

    SDL_Rect r;
    r.x = 0;
    r.y = 0;
    r.w = width;
    r.h = height;

    SDL_RenderCopy(renderer, logo, NULL, &r);
    SDL_RenderPresent(renderer);
}


void afficherFenetreDeJeu() {
    dessinerGrille(grilleGlobale);
}


int main(int argc, char ** argv) {

    srand(time(NULL));

    int x, y;

    tentatives = 25;

    enum ETAT mode = INTRODUCTION;

    for (int i = 0; argc > i; i++) {
        printf("argv[%d] = %s\n", i, argv[i]);
    }

    initialiser(grilleGlobale);
    
    if (init_sdl() == EXIT_FAILURE) return EXIT_FAILURE;

    if (font1 && font2 && logo) {

        printf("Vous avez %d tentatives pour remplir la grille de Flood It.\n", tentatives);
    
        /* ********************************************************************* */
        /* BOUCLE DES EVENEMENTS                                                 */
        /* ********************************************************************* */
    
        while (running) {

            while (SDL_PollEvent(&event)) {

                switch(mode) {
                    case INTRODUCTION :
                        afficherIntroduction();
                        break;
                    case JEU :
                        afficherFenetreDeJeu();
                        break;
                    case FIN :
                        afficherFin();
                        break;
                }

                switch(event.type) {
                    case SDL_WINDOWEVENT:
                        // Gestion de la fenêtre

                        switch (event.window.event)  {
                            case SDL_WINDOWEVENT_CLOSE:  
                                printf("Appui sur la croix.\n");
                                break;
                            default:
                                break;
                        }
                    break;
                    case SDL_MOUSEBUTTONDOWN:
                        // Gestion des clics

                        switch (mode)
                        {
                            case INTRODUCTION:
                                mode = JEU;
                                break;
                            case JEU:
                                x = event.button.x / (width/TAILLE);
                                y = event.button.y / (height/TAILLE);

                                if (x < 0 || x >= TAILLE || y < 0 || y >= TAILLE) {
                                    break;
                                } else if (grilleGlobale[y][x] == grilleGlobale[0][0]) {
                                    break;
                                }
                                
                                remplir(grilleGlobale, grilleGlobale[0][0], grilleGlobale[y][x], 0, 0);
                                tentatives--;

                                if (fin(grilleGlobale)) {
                                    mode = FIN;
                                } else if (tentatives == 0) {
                                    running = 0;
                                    printf("Vous n'avez plus de tentatives...\n");
                                } else
                                    printf("Il vous reste %d tentatives.\n", tentatives);

                                break;
                            case FIN:
                                break;
                        }
                        break;
                    case SDL_QUIT : 
                        printf("On quitte.\n");
                        running = 0;
                }
            }
            
            SDL_Delay(1);
        }
    }

    end_sdl();

    return EXIT_SUCCESS;
}

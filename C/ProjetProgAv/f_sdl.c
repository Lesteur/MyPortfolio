#include "f_sdl.h"

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

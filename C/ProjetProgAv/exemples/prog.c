#include <stdio.h>
#include <stdlib.h>
#include <SDL2/SDL.h>
#include <time.h>
#include <stdlib.h>

#define WIDTH 512
#define HEIGHT WIDTH
#define LC 50

void boucleEv();
void dessine(SDL_Renderer *renderer);
SDL_Texture *rectangle = NULL;
SDL_Rect position;
SDL_Window *window = NULL;
SDL_Renderer *renderer = NULL;

void boucleEv()
{
    int cont = 1;
    SDL_Event event;
    while (cont)
    {
        SDL_WaitEvent(&event);
        switch (event.type)
        {
        case SDL_QUIT:
            cont = 0;
            break;
        case SDL_KEYDOWN:
            switch (event.key.keysym.sym)
            {
            case SDLK_UP:
                if (position.y >= LC)
                {
                    position.y = position.y - LC;
                }
                else
                {
                    position.y = 0;
                }
                dessine(renderer);
                break;
            case SDLK_DOWN:
                if (position.y + LC < HEIGHT - LC)
                {
                    position.y += LC;
                }
                else
                {
                    position.y = HEIGHT - LC - 1;
                }
                dessine(renderer);
                break;
            case SDLK_LEFT:
                if (position.x >= LC)
                {
                    position.x -= LC;
                }
                else
                {
                    position.x = 0;
                }
                dessine(renderer);
                break;
            case SDLK_RIGHT:
                if (position.x + LC < WIDTH - LC)
                {
                    position.x += LC;
                }
                else
                {
                    position.x = WIDTH - LC - 1;
                }
                dessine(renderer);
                break;
            case SDLK_q:
                cont = 0;
                break;
            }
        }
    }
}

void dessine(SDL_Renderer *renderer)
{
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
    SDL_RenderClear(renderer);

    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    SDL_RenderFillRect(renderer, &position);

    SDL_RenderPresent(renderer);
}

int main(int argc, char **argv)
{
    srand(time(NULL));
    position.x = (WIDTH / 2) - (LC / 2);
    position.y = (HEIGHT / 2) - (LC / 2);

    // Initialisation de SDL
    if (SDL_Init(SDL_INIT_VIDEO) != 0)
    {
        fprintf(stderr, "\nUnable to initialize SDL: %s\n", SDL_GetError());
        exit(EXIT_FAILURE);
    }

    // Création d'une fenêtre
    window = SDL_CreateWindow("Carré Blanc", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, WIDTH, HEIGHT, SDL_WINDOW_SHOWN);
    if (window == NULL)
    {
        fprintf(stderr, "Erreur lors de la création de la fenêtre : %s\n", SDL_GetError());
        SDL_Quit();
        exit(EXIT_FAILURE);
    }

    // Création d'un rendu (renderer)
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (renderer == NULL)
    {
        fprintf(stderr, "Erreur lors de la création du rendu : %s\n", SDL_GetError());
        SDL_DestroyWindow(window);
        SDL_Quit();
        exit(EXIT_FAILURE);
    }

    // Création de la texture pour le rectangle
    rectangle = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_STATIC, LC, LC);
    SDL_SetTextureBlendMode(rectangle, SDL_BLENDMODE_BLEND);
    SDL_SetRenderTarget(renderer, rectangle);

    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    SDL_RenderFillRect(renderer, NULL);

    SDL_SetRenderTarget(renderer, NULL);

    SDL_FillRect(SDL_GetWindowSurface(window), NULL, SDL_MapRGB(SDL_GetWindowSurface(window)->format, 0, 0, 0));

    dessine(renderer);

    boucleEv();

    // Quit
    SDL_DestroyTexture(rectangle);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return EXIT_SUCCESS;
}


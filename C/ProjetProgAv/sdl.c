#include <stdio.h>
#include <stdlib.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include <time.h>

struct _Taquin
{
  int ** puzzle;
  int n;
  int i;
  int j;
};
typedef struct _Taquin Taquin;

int error = 0;

SDL_Window * CreerFenetre(char * title, int width, int height)
{
    SDL_Window * window = SDL_CreateWindow(title, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, width, height, SDL_WINDOW_RESIZABLE);
    if (window == NULL) {
        printf("Window creation failed: %s\n", SDL_GetError());
        error = 1;
    }
    return window;
}

SDL_Renderer * CreerRendu(SDL_Window * window)
{
    SDL_Renderer * rendu = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (rendu == NULL) {
        fprintf(stderr, "Erreur lors de la création du rendu : %s\n", SDL_GetError());
        error = 1;
    }
    return rendu;
}

void SDL_InitAll()
{
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

SDL_Surface * CreerTexte(TTF_Font * font, char * str, SDL_Color textColor)
{
    SDL_Surface * textSurface = TTF_RenderText_Blended(font, str, textColor);
    if (textSurface == NULL) {
        fprintf(stderr, "Erreur lors de la création de la surface de texte : %s\n", TTF_GetError());
        error = 1;
    }
    return textSurface;
}

SDL_Texture * CreerTexture(SDL_Renderer * renderer, SDL_Surface * surface)
{
    SDL_Texture * textTexture = SDL_CreateTextureFromSurface(renderer, surface);
    if (textTexture == NULL) {
        fprintf(stderr, "Erreur lors de la création de la surface de texte : %s\n", TTF_GetError());
        error = 1;
    }
    return textTexture;
}

int ** CreerTab(int n)
{
  int ** tab = malloc(sizeof(int*)*n);
  for (int i = 0; i < n; i++)
  {
    tab[i] = malloc(sizeof(int)*n);
    for (int j = 0; j < n; j++)
    {
      tab[i][j] = i*n+j + 1;
    }
  }
  tab[n-1][n-1] = 0;
  return tab;
}

Taquin * CreerTaquin(int n)
{
  Taquin * puzzle = malloc(sizeof(Taquin));
  puzzle->puzzle = CreerTab(n);
  puzzle->n = n;
  puzzle->i = n-1;
  puzzle->j = n-1;
  return puzzle;
}

void FreeTaquin(Taquin * puzzle)
{
  for (int i = 0; i < puzzle->n; i++)
  {
    free(puzzle->puzzle[i]);
  }
  free(puzzle->puzzle);
  free(puzzle);
}

void LibererSurTex(int n, SDL_Surface * surf[10][10], SDL_Texture * text[10][10])
{
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            SDL_FreeSurface(surf[i][j]);
            SDL_DestroyTexture(text[i][j]);
        }
    }
}

void BougeTaquin(Taquin * puzzle, char touche)
{
  int ** tab = puzzle->puzzle;
  int i = puzzle->i;
  int j = puzzle->j;
  int n = puzzle->n;
  switch (touche)
  {
    case 'g':
      if (j != 0)
      {
        tab[i][j] = tab[i][j-1];
        tab[i][j-1] = 0;
        puzzle->j = j-1;
      }
      break;
    case 'd':
      if (j != n-1)
      {
        tab[i][j] = tab[i][j+1];
        tab[i][j+1] = 0;
        puzzle->j = j+1;
      }
      break;
    case 'h':
      if (i != 0)
      {
        tab[i][j] = tab[i-1][j];
        tab[i-1][j] = 0;
        puzzle->i = i-1;
      }
      break;
    case 'b':
      if (i != n-1)
      {
        tab[i][j] = tab[i+1][j];
        tab[i+1][j] = 0;
        puzzle->i = i+1;
      }
      break;
  }
}

void ResetAffichage(int efface, SDL_Surface * surf[10][10], SDL_Texture * text[10][10], SDL_Rect rect[10][10], SDL_Renderer * renderer, Taquin * taquin, TTF_Font * font)
{
    int n = taquin->n;
    char str[3];
    SDL_Color textColor = {255, 255, 255, 255};

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            //printf("%ld\n", (long int) surf[i][j]);
            if (efface == 1)
            {
                SDL_FreeSurface(surf[i][j]);
                SDL_DestroyTexture(text[i][j]);
            }
            snprintf(str, sizeof(str), "%d", taquin->puzzle[i][j]);
            surf[i][j] = CreerTexte(font, str, textColor);
            text[i][j] = CreerTexture(renderer, surf[i][j]);
            rect[i][j].w = surf[i][j]->w;
            rect[i][j].h = surf[i][j]->h;
            SDL_RenderCopy(renderer, text[i][j], NULL, &rect[i][j]);
        }
    }
    SDL_RenderPresent(renderer);
}

void InitTaquin(Taquin * puzzle, int iter)
{
  int nb, n;
  for (int i = 0; i < iter; i++)
  {
    nb = rand() % 4;
    switch(nb)
    {
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
  n = puzzle->n - puzzle->j - 1;
  for (int i = 0; i < n; i++)
    BougeTaquin(puzzle, 'd');
  n = puzzle->n - puzzle->i - 1;
  for (int j = 0; j < n; j++)
    BougeTaquin(puzzle, 'b');
}

int VerifTab(Taquin * taquin)
{
    int ** tab = taquin->puzzle;
    int n = taquin->n;
    int indice = 1;
    if (tab[n-1][n-1] != 0)
    {
      return -1;
    }
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
          if ((tab[i][j] != indice) && ((i != n-1) && (j != n-1)))
          {
            return -1;
          }
          indice++;
        }
    }
    return 0;
}

int main() {
    srand( time(NULL) );
    SDL_InitAll();
    int n = 4;
    SDL_Window * window = CreerFenetre("Exemple", 80*n, 80*n);
    SDL_Renderer * renderer = CreerRendu(window);
    SDL_Event event;
    //SDL_Color textColor = {255, 255, 255, 255};
    TTF_Font * font = TTF_OpenFont("police.ttf", 40);
    Taquin * taquin = CreerTaquin(n);
    InitTaquin(taquin, 100);

    SDL_Surface * listSurface[10][10];
    SDL_Texture * listTexture[10][10];
    SDL_Rect listRect[10][10];

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            listRect[i][j].x = 80*j + 10;
            listRect[i][j].y = 80*i + 10;
        }
    }

    ResetAffichage(0, listSurface, listTexture, listRect, renderer, taquin, font);
    if (error == 1)
    {
        LibererSurTex(n, listSurface, listTexture);
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit();
        exit(EXIT_FAILURE);
    }

    int cont= 1;
    while(cont)
    {
        SDL_WaitEvent(&event);
        if (VerifTab(taquin) == 0)
        {
          cont = 0;
          LibererSurTex(n, listSurface, listTexture);
          SDL_DestroyRenderer(renderer);
          SDL_DestroyWindow(window);
          SDL_Quit();
        }
        switch(event.type){
        case SDL_KEYUP:
            switch(event.key.keysym.sym){
                case SDLK_UP:
                    BougeTaquin(taquin, 'h');
                    SDL_DestroyRenderer(renderer);
                    renderer = CreerRendu(window);
                    ResetAffichage(1, listSurface, listTexture, listRect, renderer, taquin, font);
                    break;
                case SDLK_DOWN:
                    BougeTaquin(taquin, 'b');
                    SDL_DestroyRenderer(renderer);
                    renderer = CreerRendu(window);
                    ResetAffichage(1, listSurface, listTexture, listRect, renderer, taquin, font);
                    break;
                case SDLK_LEFT:
                    BougeTaquin(taquin, 'g');
                    SDL_DestroyRenderer(renderer);
                    renderer = CreerRendu(window);
                    ResetAffichage(1, listSurface, listTexture, listRect, renderer, taquin, font);
                    break;
                case SDLK_RIGHT:
                    BougeTaquin(taquin, 'd');
                    SDL_DestroyRenderer(renderer);
                    renderer = CreerRendu(window);
                    ResetAffichage(1, listSurface, listTexture, listRect, renderer, taquin, font);
                    break;
                case 'q':
                    // Libérer les ressources
                    cont = 0;
                    LibererSurTex(n, listSurface, listTexture);
                    SDL_DestroyRenderer(renderer);
                    SDL_DestroyWindow(window);
                    SDL_Quit();
                    break;
            }
            break ;
        }
    }
    FreeTaquin(taquin);
    return 0;
}

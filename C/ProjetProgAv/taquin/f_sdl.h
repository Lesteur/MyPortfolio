#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>

SDL_Window * CreerFenetre(char * title, int width, int height);
SDL_Renderer * CreerRendu(SDL_Window * window);
SDL_Surface * CreerTexte(TTF_Font * font, char * str, SDL_Color textColor);
SDL_Texture * CreerTexture(SDL_Renderer * renderer, SDL_Surface * surface);
void SDL_InitAll();
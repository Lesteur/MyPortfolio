#include <stdio.h>
#include <stdlib.h>
#include <SDL2/SDL.h>
#include <time.h>
#define WIDTH 512
#define HEIGHT WIDTH
#define LC 50

void boucleEv() ;
void dessine(SDL_Window * f) ;
SDL_Surface * rectangle = NULL ;
SDL_Rect position ;
SDL_Window * ecran = NULL ;

void boucleEv(){
  int cont=1 ;
  SDL_Event event ;
  while(cont){
    SDL_WaitEvent(&event) ;
    switch(event.type){
    case SDL_QUIT:
      cont = 0;
    case SDL_KEYDOWN:
      switch(event.key.keysym.sym){
      case SDLK_UP:
        if(position.y>=LC){
          position.y=position.y-LC ;
        }else{
          position.y=0 ;
        }
        dessine(ecran) ;
        break ;
      case SDLK_DOWN:
        if(position.y+LC< HEIGHT-LC){
          position.y+=LC ;
        }else{
          position.y=HEIGHT-LC-1;
        }
        dessine(ecran) ;
        break ;
      case SDLK_LEFT :
        if(position.x>=LC){
          position.x-=LC ;
        }else{
          position.x=0 ;
        }
        dessine(ecran);
        break ;
      case SDLK_RIGHT:
        if(position.x+LC< WIDTH-LC){
          position.x+=LC ;
        }else{
          position.x=WIDTH-LC-1 ;
        }
        dessine(ecran) ;
        break ;
      case 'q':
        cont=0 ;
        break ;
      }
    }
  }
}

void dessine(SDL_Window * s){
  SDL_FillRect(ecran,NULL,SDL_MapRGB(ecran->format, 0,0,0) ) ;
  SDL_BlitSurface(rectangle,NULL,s,&position) ;
  SDL_RenderPresent(s) ;
}

int main(int argc, char ** argv)
{
  srand(time(NULL));
  position.x=(WIDTH/2)-(LC/2) ;
  position.y=(HEIGHT/2)-(LC/2) ;

  // Init
  if(SDL_Init(SDL_INIT_VIDEO) !=0){
    fprintf(stderr,"\nUnable to initialize SDL: %s\n", SDL_GetError() );
    exit(EXIT_FAILURE) ;
  }

  if((ecran = SDL_CreateWindow("SDL 2.0 Example", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, WIDTH, HEIGHT, SDL_WINDOW_SHOWN))==NULL){
    fprintf(stderr,"Erreur VideoMode %s\n",SDL_GetError());
    exit(EXIT_FAILURE) ;
  }

  rectangle = SDL_CreateRGBSurface(SDL_SWSURFACE, LC, LC, 32,0,0,0,0) ;
  SDL_FillRect(rectangle, NULL, SDL_MapRGB(rectangle->format,255,255,255)) ;
  // Légende de la fenêtre
  SDL_SetWindowTitle(NULL, "Carré Blanc") ;
  SDL_FillRect(rectangle,NULL,SDL_MapRGB(ecran->format, 0,0,0) ) ;
  //SDL_RenderPresent(rectangle) ;
  dessine(ecran) ;
  //SDL_RenderPresent(ecran) ;
  boucleEv() ;

  // Quit
  SDL_Quit() ;
  return EXIT_SUCCESS ;
}

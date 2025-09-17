#ifndef sdl2_h
#define sdl2_h

#include<SDL2/SDL.h>
#include<SDL2/SDL_image.h>
#include<SDL2/SDL_ttf.h>
#include <stdbool.h>

/**
 * @struct palette_t
 * @brief type utilisable pour definir une couleur de type RVBA
 */
typedef struct palette_t {
    Uint8 r; 
    Uint8 g;
    Uint8 b;
    Uint8 a; 
} palette_t;

/* VARIABLES GLOBALES */

/**
 * @var SDL_Window * window
 * @brief Fenêtre utilisee par le programme
 */
extern SDL_Window * window;

/**
 * @var SDL_Renderer * renderer
 * @brief Moteur de rendu SDL
 */
extern SDL_Renderer * renderer;

/**
 * @var SDL_Texture * logo
 * @brief Image chargée
 */
extern SDL_Texture * logo;

/**
 * @var TTF_Font * font1
 * @brief Police de caractères
 */
extern TTF_Font * font1;

/**
 * @var TTF_Font * font2
 * @brief Police de caractères
 */
extern TTF_Font * font2;

/**
 * @var int width
 * @brief Largeur de la fenêtre
 */
extern int width;

/**
 * @var int height
 * @brief Hauteur de la fenêtre
 */
extern int height;


/**
 * @var int running
 * @brief Booléen pour savoir si le programme est en cours d'exécution
 */
extern int running;

/**
 * @var SDL_Event event
 * @brief Événement SDL
 */
extern SDL_Event event;

/**
 * @var bool img_init
 * @brief Booléen pour savoir si l'initialisation de la bibliothèque SDL2_image a réussi
 */
extern bool img_init;

/**
 * @var bool ttf_init
 * @brief Booléen pour savoir si l'initialisation de la bibliothèque SDL2_ttf a réussi
 */
extern bool ttf_init;


/* FONCTIONS */

/**
 * @fn void dessinerBackground()
 * @brief Dessine le fond de la fenêtre
 *
 * @return void
 */
void dessinerBackground();

/**
 * @fn void init_sdl()
 * @brief Initialise la bibliothèque SDL2
 *
 * @return 0 si tout s'est bien passé, EXIT_FAILURE sinon
 */
int init_sdl();

/**

*/
void end_sdl();

#endif
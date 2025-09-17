/**
 * \file SDL2.h
 * \brief Header file for SDL2 initialization and cleanup functions.
 *
 * Provides functions to initialize and clean up SDL2, as well as to check if SDL2 is initialized.
 *
 */
#ifndef SDL2_H
#define SDL2_H

#include<SDL2/SDL.h>
#include<SDL2/SDL_image.h>
#include<SDL2/SDL_ttf.h>
#include <stdbool.h>

/**
 * \struct palette_t
 * \brief Structure representing a color in RGBA format.
 * 
 * This structure is used to define colors in the palette with red, green, blue, and alpha components.
 */
typedef struct
{
    Uint8 r; 
    Uint8 g;
    Uint8 b;
    Uint8 a; 
} palette_t;

/**
 * \var SDL2_initialized
 * \brief Global variable to track the initialization status of SDL2.
 * 
 * This variable is set to true when SDL2 is successfully initialized and false otherwise.
 */
extern bool SDL2_initialized; ///< Global variable to track SDL2 initialization status

/**
 * \var global_running
 * \brief Global variable to control the main loop of the application.
 * 
 * This variable is used to determine whether the main loop should continue running or exit.
 */
extern bool global_running; ///< Global variable to control the main loop of the application

/**
 * \var global_window
 * \brief Global variable to store the SDL_Window pointer.
 * 
 * This variable is used to keep track of the SDL_Window created by the application.
 */
extern SDL_Window * global_window; ///< Global variable to store the SDL_Window pointer

/**
 * \var global_renderer
 * \brief Global variable to store the SDL_Renderer pointer.
 * 
 * This variable is used to keep track of the SDL_Renderer created by the application.
 */
extern SDL_Renderer * global_renderer; ///< Global variable to store the SDL_Renderer pointer

/**
 * \var global_event
 * \brief Global variable to store the SDL_Event for event handling.
 * 
 * This variable is used to handle events in the SDL2 application.
 */
extern SDL_Event global_event; ///< Global variable to store the SDL_Event for event handling

/**
 * \var global_window_width
 * \brief Global variable to store the width of the SDL_Window.
 * 
 * This variable is used to keep track of the width of the SDL_Window created by the application.
 */
extern int global_window_width;  ///< Global variable to store the width of the SDL_Window

/**
 * \var global_window_height
 * \brief Global variable to store the height of the SDL_Window.
 * 
 * This variable is used to keep track of the height of the SDL_Window created by the application.
 */
extern int global_window_height; ///< Global variable to store the height of the SDL_Window

/**
 * \var global_window_x
 * \brief Global variable to store the x-coordinate of the SDL_Window.
 * 
 * This variable is used to keep track of the x-coordinate of the SDL_Window created by the application.
 */
extern int global_window_x; ///< Global variable to store the x-coordinate of the SDL_Window position

/**
 * \var global_window_y
 * \brief Global variable to store the y-coordinate of the SDL_Window.
 * 
 * This variable is used to keep track of the y-coordinate of the SDL_Window created by the application.
 */
extern int global_window_y; ///< Global variable to store the y-coordinate of the SDL_Window position

/**
 * \var mouse_x
 * \brief Global variable to store the mouse x-coordinate.
 * 
 * This variable is used to keep track of the current x-coordinate of the mouse cursor.
 */
extern int mouse_x; ///< Global variable to store the mouse x-coordinate

/**
 * \var mouse_y
 * \brief Global variable to store the mouse y-coordinate.
 * 
 * This variable is used to keep track of the current y-coordinate of the mouse cursor.
 */
extern int mouse_y; ///< Global variable to store the mouse y-coordinate


/**
 * \fn bool SDL2_init()
 * \brief Initializes the SDL2 library.
 * 
 * \return true if SDL2 was successfully initialized, false otherwise.
 */
bool SDL2_init();

/**
 * \fn void SDL2_cleanup()
 * \brief Cleans up the SDL2 library.
 * 
 * This function should be called to free resources allocated by SDL2.
 */
void SDL2_cleanup();

/**
 * \fn bool SDL2_is_initialized()
 * \brief Checks if SDL2 is currently initialized.
 * 
 * \return true if SDL2 is initialized, false otherwise.
 */
bool SDL2_is_initialized();

/**
 * \fn void SDL2_handle_error(const char * message)
 * \brief Handles SDL2 errors by printing the error message and exiting the program.
 * 
 * \param message The error message to be printed.
 */
void SDL2_handle_error(const char * message);

/**
 * \fn bool SDL2_create_window(const char * title)
 * \brief Creates an SDL2 window with the specified title and dimensions.
 * 
 * \param title The title of the window.
 * \return true if the window was successfully created, false otherwise.
 */
bool SDL2_create_window(const char * title);

/**
 * \fn bool SDL2_create_renderer()
 * \brief Creates an SDL2 renderer for the global window.
 * 
 * This function initializes the global renderer used for rendering graphics in the SDL2 application.
 * 
 * \return true if the renderer was successfully created, false otherwise.
 */
bool SDL2_create_renderer();

/**
 * \fn void SDL2_set_window_size(int width, int height)
 * \brief Sets the size of the global SDL_Window.
 * 
 * This function updates the dimensions of the global SDL_Window.
 * 
 * \param width The new width of the window.
 * \param height The new height of the window.
 */
void SDL2_set_window_size(int width, int height);

/**
 * \fn void SDL2_set_window_title(const char * title)
 * \brief Sets the title of the global SDL_Window.
 * 
 * This function updates the title of the global SDL_Window.
 * 
 * \param title The new title for the window.
 */
void SDL2_set_window_title(const char * title);

/**
 * \fn void SDL2_set_window_icon(const char * icon_path)
 * \brief Sets the icon of the global SDL_Window.
 * 
 * This function updates the icon of the global SDL_Window using an image file.
 * 
 * \param icon_path The file path to the icon image.
 */
void SDL2_set_window_icon(const char * icon_path);

/**
 * \fn void SDL2_set_window_position(int x, int y)
 * \brief Sets the position of the global SDL_Window.
 * 
 * This function updates the position of the global SDL_Window on the screen.
 * 
 * \param x The new x-coordinate of the window's position.
 * \param y The new y-coordinate of the window's position.
 */
void SDL2_set_window_position(int x, int y);

/**
 * \fn void SDL2_set_window_fullscreen(bool fullscreen)
 * \brief Sets the global SDL_Window to fullscreen mode.
 * 
 * This function toggles the fullscreen mode of the global SDL_Window.
 * 
 * \param fullscreen true to enable fullscreen mode, false to disable it.
 */
void SDL2_set_window_fullscreen(bool fullscreen);

/**
 * \fn void SDL2_set_window_borderless(bool borderless)
 * \brief Sets the global SDL_Window to borderless mode.
 * 
 * This function toggles the borderless mode of the global SDL_Window.
 * 
 * \param borderless true to enable borderless mode, false to disable it.
 */
void SDL2_set_window_borderless(bool borderless);

/**
 * \fn void SDL2_set_window_resizable(bool resizable)
 * \brief Sets the global SDL_Window to be resizable.
 * 
 * This function toggles the resizable property of the global SDL_Window.
 * 
 * \param resizable true to make the window resizable, false to make it fixed size.
 */
void SDL2_set_window_resizable(bool resizable);

/**
 * \fn bool SDL2_is_fullscreen()
 * \brief Checks if the global SDL_Window is in fullscreen mode.
 * 
 * This function returns the current fullscreen status of the global SDL_Window.
 * 
 * \return true if the window is in fullscreen mode, false otherwise.
 */
bool SDL2_is_fullscreen();

/**
 * \fn void SDL2_RenderPresent()
 * \brief Presents the current rendering to the global SDL_Window.
 * 
 * This function updates the global SDL_Window with the current rendering performed by the global renderer.
 */
void SDL2_RenderPresent();

/**
  * \fn void SDL2_draw_rect(int x, int y, int width, int height, palette_t color)
  * \brief Draws a rectangle on the global renderer.
  * 
  * This function draws a filled rectangle at the specified position with the given dimensions and color.
  * 
  * \param x The x-coordinate of the rectangle's top-left corner.
  * \param y The y-coordinate of the rectangle's top-left corner.
  * \param width The width of the rectangle.
  * \param height The height of the rectangle.
  * \param color The color of the rectangle in RGBA format.
  */
void SDL2_draw_rect(int x, int y, int width, int height, palette_t color);

/**
 * \fn void SDL2_draw_line(int x1, int y1, int x2, int y2, palette_t color)
 * \brief Draws a line on the global renderer.
 * 
 * This function draws a line between two points with the specified color.
 * 
 * \param x1 The x-coordinate of the starting point of the line.
 * \param y1 The y-coordinate of the starting point of the line.
 * \param x2 The x-coordinate of the ending point of the line.
 * \param y2 The y-coordinate of the ending point of the line.
 * \param color The color of the line in RGBA format.
 */
void SDL2_draw_line(int x1, int y1, int x2, int y2, palette_t color);

#endif // SDL2_H
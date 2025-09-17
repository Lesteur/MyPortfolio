#include<SDL2/SDL.h>
#include<SDL2/SDL_image.h>
#include<SDL2/SDL_ttf.h>
#include <stdbool.h>
#include "SDL2.h"


bool SDL2_initialized           = false;        ///< Global variable to track SDL2 initialization status
bool global_running             = true;         ///< Global variable to control the main loop of the application
SDL_Window * global_window      = NULL;         ///< Global variable to store the SDL_Window pointer
SDL_Renderer * global_renderer  = NULL;         ///< Global variable to store the SDL_Renderer pointer
SDL_Event global_event;                         ///< Global variable to store the SDL_Event for event handling
int global_window_width         = 800;          ///< Global variable to store the width of the SDL_Window
int global_window_height        = 600;          ///< Global variable to store the height of the SDL_Window
int global_window_x = SDL_WINDOWPOS_UNDEFINED;  ///< Global variable to store the x-coordinate of the SDL_Window position
int global_window_y = SDL_WINDOWPOS_UNDEFINED;  ///< Global variable to store the y-coordinate of the SDL_Window position
int mouse_x = 0;                                ///< Global variable to store the mouse x-coordinate
int mouse_y = 0;                                ///< Global variable to store the mouse y-coordinate

bool SDL2_init()
{
    if (SDL2_is_initialized())
    {
        return true; // SDL2 is already initialized
    }

    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) < 0)
    {
        SDL2_handle_error("Failed to initialize SDL2");
        return false;
    }

    if (IMG_Init(IMG_INIT_PNG | IMG_INIT_JPG) == 0)
    {
        SDL2_handle_error("Failed to initialize SDL2_image");
        SDL_Quit();
        return false;
    }

    if (TTF_Init() == -1)
    {
        SDL2_handle_error("Failed to initialize SDL2_ttf");
        IMG_Quit();
        SDL_Quit();
        return false;
    }

    SDL2_initialized = true;
    return true;
}

bool SDL2_is_initialized()
{
    return SDL2_initialized;
}

void SDL2_cleanup()
{
    if (!SDL2_is_initialized())
    {
        return; // SDL2 is not initialized, nothing to clean up
    }

    if (global_renderer != NULL)
    {
        SDL_DestroyRenderer(global_renderer);
        global_renderer = NULL;
    }

    if (global_window != NULL)
    {
        SDL_DestroyWindow(global_window);
        global_window = NULL;
    }

    TTF_Quit();
    IMG_Quit();
    SDL_Quit();

    SDL2_initialized = false; // Reset the initialization status
}

void SDL2_handle_error(const char * message)
{
    if (message != NULL)
    {
        fprintf(stderr, "SDL2 Error: %s\n", message);
    }

    fprintf(stderr, "SDL2 Error: %s\n", SDL_GetError());
    SDL2_cleanup(); // Clean up resources before exiting
    exit(EXIT_FAILURE); // Exit the program with failure status
}

bool SDL2_create_window(const char * title)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return false;
    }

    global_window = SDL_CreateWindow(title, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, global_window_width, global_window_height, SDL_WINDOW_SHOWN);
    if (global_window == NULL)
    {
        SDL2_handle_error("Failed to create SDL_Window");
        return false;
    }

    global_renderer = SDL_CreateRenderer(global_window, -1, SDL_RENDERER_ACCELERATED);
    if (global_renderer == NULL)
    {
        SDL2_handle_error("Failed to create SDL_Renderer");
        return false;
    }

    return true;
}

bool SDL2_create_renderer()
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return false;
    }

    if (global_renderer != NULL)
    {
        SDL_DestroyRenderer(global_renderer); // Destroy existing renderer if it exists
    }

    global_renderer = SDL_CreateRenderer(global_window, -1, SDL_RENDERER_ACCELERATED);
    if (global_renderer == NULL)
    {
        SDL2_handle_error("Failed to create SDL_Renderer");
        return false;
    }

    return true;
}

void SDL2_set_window_size(int width, int height)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    global_window_width = width;
    global_window_height = height;

    if (global_window != NULL)
    {
        SDL_SetWindowSize(global_window, width, height);
    }
}

void SDL2_set_window_title(const char * title)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_window != NULL)
    {
        SDL_SetWindowTitle(global_window, title);
    }
}

void SDL2_set_window_icon(const char * icon_path)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_window == NULL)
    {
        SDL2_handle_error("SDL_Window is not created");
        return;
    }

    SDL_Surface * icon_surface = IMG_Load(icon_path);
    if (icon_surface == NULL)
    {
        SDL2_handle_error("Failed to load window icon");
        return;
    }

    SDL_SetWindowIcon(global_window, icon_surface);
    SDL_FreeSurface(icon_surface); // Free the surface after setting the icon
}

void SDL2_set_window_position(int x, int y)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_window != NULL)
    {
        SDL_SetWindowPosition(global_window, x, y);

        global_window_x = x; // Update global position variables
        global_window_y = y;

        printf("Window position set to (%d, %d)\n", x, y);
    }
}

void SDL2_set_window_fullscreen(bool fullscreen)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_window != NULL)
    {
        Uint32 flags = fullscreen ? SDL_WINDOW_FULLSCREEN : 0;
        if (SDL_SetWindowFullscreen(global_window, flags) < 0)
        {
            SDL2_handle_error("Failed to set window fullscreen mode");
        }
    }
}

void SDL2_set_window_borderless(bool borderless)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_window != NULL)
    {
        Uint32 flags = borderless ? SDL_WINDOW_BORDERLESS : 0;
        SDL_SetWindowBordered(global_window, flags);
    }
}

void SDL2_set_window_resizable(bool resizable)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_window != NULL)
    {
        Uint32 flags = resizable ? SDL_WINDOW_RESIZABLE : 0;
        SDL_SetWindowResizable(global_window, flags);
    }
}

bool SDL2_is_fullscreen()
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return false;
    }

    if (global_window == NULL)
    {
        SDL2_handle_error("SDL_Window is not created");
        return false;
    }

    Uint32 flags = SDL_GetWindowFlags(global_window);
    return (flags & SDL_WINDOW_FULLSCREEN) != 0;
}

void SDL2_RenderPresent()
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_renderer == NULL)
    {
        SDL2_handle_error("SDL_Renderer is not created");
        return;
    }

    SDL_RenderPresent(global_renderer);
}

void SDL2_draw_rect(int x, int y, int width, int height, palette_t color)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_renderer == NULL)
    {
        SDL2_handle_error("SDL_Renderer is not created");
        return;
    }

    SDL_Rect rect = { x, y, width, height };
    SDL_SetRenderDrawColor(global_renderer, color.r, color.g, color.b, color.a);
    SDL_RenderFillRect(global_renderer, &rect);
}

void SDL2_draw_line(int x1, int y1, int x2, int y2, palette_t color)
{
    if (!SDL2_is_initialized())
    {
        SDL2_handle_error("SDL2 is not initialized");
        return;
    }

    if (global_renderer == NULL)
    {
        SDL2_handle_error("SDL_Renderer is not created");
        return;
    }

    SDL_SetRenderDrawColor(global_renderer, color.r, color.g, color.b, color.a);
    SDL_RenderDrawLine(global_renderer, x1, y1, x2, y2);
}
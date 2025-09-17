#include "Librairies/SDL2.h"
#include "Librairies/sprite.h"

void create_window()
{
    if (!SDL2_create_window("Maze Game"))
    {
        SDL2_handle_error("Failed to create SDL2 window");
    }
}

int main()
{
    if (!SDL2_init())
    {
        SDL2_handle_error("Failed to initialize SDL2");
        return 1;
    }

    create_window();

    // Set the window size
    SDL2_set_window_size(800, 600);

    sprite_t * sprite = sprite_create("../data/graphics/Soldier/Soldier-Idle.png", 100, 100, 100, 100, 6, 100);

    // Loop to test the window
    while (global_running)
    {
        // Handle events
        while (SDL_PollEvent(&global_event))
        {
            switch (global_event.type)
            {
                case SDL_QUIT:
                    // Window close event
                    global_running = false;
                    break;
                case SDL_KEYDOWN:
                    // Key press event
                    switch (global_event.key.keysym.sym)
                    {
                        case SDLK_ESCAPE:
                            // Exit on Escape key
                            global_running = false;
                            break;
                        case SDLK_F4:
                            // Toggle fullscreen mode
                            SDL2_set_window_fullscreen(!SDL2_is_fullscreen());
                            break;
                    }
                    break;
                case SDL_MOUSEBUTTONDOWN:
                    // Mouse button down event
                    mouse_x = global_event.button.x;
                    mouse_y = global_event.button.y;

                    switch (global_event.button.button == SDL_BUTTON_LEFT)
                    {
                        case SDL_BUTTON_LEFT:
                            // Handle left mouse button click
                            printf("Left mouse button clicked at (%d, %d)\n", mouse_x, mouse_y);

                            SDL2_draw_rect(mouse_x - 25, mouse_y - 25, 50, 50, (palette_t){0, 255, 0, 255}); // Green square
                            SDL2_RenderPresent(); // Present the renderer
                            break;
                    }
                    break;
            }
        }

        sprite_render(sprite);

        // Delay to control frame rate
        SDL_Delay(16);
    }

    // Clean up resources
    SDL2_cleanup();

    return 0;
}
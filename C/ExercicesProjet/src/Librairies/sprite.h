/**
 * @file sprite.h
 * @brief Header file for the Sprite class.
 *
 * This file contains the declaration of the Sprite class, which is used to manage
 * and render sprites in a graphical application.
 *
 */
#ifndef SPRITE_H
#define SPRITE_H

#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include <stdbool.h>
#include "SDL2.h"

/**
 * @struct sprite_t
 * @brief Structure representing a sprite.
 *
 * This structure contains information about a sprite, including its texture,
 * destination rectangle, frame dimensions, number of frames, current frame index,
 * frame duration, and the last time the frame was updated.
 *
 */
typedef struct
{
    SDL_Texture * texture;  ///< The texture of the sprite
    SDL_Rect dest_rect;     ///< The destination rectangle on the screen
    int frame_width;        ///< Width of a single frame in the sprite sheet
    int frame_height;       ///< Height of a single frame in the sprite sheet
    int num_frames;         ///< Total number of frames in the sprite sheet
    int current_frame;      ///< Current frame index for animation
    Uint32 frame_duration;  ///< Duration of each frame in milliseconds
    Uint32 last_frame_time; ///< Last time the frame was updated
} sprite_t;

/**
 * @fn sprite_t * sprite_create(const char * image_path, int x, int y, int frame_width, int frame_height, int num_frames, Uint32 frame_duration)
 * @brief Creates a new sprite from an image file.
 *
 * This function loads an image from the specified path and initializes a sprite structure.
 *
 * @param image_path Path to the image file for the sprite.
 * @param x X-coordinate of the sprite's position.
 * @param y Y-coordinate of the sprite's position.
 * @param frame_width Width of a single frame in the sprite sheet.
 * @param frame_height Height of a single frame in the sprite sheet.
 * @param num_frames Total number of frames in the sprite sheet.
 * @param frame_duration Duration of each frame in milliseconds.
 * @return Pointer to the created sprite structure, or NULL on failure.
 */
sprite_t * sprite_create(const char * image_path, int x, int y, int frame_width, int frame_height, int num_frames, Uint32 frame_duration);

/**
 * @fn void sprite_destroy(sprite_t * sprite)
 * @brief Destroys a sprite and frees its resources.
 *
 * This function releases the texture associated with the sprite and frees the sprite structure.
 *
 * @param sprite Pointer to the sprite structure to be destroyed.
 */
void sprite_destroy(sprite_t * sprite);

/**
 * @fn void sprite_render(sprite_t * sprite)
 * @brief Renders the sprite on the screen.
 *
 * This function updates the current frame of the sprite based on the elapsed time
 * and renders it to the global renderer.
 *
 * @param sprite Pointer to the sprite structure to be rendered.
 */
void sprite_render(sprite_t * sprite);

#endif // SPRITE_H
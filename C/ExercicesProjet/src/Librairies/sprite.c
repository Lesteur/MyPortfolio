#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#include <stdbool.h>
#include "SDL2.h"

sprite_t * sprite_create(const char * image_path, int x, int y, int frame_width, int frame_height, int num_frames, Uint32 frame_duration)
{
    sprite_t * sprite = (sprite_t *) malloc(sizeof(sprite_t));
    
    if (!sprite)
        return NULL; // Memory allocation failed

    sprite->texture = IMG_LoadTexture(global_renderer, image_path);
    if (!sprite->texture)
    {
        free(sprite);
        return NULL; // Texture loading failed
    }

    sprite->dest_rect.x = x;
    sprite->dest_rect.y = y;
    sprite->dest_rect.w = frame_width;
    sprite->dest_rect.h = frame_height;
    sprite->frame_width = frame_width;
    sprite->frame_height = frame_height;
    sprite->num_frames = num_frames;
    sprite->current_frame = 0;
    sprite->frame_duration = frame_duration;
    sprite->last_frame_time = SDL_GetTicks();

    return sprite;
}

void sprite_destroy(sprite_t * sprite)
{
    if (sprite)
    {
        if (sprite->texture)
            SDL_DestroyTexture(sprite->texture);
        free(sprite);
    }
}

void sprite_render(sprite_t * sprite)
{
    if (!sprite || !sprite->texture)
        return; // Invalid sprite

    Uint32 current_time = SDL_GetTicks();
    if (current_time - sprite->last_frame_time >= sprite->frame_duration)
    {
        sprite->current_frame = (sprite->current_frame + 1) % sprite->num_frames;
        sprite->last_frame_time = current_time;
    }

    // Set the source rectangle for the current frame
    SDL_Rect src_rect;
    src_rect.x = (sprite->current_frame % (sprite->texture->w / sprite->frame_width)) * sprite->frame_width;
    src_rect.y = (sprite->current_frame / (sprite->texture->w / sprite->frame_width)) * sprite->frame_height;
    src_rect.w = sprite->frame_width;
    src_rect.h = sprite->frame_height;

    // Render the sprite
    SDL_RenderCopy(global_renderer, sprite->texture, &src_rect, &sprite->dest_rect);
}
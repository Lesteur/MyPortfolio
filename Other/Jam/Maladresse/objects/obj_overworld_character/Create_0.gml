/// @description Init Base Player

// State of Character
current_direction = DIRECTIONS.DOWN
current_state = STATES_PLAYER.IDLE
current_sprite = INDEX_SPRITES.DOWN_IDLE

// Floor
number_floor = global.floor
current_floor = layer
tilemap_collision = -1

layer = current_floor
depth = layer_get_depth(current_floor) - y

// Path and lock
path = -1
count = 0

sprite_lock = false
lock = false

//Map for sprites (x, y)
sprites_collection = ds_map_create()
sprites_collection[? INDEX_SPRITES.DOWN_IDLE] = spr_hero_down_idle
sprites_collection[? INDEX_SPRITES.DOWN_WALK] = spr_hero_down_walk
sprites_collection[? INDEX_SPRITES.DOWN_RUN] = spr_hero_down_run

sprites_collection[? INDEX_SPRITES.LEFT_IDLE] = spr_hero_left_idle
sprites_collection[? INDEX_SPRITES.LEFT_WALK] = spr_hero_left_walk
sprites_collection[? INDEX_SPRITES.LEFT_RUN] = spr_hero_left_run

sprites_collection[? INDEX_SPRITES.UP_IDLE] = spr_hero_up_idle
sprites_collection[? INDEX_SPRITES.UP_WALK] = spr_hero_up_walk
sprites_collection[? INDEX_SPRITES.UP_RUN] = spr_hero_up_run

sprites_collection[? INDEX_SPRITES.RIGHT_IDLE] = spr_hero_right_idle
sprites_collection[? INDEX_SPRITES.RIGHT_WALK] = spr_hero_right_walk
sprites_collection[? INDEX_SPRITES.RIGHT_RUN] = spr_hero_right_run


sprites_collection[? INDEX_SPRITES.DOWNLEFT_IDLE] = spr_hero_downleft_idle
sprites_collection[? INDEX_SPRITES.DOWNLEFT_WALK] = spr_hero_downleft_walk
sprites_collection[? INDEX_SPRITES.DOWNLEFT_RUN] = spr_hero_downleft_run

sprites_collection[? INDEX_SPRITES.DOWNRIGHT_IDLE] = spr_hero_downright_idle
sprites_collection[? INDEX_SPRITES.DOWNRIGHT_WALK] = spr_hero_downright_walk
sprites_collection[? INDEX_SPRITES.DOWNRIGHT_RUN] = spr_hero_downright_run

sprites_collection[? INDEX_SPRITES.UPLEFT_IDLE] = spr_hero_upleft_idle
sprites_collection[? INDEX_SPRITES.UPLEFT_WALK] = spr_hero_upleft_walk
sprites_collection[? INDEX_SPRITES.UPLEFT_RUN] = spr_hero_upleft_run

sprites_collection[? INDEX_SPRITES.UPRIGHT_IDLE] = spr_hero_upright_idle
sprites_collection[? INDEX_SPRITES.UPRIGHT_WALK] = spr_hero_upright_walk
sprites_collection[? INDEX_SPRITES.UPRIGHT_RUN] = spr_hero_upright_run

shadow = layer_sprite_create("Shadows_F0", x, y, sprite_index)
layer_sprite_yscale(shadow, -1)
layer_sprite_blend(shadow, c_black)
layer_sprite_alpha(shadow, 0.5)
/// @description Init Base Player

// State of Character
locate = STATES_WORLD.GROUND
player_direction = DIRECTIONS.DOWN

tilemap_collision = layer_tilemap_get_id("Collisions")

depth = -y

// Path and lock
path = -1
count = 0
lock = false
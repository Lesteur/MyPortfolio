#macro GAMEPAD_SUPPORTED gamepad_is_supported()
#macro GAMEPAD_NB_SLOTS gamepad_get_device_count()

// Directions to move
enum DIRECTIONS
{
	DOWN = 0,
	LEFT = 1,
	RIGHT = 2,
	UP = 3,
	DOWNLEFT = 4,
	DOWNRIGHT = 5,
	UPLEFT = 6,
	UPRIGHT = 7
}

// States Player
enum STATES_PLAYER
{
	IDLE = 0,
	WALK = 1,
	RUN = 2,
	JUMP = 3,
	CLIMB = 4
}

// States Overworld
enum STATES_WORLD
{
	GROUND = 0,
	WALL = 1
}

// Input
enum INPUT
{
	CONFIRM,
	BACK,
	MENU,
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

// Mappages des actions
global.input_map = ds_map_create()

global.input_map[? INPUT.CONFIRM] = { key: vk_space, gamepad: gp_face1 }
global.input_map[? INPUT.BACK] = { key: ord("X"), gamepad: gp_face2 }
global.input_map[? INPUT.MENU] = { key: ord("C"), gamepad: gp_face3 }
global.input_map[? INPUT.UP] = { key: vk_up, gamepad: gp_padu }
global.input_map[? INPUT.DOWN] = { key: vk_down, gamepad: gp_padd }
global.input_map[? INPUT.LEFT] = { key: vk_left, gamepad: gp_padl }
global.input_map[? INPUT.RIGHT] = { key: vk_right, gamepad: gp_padr }


global.objets_by_floor = ds_map_create()

global.floor = 0
global.lock = 0

global.timegame = 0
global.current_view = 0

global.autorun = true

global.default_font = fnt_glasstown
global.default_scale_font = 1.5

global.gamepad_index = 0

draw_set_font(global.default_font)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
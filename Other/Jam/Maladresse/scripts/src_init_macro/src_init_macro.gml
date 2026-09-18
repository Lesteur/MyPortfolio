#macro GAMEPAD_NB_SLOTS gamepad_get_device_count()
#macro PLATFORM_PC (os_type == os_windows || os_type == os_macosx || os_type == os_linux || os_type == os_operagx)
#macro PLATFORM_CONSOLE (os_type == os_switch || os_type == os_ps4 || os_type == os_ps5 || os_type == os_xboxseriesxs || os_type == os_xboxone)

#macro FPS 60

// Directions to move
enum DIRECTIONS
{
	DOWN,
	LEFT,
	UP,
	RIGHT,
	
	DOWNLEFT,
	DOWNRIGHT,
	UPLEFT,
	UPRIGHT
}

// States Player
enum STATES_PLAYER
{
	IDLE,
	WALK,
	RUN,
	JUMP,
	CLIMB
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
	// General
	CONFIRM,
	BACK,
	MENU,
	UP,
	DOWN,
	LEFT,
	RIGHT,
	
	// Battle
	BATTLE1,
	BATTLE2
}

// Menu Battle
enum BATTLE_MENU
{
	CHOOSE_PARTYMEMBER,
	CHOOSE_ACTION,
	CHOOSE_SKILL,
	CHOOSE_ITEM,
	CHOOSE_TARGET
}

enum TYPE_TARGET
{
	NONE,
	SINGLE_ENEMY,
	SINGLE_ALLY,
	ALL_ENEMIES,
	ALL_ALLIES,
	SINGLE_ALLY_EXCEPT_LAUNCHER,
	EVERYONE,
	FAINTED,
	ALL_FAINTED,
}

enum USABLE_IN
{
	NONE,
	ALL,
	BATTLE,
	OVERWORLD
}

enum SITUATION_BATTLE
{
	ALLIES_TURN,
	ENEMIES_TURN
}

enum NATURE_ATTACK
{
	PHYSICAL,
	MAGIC,
	STATUS
}

enum TYPE_ATTACK
{
	NONE,
	SLASHING,
	PIERCING,
	BLUNTING,
	FIRE,
	ICE,
	LIGHTNING,
	WATER,
	WIND,
	EARTH,
	LIGHT,
	DARK
}

enum REACTION_ATTACK
{
	MULTIPLIER_DAMAGE,
	ABSORB_DAMAGE,
	ADD_SHOCK_POINT,
	ADD_BOOST_ATTACK,
	ADD_BOOST_DEFENSE,
	ADD_BOOST_SPECIAL_ATTACK,
	ADD_BOOST_SPECIAL_DEFENSE,
	ADD_STATUS
}

enum STATS_BATTLE
{
	HP,
	SP,
	ATTACK,
	SPECIAL_ATTACK,
	DEFENSE,
	SPECIAL_DEFENSE
}

global.collections_items = array_create(100)

// Actions mapping
global.input_map = ds_map_create()
global.input_map[? INPUT.CONFIRM] = { key: vk_space, gamepad: gp_face1 }
global.input_map[?	  INPUT.BACK] = { key: ord("X"), gamepad: gp_face2 }
global.input_map[?	  INPUT.MENU] = { key: ord("C"), gamepad: gp_face3 }
global.input_map[?		INPUT.UP] = { key: vk_up,	 gamepad: gp_padu }
global.input_map[?	  INPUT.DOWN] = { key: vk_down,  gamepad: gp_padd }
global.input_map[?	  INPUT.LEFT] = { key: vk_left,  gamepad: gp_padl }
global.input_map[?   INPUT.RIGHT] = { key: vk_right, gamepad: gp_padr }

global.input_map[? INPUT.BATTLE1] = { key: vk_space,  gamepad: gp_face1 }
global.input_map[? INPUT.BATTLE2] = { key: ord("X"), gamepad: gp_face2 }

global.axis_pressed = [0, 0, 0, 0]

// System Parameters
global.floor = 0
global.lock = 0
global.timegame = 0
global.current_view = 0
global.objets_by_floor = ds_map_create()

// General Parameters
global.autorun = false

// Font Parameters
global.default_font = fnt_glasstown
global.default_scale_font = 1.5

// Gamepad Parameters
global.gamepad_control = false
global.gamepad_index = -1

// Battle Parameters
global.battle_in_progress = false
global.successful_attack = true
global.battle_situation = 0

global.team = [0]

// Setting Parameters
draw_set_font(global.default_font)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
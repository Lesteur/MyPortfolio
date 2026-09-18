/// @description Init Base Battler

// Inherit the parent event
event_inherited()

// Floor
update_floor()

// Origin coordinates
xbegin = x
ybegin = y

xbegin2 = x
ybegin2 = y

spd = 10
spd_count = 0

xmove = -1
ymove = -1

xdest = -1
ydest = -1

// Base

name = "Combattant"

// Stats

// HP
hp_max = 100
hp = 100

// Attack
attack = 10
special_attack = 8

// Defense
defense = 10
special_defense = 8

shock_points = 0
shock_turn_left = 0

// Affinities
map_affinities = ds_map_create()
map_affinities_shock = ds_map_create()

// Skills
list_skills = ds_list_create()

// Boost stats
map_boost_stats = ds_map_create()
map_boost_stats[? STATS_BATTLE.ATTACK] = 0
map_boost_stats[? STATS_BATTLE.SPECIAL_ATTACK] = 0
map_boost_stats[? STATS_BATTLE.DEFENSE] = 0
map_boost_stats[? STATS_BATTLE.SPECIAL_DEFENSE] = 0

limit_boost = 3

// Cutscene
cutscene = noone

// Shake effects
is_shaking = false
timer_shake = -1

// Parameters hurt attack
real_damage = -1
attacker = noone
nature = -1
type1 = -1
type2 = -1

count_hit = 0
misc_hit = {}

timer = 0

int_damage = -1

sprites_collection[? INDEX_SPRITES.FIGHT_IDLE] = spr_boy_fight_idle
sprites_collection[? INDEX_SPRITES.FIGHT_WEAK] = spr_boy_fight_idle
sprites_collection[? INDEX_SPRITES.FIGHT_ATTACK] = spr_boy_fight_attack
sprites_collection[? INDEX_SPRITES.FIGHT_HURT] = spr_boy_fight_hurt
sprites_collection[? INDEX_SPRITES.FIGHT_FAINTED] = spr_boy_fight_fainted

current_sprite = INDEX_SPRITES.FIGHT_IDLE
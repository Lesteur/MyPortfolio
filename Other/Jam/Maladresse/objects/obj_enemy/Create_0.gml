/// @description Init Base Enemy

event_inherited()

// Base

name = "Ennemi"

// Stats

// HP
hp_max = 300
hp = 300

// Attack
attack = 40
special_attack = 35

// Defense
defense = 10
special_defense = 8

// Shock points
shock_multiplier = 1
shock_points = 0
resistance_shock = 5

// Shock turns
shock_turn_max = 2
shock_turn_left = 0

ds_map_add(map_affinities, TYPE_ATTACK.SLASHING, [REACTION_ATTACK.ADD_SHOCK_POINT, 1])

ds_map_add(map_affinities_shock, TYPE_ATTACK.SLASHING, [REACTION_ATTACK.MULTIPLIER_DAMAGE, 2])

ds_list_add(list_skills, new SkillEnemy())
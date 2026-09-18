/// @description Init Damage Received

// Inherit the parent event
event_inherited()

if shock_turn_left > 0
	real_damage = real_damage * shock_multiplier

if shock_points >= resistance_shock
{
	shock_points = 0
	shock_turn_left = shock_turn_max
}
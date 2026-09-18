/// @description Init Damage Received

var _defense
var _bonus_damage = 0
var _array = [type1, type2]
var _reaction
var _parameter

for (var _i = 0; _i < 2; _i ++)
{
	var _element = _array[_i]
	
	if ds_map_exists(map_affinities, _element)
	{
		if shock_turn_left > 0
		{
			_reaction = map_affinities_shock[? _element][0]
			_parameter = map_affinities_shock[? _element][1]
		} else {
			_reaction = map_affinities[? _element][0]
			_parameter = map_affinities[? _element][1]
		}
		
		var _stat = -1
		
		
		var _total_damage = real_damage
		
		switch _reaction
		{
			case REACTION_ATTACK.MULTIPLIER_DAMAGE:
				_bonus_damage += (_parameter - 1) * _total_damage //real_damage += (_parameter - 1) * _total_damage
				break
			case REACTION_ATTACK.ABSORB_DAMAGE:
				_bonus_damage -= (_parameter * _total_damage) //real_damage -= _parameter * _total_damage
				break
			case REACTION_ATTACK.ADD_SHOCK_POINT:
				shock_points += _parameter
				break
			case REACTION_ATTACK.ADD_BOOST_ATTACK:
				_stat = map_boost_stats[? STATS_BATTLE.ATTACK] + _parameter
				
				if _stat <= limit_boost
					map_boost_stats[? STATS_BATTLE.ATTACK] = _stat
				
				break
			case REACTION_ATTACK.ADD_BOOST_SPECIAL_ATTACK:
				_stat = map_boost_stats[? STATS_BATTLE.SPECIAL_ATTACK] + _parameter
				
				if _stat <= limit_boost
					map_boost_stats[? STATS_BATTLE.SPECIAL_ATTACK] = _stat
				
				break
			case REACTION_ATTACK.ADD_BOOST_DEFENSE:
				_stat = map_boost_stats[? STATS_BATTLE.DEFENSE] + _parameter
				
				if _stat <= limit_boost
					map_boost_stats[? STATS_BATTLE.DEFENSE] = _stat
				
				break
			case REACTION_ATTACK.ADD_BOOST_SPECIAL_DEFENSE:
				_stat = map_boost_stats[? STATS_BATTLE.SPECIAL_DEFENSE] + _parameter
				
				if _stat <= limit_boost
					map_boost_stats[? STATS_BATTLE.SPECIAL_DEFENSE] = _stat
				
				break
		}
	}
}


if nature == NATURE_ATTACK.PHYSICAL
	_defense = (defense * (1 + map_boost_stats[? STATS_BATTLE.DEFENSE] * 0.5)) //real_damage = real_damage / (defense * (1 + map_boost_stats[? STATS_BATTLE.DEFENSE] * 0.5) )
else
	_defense = (special_defense * (1 + map_boost_stats[? STATS_BATTLE.SPECIAL_DEFENSE] * 0.5)) //real_damage = real_damage / (special_defense * (1 + map_boost_stats[? STATS_BATTLE.SPECIAL_DEFENSE] * 0.5) )

real_damage = (real_damage + _bonus_damage) / _defense
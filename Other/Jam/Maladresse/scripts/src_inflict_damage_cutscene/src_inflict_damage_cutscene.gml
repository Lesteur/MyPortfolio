/// @function													cutscene_inflict_damage(attacker, target, power, nature, type1, type2, misc)
/// @description												Make inflict some damage to the target.
/// @param {Id.Instance}						attacker		The attacker.
/// @param {Id.Instance}						target			The target.
/// @param {Real}								power			The power of the attack to inflict.
/// @param {Real}								nature			The nature of the attack.
/// @param {Real}								type1			The first type of the attack.
/// @param {Real}								type2			The second type of the attack.
/// @param {Struct}								misc			Misc for some parameters.
/// @self														obj_cutscene

function cutscene_inflict_damage(_attacker, _target, _power, _nature, _type1 = TYPE_ATTACK.NONE, _type2 = TYPE_ATTACK.NONE, _misc = {})
{
	var _f = function(_attacker, _target, _power, _nature, _type1 = TYPE_ATTACK.NONE, _type2 = TYPE_ATTACK.NONE, _misc = {})
	{
		var _damage
		if _nature == NATURE_ATTACK.PHYSICAL
			_damage = _power * _attacker.attack * (1 + _attacker.map_boost_stats[? STATS_BATTLE.ATTACK] * 0.5)
		else
			_damage = _power * _attacker.special_attack * (1 + _attacker.map_boost_stats[? STATS_BATTLE.SPECIAL_ATTACK] * 0.5)
		
		with _target
		{
			attacker = _attacker
			real_damage = _damage
			nature = _nature
			type1 = _type1
			type2 = _type2
			misc_hit = _misc
			
			event_user(0)
			event_user(1)
		}
	
		next_cutscene()
	
		return 0
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_attacker, _target, _power, _nature, _type1, _type2, _misc])
}
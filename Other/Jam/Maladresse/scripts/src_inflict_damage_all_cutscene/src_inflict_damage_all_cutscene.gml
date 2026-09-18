/// @function													cutscene_inflict_all_damage(attacker, target, power, nature, type1, type2, misc)
/// @description												Make inflict some damage to many targets.
/// @param {Id.Instance}						attacker		The attacker.
/// @param {Id.Instance}						target			The array of targets.
/// @param {Real}								power			The power of the attack to inflict.
/// @param {Real}								nature			The nature of the attack.
/// @param {Real}								type1			The first type of the attack.
/// @param {Real}								type2			The second type of the attack.
/// @param {Struct}								misc			Misc for some parameters.
/// @self														obj_cutscene

function cutscene_inflict_all_damage(_attacker, _target, _power, _nature, _type1 = TYPE_ATTACK.NONE, _type2 = TYPE_ATTACK.NONE, _misc = {})
{
	if reset
		return -1
	
	for (var _i = 0; _i < array_length(_target); _i++)
	{
		cutscene_inflict_damage(_attacker, _target[_i], _power, _nature, _type1, _type2, _misc)
	}
}
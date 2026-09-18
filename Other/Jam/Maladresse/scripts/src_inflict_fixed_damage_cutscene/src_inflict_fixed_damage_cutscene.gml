/// @function													cutscene_inflict_fixed_damage(attacker, target, damage, misc)
/// @description												Make inflict a fixed amount of damage to the target.
/// @param {Id.Instance}						attacker		The attacker.
/// @param {Id.Instance}						target			The target.
/// @param {Real}								damage			The damages to inflict.
/// @param {Struct}								misc			Misc for some parameters.
/// @self														obj_cutscene

function cutscene_inflict_fixed_damage(_attacker, _target, _damage, _misc = {})
{
	var _f = function(_attacker, _target, _damage, _misc = {})
	{
		with _target
		{
			attacker = _attacker
			real_damage = _damage
			misc_hit = _misc
			
			event_user(1)
		}
	
		next_cutscene()
	
		return 0
	}
	
	if reset
		return -1
	
	add_cutscene(_f, [_attacker, _target, _damage, _misc])
}
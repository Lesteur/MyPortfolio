/// @function						enemy_turn()
/// @description					Control enemies.
/// @param  {Id.Instance}	enemy	Enemy to control.
/// @self							obj_battle_manager

function enemy_turn(_enemy)
{
	is_acting = true
	
	if _enemy.shock_turn_left > 0
	{
		_enemy.shock_turn_left --
		
		if _enemy.shock_turn_left > 0
		{
			end_turn = true
			return
		}
	}
	
	var _group = front_line
	
	var _skill_number
	_skill_number = irandom(ds_list_size(_enemy.list_skills) - 1)
	
	var _skill
	_skill = _enemy.list_skills[| _skill_number]
	
	var _target_number
	_target_number = irandom(array_length(_group) - 1)
	
	var _target
	_target = _group[_target_number]
	
	cutscene = create_cutscene(_skill.skill_cast_battle, [_enemy, _target])
	
	global.successful_attack = true
}
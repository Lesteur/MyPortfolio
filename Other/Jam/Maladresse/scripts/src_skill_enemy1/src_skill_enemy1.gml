function SkillEnemy() : Skill() constructor
{
	static name = "Compétence 1 d'Ennemi 000"
	
	static type_target = TYPE_TARGET.SINGLE_ENEMY
	
	static allies_needed = []
	
	static skill_cast_battle = function(_attacker, _target)
	{
		_attacker = get_character_cutscene(_attacker)
		
		var _x = _attacker.x
		var _y = _attacker.y
	
		cutscene_wait( cutscene_move_to_marker(_attacker, _target, 1, 50, 0) )
	
		cutscene_set_animation(_attacker, spr_kris_attack1, 0, 0)
		cutscene_wait(0.5)
		cutscene_set_animation(_attacker, spr_kris_attack1, 1, 0)
		cutscene_wait_animation(_attacker, true)
	
		cutscene_inflict_damage(_attacker, _target, 10, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING,, {fatal : true})
	
		cutscene_set_animation(_attacker, spr_kris_attack2, 1, 0)
		cutscene_wait_animation(_attacker, true)
		cutscene_wait(1)
	
		cutscene_wait( cutscene_move_to(_attacker, _x, _y, false, 1) )
	
		cutscene_end_skill()
	}
	
}
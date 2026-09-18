function MultiAttack() : Skill() constructor
{
	static name = "Multi-Coup"
	
	static description = "Attaque tous les ennemis.#Peut attaquer jusqu'à trois fois."
	
	static sp_cost = 7
	
	static type_target = TYPE_TARGET.ALL_ENEMIES
	
	static allies_needed = []
	
	static tags = []
	
	static usable_in = USABLE_IN.BATTLE
	
	static skill_cast_battle = function(_attacker, _target)
	{
		_attacker = get_character_cutscene(_attacker)
		
		var _x = _attacker.xbegin2
		var _y = _attacker.ybegin2
	
		cutscene_wait( cutscene_move_to(_attacker, 10, 0, true, 0.5) )
	
		cutscene_set_sprite_scale(_attacker, -1, 0)
		cutscene_set_animation(_attacker, spr_kris_attack1, 1, 0)
		cutscene_wait_animation(_attacker, true)
	
		var _n1 = irandom(70)
		var _timing1 = cutscene_make_timing1(_n1, _n1 + 30)
		
		if _timing1
		{
			cutscene_inflict_all_damage(_attacker, _target, 20, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING)
			
			cutscene_set_animation(_attacker, spr_kris_attack2, 1, 0)
			cutscene_wait_animation(_attacker, true)
			
			var _n2 = irandom(80)
			var _timing2 = cutscene_make_timing1(_n2, _n2 + 20)
			
			if _timing2
			{
				cutscene_inflict_all_damage(_attacker, _target, 20, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING)
			
				cutscene_set_animation(_attacker, spr_kris_attack2, 1, 0)
				cutscene_wait_animation(_attacker, true)
				
				var _n3 = irandom(90)
				var _timing3 = cutscene_make_timing1(_n3, _n3 + 10)
				
				if _timing3
					cutscene_inflict_all_damage(_attacker, _target, 20, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING,, {fatal : true})
				else
					cutscene_inflict_all_damage(_attacker, _target, 10, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING,, {fatal : true})
					
			} else {
				cutscene_inflict_all_damage(_attacker, _target, 10, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING,, {fatal : true})
			}
		} else {
			cutscene_inflict_all_damage(_attacker, _target, 10, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING,, {fatal : true})
		}
		
		cutscene_set_animation(_attacker, spr_kris_attack2, 1, 0)
		cutscene_wait_animation(_attacker, true)
		
		cutscene_wait(1)
	
		cutscene_set_sprite_scale(_attacker, 1, 0)
		cutscene_wait( cutscene_move_to(_attacker, _x, _y, false, 0.5) )
		
		cutscene_end_skill()
	}
	
}
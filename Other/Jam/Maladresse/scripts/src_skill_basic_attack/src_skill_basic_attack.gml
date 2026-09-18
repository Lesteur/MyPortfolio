function BasicAttack() : Skill() constructor
{
	static name = "Attaque"
	
	static description = "Attaque de base.#Peut attaquer jusqu'à trois fois."
	
	static sp_cost = 0
	
	static type_target = TYPE_TARGET.SINGLE_ENEMY
	
	static allies_needed = []
	
	static tags = []
	
	static usable_in = USABLE_IN.BATTLE
	
	static skill_cast_battle = function(_attacker, _target)
	{
		_attacker = get_character_cutscene(_attacker)
		
		var _x = _attacker.xbegin2
		var _y = _attacker.ybegin2
	
		cutscene_wait( cutscene_move_to_marker(_attacker, _target, 1, -50, 0) )
	
		cutscene_set_animation(_attacker, spr_boy_fight_idle, 1, 0)
		cutscene_wait_animation(_attacker, true)
	
		var _n1 = irandom(70)
		var _timing1 = cutscene_make_timing1(_n1, _n1 + 30)
		
		if _timing1
		{
			cutscene_inflict_damage(_attacker, _target, 20, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING)
			
			cutscene_set_animation(_attacker, spr_boy_fight_attack, 1, 0)
			cutscene_wait_animation(_attacker, true)
			
			var _n2 = irandom(80)
			var _timing2 = cutscene_make_timing1(_n2, _n2 + 20)
			
			if _timing2
			{
				cutscene_inflict_damage(_attacker, _target, 20, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING)
				
				cutscene_set_animation(_attacker, spr_boy_fight_attack, 1, 0)
				cutscene_wait_animation(_attacker, true)
				
				var _n3 = irandom(90)
				var _timing3 = cutscene_make_timing1(_n3, _n3 + 10)
				
				if _timing3
					cutscene_inflict_damage(_attacker, _target, 20, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING,, {fatal : true})
				else
					cutscene_inflict_damage(_attacker, _target, 10, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING,, {fatal : true})
					
			} else {
				cutscene_inflict_damage(_attacker, _target, 10, NATURE_ATTACK.PHYSICAL, TYPE_ATTACK.SLASHING,, {fatal : true})
			}
		} else {
			var _xx = _target.x - 50, _yy = _target.y
			var _sword = cutscene_create_object(_xx, _yy, obj_sword)
			
			cutscene_set_animation(_attacker, spr_boy_fight_hurt)
			
			cutscene_wait( cutscene_move_to(_sword, _xx + 10,  _yy - 50, false, 0.5) )
			cutscene_wait( cutscene_move_to(_sword,		 _xx, _yy - 100, false, 0.5) )
			cutscene_wait( cutscene_move_to(_sword, _xx - 10,  _yy - 50, false, 0.5) )
			cutscene_wait( cutscene_move_to(_sword,		 _xx,		_yy, false, 0.5) )
			
			cutscene_destroy_object(_sword)
		}
		
		cutscene_set_animation(_attacker, spr_boy_fight_attack, 1, 0)
		cutscene_wait_animation(_attacker, true)
		
		cutscene_wait(1)
	
		cutscene_wait( cutscene_move_to(_attacker, _x, _y, false, 1) )
		
		cutscene_end_skill()
	}
	
}
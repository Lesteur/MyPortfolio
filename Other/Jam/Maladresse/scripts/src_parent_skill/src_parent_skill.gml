function Skill() constructor
{
	static name = "Basic Attack"
	
	static description = "Use a normal attack."
	
	static sp_cost = 0
	
	static type_target = TYPE_TARGET.SINGLE_ENEMY
	
	static allies_needed = []
	
	static tags = []
	
	static usable_in = USABLE_IN.BATTLE
	
	static skill_cast_battle = function(_launcher, _target)
	{
		cutscene_inflict_damage(_launcher, _target, 10, NATURE_ATTACK.PHYSICAL)
		
		cutscene_wait(2)
		cutscene_end_skill()
	}
	
	static skill_cast_overworld = function(_launcher, _target) { }
	
	static get_name = function() { return name }
	
	static get_description = function() { return description }
	
	static get_sp_cost = function() { return sp_cost }
	
	static get_type_target = function() { return type_target }
	
	static get_allies_needed = function() { return allies_needed }
	
	static get_tags = function() { return tags }
	
	static get_usable_in = function() { return usable_in }
}
function ItemHealPotion() : Item() constructor
{
	static name = "Potion de vie"
	
	static description = "Restore some HP."
	
	static can_sell = true
	
	static price = 10
	
	static type_target = TYPE_TARGET.SINGLE_ALLY
	
	static tags = []
	
	static usable_in = USABLE_IN.ALL
	
	static skill_cast_battle = function(_attacker, _target)
	{
		cutscene_inflict_fixed_damage(_attacker, _target, -50)
		
		cutscene_wait(2)
		cutscene_end_skill()
	}
	
	static skill_cast_overworld = function(_attacker, _target) { }
}

#macro ITEM_HEAL_POTION 1

global.collections_items[ITEM_HEAL_POTION] = new ItemHealPotion()
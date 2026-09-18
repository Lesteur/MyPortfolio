function Item() constructor
{
	static name = "-----"
	
	static description = "-----"
	
	static amount = 0
	
	static can_sell = true
	
	static price = 10
	
	static type_target = TYPE_TARGET.SINGLE_ALLY
	
	static tags = []
	
	static usable_in = USABLE_IN.ALL
	
	static result_item = noone
	
	static instant_consumed = true
	
	static skill_cast_battle = function(_attacker, _target)
	{
		cutscene_inflict_fixed_damage(_attacker, _target, -30)
		
		cutscene_wait(2)
		cutscene_end_skill()
	}
	
	static skill_cast_overworld = function(_attacker, _target) { }
	
	static get_name = function() { return name }
	
	static get_description = function() { return description }
	
	static get_amount = function() { return amount }
	
	static get_can_sell = function() { return can_sell }
	
	static get_price = function() { return price }
	
	static get_type_target = function() { return type_target }
	
	static get_tags = function() { return tags }
	
	static get_usable_in = function() { return usable_in }
	
	static get_result_item = function() { return result_item }
	
	static get_instant_consumed = function() { return instant_consumed }
}

#macro ITEM_BASIC_ITEM 0

global.collections_items[ITEM_BASIC_ITEM] = new Item()
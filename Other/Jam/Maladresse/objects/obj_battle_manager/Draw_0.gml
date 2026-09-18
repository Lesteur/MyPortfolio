/// @description Draw

if !is_acting
{
	if is_allies_turn
	{
		
		//show_debug_message(current_back_line_number)
		//show_debug_message(back_line)
		
		var _character
		
		if ds_stack_top(history_menu) == BATTLE_MENU.CHOOSE_PARTYMEMBER
			_character = back_line[current_back_line_number]
		else
			_character = partymembers_array[current_character_number]
		
		var _xx = _character.x + 25, _yy = _character.y - 40
		var _size = 0
		var _width = 150
		
		switch ds_stack_top(history_menu)
		{
			case BATTLE_MENU.CHOOSE_PARTYMEMBER:
				#region Choose a party member to fight
			
				draw_sprite(spr_cursor_battle, 0, _character.x - 20, _character.y - 20)
			
				break
				#endregion
			case BATTLE_MENU.CHOOSE_ACTION:
				#region Choose an action to use
			
				draw_sprite_stretched(spr_hui_fight, 0, _xx, _yy, _width, 15 + 14 * 3)
				
				draw_text_shadow(_xx + 10, _yy + 22, "Compétences")
				
				if global.normal_items.size_items() > 0
					draw_text_shadow(_xx + 10, _yy + 22 + 14, "Objets")
				else
					draw_text_shadow(_xx + 10, _yy + 22 + 14, "Objets", c_grey)
				
				draw_text_shadow(_xx + 10, _yy + 22 + 28, "Fuite")
			
				draw_sprite(spr_cursor_battle, 0, _xx, _yy + 15 + current_action * 14)
			
				break
				#endregion
			case BATTLE_MENU.CHOOSE_SKILL:
				#region Choose a skill to use
				
				_size = ds_list_size(_character.list_skills)
				
				draw_sprite_stretched(spr_hui_fight, 0, _xx, _yy, _width, 15 + 14 * _size)
				
				for (var _i = 0; _i < _size; _i ++)
				{
					var _skill = _character.list_skills[| _i]
					var _sp = _skill.get_sp_cost()
					var _color = c_white
					
					if _sp > _character.sp
						_color = c_grey
					
					draw_set_halign(fa_left)
					draw_text_shadow(_xx + 10, _yy + 22 + 14 * _i, _skill.get_name(), _color)
					
					if (_sp > 0)
					{
						draw_set_halign(fa_right)
						draw_text_shadow(_xx + _width - 10, _yy + 22 + 14 * _i, string(_sp) + " SP", _color)
					}
				}
				draw_set_halign(fa_left)
				draw_sprite(spr_cursor_battle, 0, _xx, _yy + 15 + current_skill_number * 14)
			
				break
				#endregion
			case BATTLE_MENU.CHOOSE_ITEM:
				#region Choose an item to use
				
				_size = global.normal_items.size_items()
				
				draw_sprite_stretched(spr_hui_fight, 0, _xx, _yy, _width, 15 + 14 * _size)
				
				for (var _i = 0; _i < _size; _i ++)
				{
					var _item = global.collections_items[ global.normal_items.get_index_item(_i) ]
					
					draw_set_halign(fa_left)
					draw_text_shadow(_xx + 10, _yy + 22 + 14 * _i, _item.get_name())
					
					draw_set_halign(fa_right)
					draw_text_shadow(_xx + _width - 10, _yy + 22 + 14 * _i, string(_item.get_amount()))
				}
				draw_set_halign(fa_left)
				draw_sprite(spr_cursor_battle, 0, _xx, _yy + 15 + current_item_number * 14)
			
				break
				#endregion
			case BATTLE_MENU.CHOOSE_TARGET:
				#region Choose a target
				
				if all_target
				{
					for (var _i = 0; _i < array_length(target_array); _i++)
					{
						var _target = target_array[_i]
						draw_sprite(spr_cursor_battle, 0, _target.x - 20, _target.y - 20)
					}
				} else {
					var _target = target_array[current_target]
					draw_sprite(spr_cursor_battle, 0, _target.x - 20, _target.y - 20)
				}
			
				break
				#endregion
		}
	}
}
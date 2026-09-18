/// @function		party_turn()
/// @description	Control the heroes in battles.
/// @self			obj_battle_manager

function party_turn()
{
	switch ds_stack_top(history_menu)
	{
		case BATTLE_MENU.CHOOSE_PARTYMEMBER:
			#region Choose a party member to fight
			
			// Select the character
			//current_character_number = select_choice(current_character_number, array_length(partymembers_array), true)
			
			current_back_line_number = select_choice(current_back_line_number, array_length(back_line), true)
			
			// Skip 
			if input_check_pressed(INPUT.MENU) && (array_length(front_line) >= 1)
			{
				is_acting = true
				end_turn = true
				
				turn_allies = turn_allies_max
			}
			
			// Pass to choose an action
			if input_check_pressed(INPUT.CONFIRM)
			{
				var _partymember = back_line[current_back_line_number] //partymembers_array[current_character_number]
				
				current_character_number = array_get_index(partymembers_array, _partymember)
				
				if !_partymember.chosen
				{
					current_character = _partymember
					
					ds_stack_push(history_menu, BATTLE_MENU.CHOOSE_ACTION)
					
					array_push(front_line, current_character)
					
					var _length = array_length(front_line) - 1
					
					with _partymember
					{
						xdest = 200 + _length * 15
						ydest = 150 + _length * 50
						
						event_user(3)
					}
				}
			}
			break
			#endregion
		case BATTLE_MENU.CHOOSE_ACTION:
			#region Choose an action to use
			
			// Select the action
			current_action = select_choice(current_action, 3, true)
			
			// Confirm the choice
			if input_check_pressed(INPUT.CONFIRM)
			{
				switch current_action
				{
					case 0:
						// Pass to choose a skill
						ds_stack_push(history_menu, BATTLE_MENU.CHOOSE_SKILL)
						break
					case 1:
						// Pass to choose an item
						if global.normal_items.size_items() > 0
							ds_stack_push(history_menu, BATTLE_MENU.CHOOSE_ITEM)
						break
				}
			}
			break
			#endregion
		case BATTLE_MENU.CHOOSE_SKILL:
			#region Choose a skill to use
			
			// Select the skill
			current_skill_number = select_choice(current_skill_number, ds_list_size(current_character.list_skills), true)
			
			// Confirm the skill
			if input_check_pressed(INPUT.CONFIRM)
			{
				var _sp = current_character.list_skills[| current_skill_number].get_sp_cost()
				
				if (current_character.sp >= _sp)
				{
					current_skill = current_character.list_skills[| current_skill_number]
				
					// Check the type of target
					var _array = []
					switch current_skill.get_type_target()
					{
						case TYPE_TARGET.SINGLE_ENEMY:
							// Only one enemy
							all_target = false
							_array = enemies_array
							break
						case TYPE_TARGET.SINGLE_ALLY:
							// Only one ally
							all_target = false
							_array = partymembers_array
							break
						case TYPE_TARGET.ALL_ENEMIES:
							// All enemies
							all_target = true
							_array = enemies_array
							break
						case TYPE_TARGET.ALL_ALLIES:
							// All allies
							all_target = true
							_array = partymembers_array
							break
						case TYPE_TARGET.SINGLE_ALLY_EXCEPT_LAUNCHER:
							// Only one ally but not the launcher
							all_target = false
							for (var _i = 0; _i < array_length(partymembers_array); _i ++)
							{
								if _i != current_character_number
									array_push(_array, partymembers_array[_i])
							}
							break
						case TYPE_TARGET.EVERYONE:
							// All battlers
							all_target = true
							array = array_concat(partymembers_array, enemies_array)
							break
						case TYPE_TARGET.FAINTED:
							// One fainted ally
							all_target = false
							for (var _i = 0; _i < array_length(partymembers_array); _i ++)
							{
								if partymembers_array[_i].hp == 0
									array_push(_array, partymembers_array[_i])
							}
							break
						case TYPE_TARGET.ALL_FAINTED:
							// All fainted allies
							all_target = true
							for (var _i = 0; _i < array_length(partymembers_array); _i ++)
							{
								if partymembers_array[_i].hp == 0
									array_push(_array, partymembers_array[_i])
							}
							break
					}
				
					target_array = _array
				
					function_to_use = current_skill.skill_cast_battle
					item_used = false
				
					// Pass to choose a target
					ds_stack_push(history_menu, BATTLE_MENU.CHOOSE_TARGET)
				}
			}
			break
			#endregion
		case BATTLE_MENU.CHOOSE_ITEM:
			#region Choose an item to use
			
			// Select the item
			current_item_number = select_choice(current_item_number, global.normal_items.size_items(), true)
			
			// Confirm the item
			if input_check_pressed(INPUT.CONFIRM)
			{
				current_item = global.normal_items.get_index_item(current_item_number)
				
				// Check the type of target
				var _array = []
				switch global.collections_items[current_item].get_type_target()
				{
					case TYPE_TARGET.SINGLE_ENEMY:
						// Only one enemy
						all_target = false
						_array = enemies_array
						break
					case TYPE_TARGET.SINGLE_ALLY:
						// Only one ally
						all_target = false
						_array = partymembers_array
						break
					case TYPE_TARGET.ALL_ENEMIES:
						// All enemies
						all_target = true
						_array = enemies_array
						break
					case TYPE_TARGET.ALL_ALLIES:
						// All allies
						all_target = true
						_array = partymembers_array
						break
					case TYPE_TARGET.SINGLE_ALLY_EXCEPT_LAUNCHER:
						// Only one ally but not the launcher
						all_target = false
						for (var _i = 0; _i < array_length(partymembers_array); _i ++)
						{
							if _i != current_character_number
								array_push(_array, partymembers_array[_i])
						}
						break
					case TYPE_TARGET.EVERYONE:
						// All battlers
						all_target = true
						array = array_concat(partymembers_array, enemies_array)
						break
					case TYPE_TARGET.FAINTED:
						// One fainted ally
						all_target = false
						for (var _i = 0; _i < array_length(partymembers_array); _i ++)
						{
							if partymembers_array[_i].hp == 0
								array_push(_array, partymembers_array[_i])
						}
						break
					case TYPE_TARGET.ALL_FAINTED:
						// All fainted allies
						all_target = true
						for (var _i = 0; _i < array_length(partymembers_array); _i ++)
						{
							if partymembers_array[_i].hp == 0
								array_push(_array, partymembers_array[_i])
						}
						break
				}
				
				target_array = _array
				
				function_to_use = global.collections_items[current_item].skill_cast_battle
				item_used = true
				
				// Pass to choose a target
				ds_stack_push(history_menu, BATTLE_MENU.CHOOSE_TARGET)
			}
			break
			#endregion
		case BATTLE_MENU.CHOOSE_TARGET:
			#region Choose a target
			
			// Select a target
			if !all_target
				current_target = select_choice(current_target, array_length(target_array), true)
			
			// Engage !
			if input_check_pressed(INPUT.CONFIRM)
			{
				is_acting = true
				
				with current_character
				{
					chosen = true
					
					xbegin2 = x
					ybegin2 = y
				}
				
				if item_used
					global.normal_items.remove_item(current_item, 1)
				else
					current_character.sp -= current_skill.get_sp_cost()
				
				if all_target
					cutscene = create_cutscene(function_to_use, [current_character, target_array])
				else
					cutscene = create_cutscene(function_to_use, [current_character, target_array[current_target]])
				
				global.successful_attack = true
				
				// Return to choose a party member
				ds_stack_clear(history_menu)
				ds_stack_push(history_menu, BATTLE_MENU.CHOOSE_PARTYMEMBER)
			}
			
			break
			#endregion
	}

	// Back to the previous menu
	if input_check_pressed(INPUT.BACK)
	{
		if ds_stack_size(history_menu) > 1
		{
			ds_stack_pop(history_menu)
			
			if ds_stack_top(history_menu) == BATTLE_MENU.CHOOSE_PARTYMEMBER
			{
				array_pop(front_line)
				
				with current_character
				{
					xdest = xbegin
					ydest = ybegin
					
					event_user(3)
				}
			}
		}
	}
}
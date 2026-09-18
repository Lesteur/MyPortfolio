/// @description Draw

draw_set_font(fnt_fiery_turk)
for (var _i = 0; _i < array_length(partymembers_array); _i ++)
{
	var _ally = partymembers_array[_i]
	var _xx = 160 * _i, _yy = 360
	
	draw_sprite(spr_hui_fight_character, 0, _xx, _yy)
	draw_text_shadow(_xx + 3, _yy - 32, _ally.name)
	
	// Draw HP
	var _hp = (1 - _ally.hp/_ally.hp_max) * 100
	draw_healthbar(_xx + 15, _yy - 26, _xx + 116, _yy - 23, _hp, c_black, c_dkgrey, c_dkgrey, 1, false, false)
	
	draw_text_shadow(_xx + 15, _yy - 22, string(_ally.hp) + " / " + string(_ally.hp_max))
	
	// Draw SP
	var _sp = (1 - _ally.sp/_ally.sp_max) * 100
	draw_healthbar(_xx + 15, _yy - 13, _xx + 116, _yy - 10, _sp, c_black, c_dkgrey, c_dkgrey, 1, false, false)
	
	draw_text_shadow(_xx + 15, _yy - 9, string(_ally.sp) + " / " + string(_ally.sp_max))
}
draw_set_font(global.default_font)

switch ds_stack_top(history_menu)
{
	case BATTLE_MENU.CHOOSE_TARGET:
		#region Choose a target
		
		if all_target
		{
			
		} else {
			var _target = target_array[current_target]
			
			draw_sprite_stretched(spr_hui_fight_2, 0, 0, 0, 220, 25)
			
			draw_text_shadow(5, 20, _target.name)
			
			var _xx = 120, _yy = 10
			
			var _health = (_target.hp/_target.hp_max) * 100
			draw_healthbar(_xx, _yy, _xx + 80, _yy + 5, _health, c_black, c_green, c_green, 0, true, false)
		}
		#endregion
		break
}
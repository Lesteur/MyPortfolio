/// @description Show guard

event_inherited()

switch global.battle_situation
{
	case SITUATION_BATTLE.ENEMIES_TURN:
		//If on guard
		if is_guarding
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_black, 1)
		break
}
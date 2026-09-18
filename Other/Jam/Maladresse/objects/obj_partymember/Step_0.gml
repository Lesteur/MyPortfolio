/// @description Control Player

switch global.battle_situation
{
	case SITUATION_BATTLE.ENEMIES_TURN:
		//If on guard
		if input_check_pressed(INPUT.BATTLE1)
		{
			if !is_guarding && delay_recup == 0
			{
				delay_guard = delay_guard_max
				is_guarding = true
			}
		}

		if delay_guard > 0
		{
			delay_guard --
	
			if delay_guard <= 0
			{
				delay_guard = 0
				is_guarding = false
				delay_recup = delay_recup_max
			}
		} else if delay_recup > 0 {
			delay_recup --
			
			if delay_recup <= 0
				delay_recup = 0
		}
		break
}

event_inherited()
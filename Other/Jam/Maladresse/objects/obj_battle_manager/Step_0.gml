/// @description Choice

if !is_acting
{
	if is_allies_turn
	{
		global.battle_situation = SITUATION_BATTLE.ALLIES_TURN
		party_turn()
	} else {
		global.battle_situation = SITUATION_BATTLE.ENEMIES_TURN
		enemy_turn(enemies_array[turn_enemies])
	}
}

if end_turn
{
	event_user(0)
}
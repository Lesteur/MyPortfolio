/// @function		cutscene_end_skill()
/// @description	End the cutscene of a skill.
/// @self			obj_cutscene

function cutscene_end_skill()
{
	cutscene_set_variable(obj_battle_manager, "end_turn", true)
}
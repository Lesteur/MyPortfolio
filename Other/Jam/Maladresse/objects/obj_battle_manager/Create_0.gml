/// @description Init

cutscene = noone

partymembers_array = []

front_line = []
back_line = []

for (var _i = 0; _i < array_length(global.team); _i++)
{
	var _member = instance_create_layer(100 + _i * 15, 150 + _i * 50, "Instances_F0", obj_partymember)
	array_push(partymembers_array, _member)
	array_push(back_line, _member)
}

enemies_array = []
for (var _i = 0; _i < 1; _i++)
{
	var _enemy = instance_create_layer(480 + _i * 15, 150 + _i * 50, "Instances_F0", obj_enemy)
	array_push(enemies_array, _enemy)
}

max_actions = 1

end_turn = false

current_back_line_number = 0

is_acting = false
current_character = noone
current_character_number = 0
current_action = 0

current_skill = 0
current_skill_number = 0

current_item = 0
current_item_number = 0

all_target = false
target_array = []
current_target = 0

count_of_turns = 0

is_allies_turn = true

turn_allies_max = 1
turn_allies = 0

turn_enemies = 0

function_to_use = -1

item_used = false

history_menu = ds_stack_create()
ds_stack_push(history_menu, BATTLE_MENU.CHOOSE_PARTYMEMBER)
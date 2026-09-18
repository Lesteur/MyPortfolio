/// @description Inflict damage Received

int_damage = ceil(real_damage)

hp = clamp(hp - int_damage, 0, hp_max)

var _x, _y

switch (count_hit mod 3)
{
	case 0:
		_x = 25
		_y = -45
		break
	case 1:
		_x = 35
		_y = -35
		break
	case 2:
		_x = 45
		_y = -45
		break
}

var _inst = instance_create_layer(x + _x, y + _y, current_floor, obj_damage_number)
_inst.damage = string( abs(int_damage) )

if int_damage > 0
{
	timer_shake = 10
	is_shaking = true
	
	current_sprite = INDEX_SPRITES.FIGHT_HURT
}

if hp == 0
{
	if (variable_struct_exists(misc_hit, "fatal") && (variable_struct_get(misc_hit, "fatal") == true))
		event_user(2)
}
	
count_hit ++
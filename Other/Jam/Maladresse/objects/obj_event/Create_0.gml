/// @description Init

my_solid = noone
current_floor = layer

sprite_lock = false
lock = false

if ds_map_exists(global.objets_by_floor, current_floor)
	array_push(global.objets_by_floor[? current_floor], id)
else
	ds_map_add(global.objets_by_floor, current_floor, [id])

cutscene = room1().event1
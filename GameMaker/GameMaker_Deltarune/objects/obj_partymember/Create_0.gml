following = noone
number = -1

image_speed = 0

following_queue = ds_queue_create()

equipment = {
	weapon : noone,
	armor1 : noone,
	armor2 : noone
}

spells = []

setWeapon = function(_weapon) {
	equipment.weapon = _weapon
}

setArmor = function(_number, _armor) {
	if _number == 1
		equipment.armor1 = _armor
	else if _number == 2
		equipment.armor2 = _armor
}

addSpell = function(_spell) {
	array_push(spells, _spell)
}
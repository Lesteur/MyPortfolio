event_inherited()

move_spd = 2
image_move = 0

if global.world == 0 {
	if global.forced_run {
		spr_down = spr_krissad_down
		spr_left = spr_krissad_left
		spr_right = spr_krissad_right
		spr_up = spr_kris_up
	} else {
		spr_down = spr_kris_down
		spr_left = spr_kris_left
		spr_right = spr_kris_right
		spr_up = spr_kris_up
	}
} else {
	spr_down = spr_krisdw_down
	spr_left = spr_krisdw_left
	spr_right = spr_krisdw_right
	spr_up = spr_krisdw_up
}

sprite_index = spr_down
image_speed = 0
path = -1

party = ["kris", "susie", "noelle", "berdly"]
var _follow = id

for (var _i = 1; _i < array_length(party); _i ++) {
	
	var _inst = obj_partymember
	switch(party[_i]) {
		case "susie":
			_inst = obj_susie
			break
		case "noelle":
			_inst = obj_noelle
			break
		case "berdly":
			_inst = obj_berdly
			break
	}
	var _chara = instance_create_layer(x, y, layer, _inst)
	_chara.following = _follow
	_chara.number = _i
	
	_follow = _chara
}

// Display name
name = "Kris"

// Display level (saved to the save file)
level = 1
// Default title / class (saved to the save file)
title = "Chef d'équipe#Commande l'équipe via#des ACTions."

// Determines which character the soul comes from (higher number = higher priority)
soul_priority = 10
// The color of this character's soul (optional, defaults to red)
soul_color = make_color_rgb(255, 0, 0)

// Whether the party member can act / use spells
has_act = true
has_spells = false

// Whether the party member can use their X-Action
has_xact = false
// X-Action name (displayed in this character's spell menu)
xact_name = "Examiner"

// Current health (saved to the save file)
health = 90

// Base stats (saved to the save file)
stats = {
    health : 90,
    attack : 4,
    defense : 1,
}

// Max stats from level-ups
max_stats = {
    health : 120
}

// Weapon icon in equip menu
weapon_icon = spr_ui_icon_sword

// Equipment (saved to the save file)
self.setWeapon("bladed_bow")
self.setArmor(1, "amber_card")
self.setArmor(2, "amber_card")

// Default light world equipment item IDs (saves current equipment)
lw_weapon_default = "Crayon"
lw_armor_default = "Bandage"

// Character color (for action box outline and hp bar)
color = make_color_rgb(0, 255, 255)
// Damage color (for the number when attacking enemies) (defaults to the main color)
dmg_color = make_color_rgb(0, 255, 255)
// Attack bar color (for the target bar used in attack mode) (defaults to the main color)
attack_bar_color = make_color_rgb(0, 255, 255)
// Attack box color (for the attack area in attack mode) (defaults to darkened main color)
attack_box_color = make_color_rgb(0, 255, 255)
// X-Action color (for the color of X-Action menu items) (defaults to the main color)
xact_color = make_color_rgb(0, 255, 255)

// Head icon in the equip / power menu
menu_icon = spr_ui_icon_kris
// Path to head icons used in battle
head_icon = spr_ui_head_kris
// Name sprite
name_sprite = spr_ui_name_kris

// Effect shown above enemy after attacking it
attack_sprite = noone
// Sound played when this character attacks
attack_sound = noone
// Pitch of the attack sound
attack_pitch = 1

// Message shown on gameover (optional)
gameover_message = noone
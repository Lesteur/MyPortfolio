event_inherited()

if global.world == 0 {
	spr_down = spr_berdly_down
	spr_left = spr_berdly_left
	spr_right = spr_berdly_right
	spr_up = spr_berdly_up
} else {
	spr_down = spr_berdlydw_down
	spr_left = spr_berdlydw_left
	spr_right = spr_berdlydw_right
	spr_up = spr_berdlydw_up
}

sprite_index = spr_down
image_speed = 0

// Display name
name = "Berdly"

// Display level (saved to the save file)
level = 1
// Default title / class (saved to the save file)
title = "Cyber-Soldat#N'est bon qu'à jouer#les M. Je-Sais-Tout."

// Determines which character the soul comes from (higher number = higher priority)
soul_priority = 1
// The color of this character's soul (optional, defaults to red)
soul_color = make_color_rgb(229, 0, 299)

// Whether the party member can act / use spells
has_act = false
has_spells = true

// Whether the party member can use their X-Action
has_xact = true
// X-Action name (displayed in this character's spell menu)
xact_name = "B-Action"

// Spells
//self:addSpell("heal_prayer")

// Current health (saved to the save file)
health = 90

// Base stats (saved to the save file)
stats = {
    health : 90,
    attack : 4,
    defense : 1,
    magic : 14
}

// Max stats from level-ups
max_stats = {
    health : 120
}

// Weapon icon in equip menu
weapon_icon = spr_ui_icon_axe

// Default light world equipment item IDs (saves current equipment)
lw_weapon_default = "Stylo-bille"
lw_armor_default = "Alarme neuve"

// Character color (for action box outline and hp bar)
color = make_color_rgb(50, 175, 130)
// Damage color (for the number when attacking enemies) (defaults to the main color)
dmg_color = make_color_rgb(50, 175, 130)
// Attack bar color (for the target bar used in attack mode) (defaults to the main color)
attack_bar_color = make_color_rgb(50, 175, 130)
// Attack box color (for the attack area in attack mode) (defaults to darkened main color)
attack_box_color = make_color_rgb(50, 175, 130)
// X-Action color (for the color of X-Action menu items) (defaults to the main color)
xact_color = make_color_rgb(50, 175, 130)

// Head icon in the equip / power menu
menu_icon = spr_ui_icon_berdly
// Path to head icons used in battle
head_icon = spr_ui_head_berdly
// Name sprite
name_sprite = spr_ui_name_berdly

// Effect shown above enemy after attacking it
attack_sprite = noone
// Sound played when this character attacks
attack_sound = noone
// Pitch of the attack sound
attack_pitch = 1

// Message shown on gameover (optional)
gameover_message = "Ne nous déçois pas, Kris !"
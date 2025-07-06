event_inherited()

if global.world == 0 {
	spr_down = spr_susie_down
	spr_left = spr_susie_left
	spr_right = spr_susie_right
	spr_up = spr_susie_up
} else {
	spr_down = spr_susiedw_down
	spr_left = spr_susiedw_left
	spr_right = spr_susiedw_right
	spr_up = spr_susiedw_up
}

sprite_index = spr_down
image_speed = 0

// Display name
name = "Susie"

// Display level (saved to the save file)
level = 1
// Default title / class (saved to the save file)
title = "Chevalier Noir#Utilise l'énergie sombre#pour effrayer les ennemis."

// Determines which character the soul comes from (higher number = higher priority)
soul_priority = 1
// The color of this character's soul (optional, defaults to red)
soul_color = make_color_rgb(255, 0, 0)

// Whether the party member can act / use spells
has_act = false
has_spells = true

// Whether the party member can use their X-Action
has_xact = true
// X-Action name (displayed in this character's spell menu)
xact_name = "S-Action"

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
lw_weapon_default = "Branche lourde"
lw_armor_default = "Veste sale"

// Character color (for action box outline and hp bar)
color = make_color_rgb(255, 0, 255)
// Damage color (for the number when attacking enemies) (defaults to the main color)
dmg_color = make_color_rgb(255, 0, 255)
// Attack bar color (for the target bar used in attack mode) (defaults to the main color)
attack_bar_color = make_color_rgb(255, 0, 255)
// Attack box color (for the attack area in attack mode) (defaults to darkened main color)
attack_box_color = make_color_rgb(255, 0, 255)
// X-Action color (for the color of X-Action menu items) (defaults to the main color)
xact_color = make_color_rgb(255, 0, 255)

// Head icon in the equip / power menu
menu_icon = spr_ui_icon_susie
// Path to head icons used in battle
head_icon = spr_ui_head_susie
// Name sprite
name_sprite = spr_ui_name_susie

// Effect shown above enemy after attacking it
attack_sprite = noone
// Sound played when this character attacks
attack_sound = noone
// Pitch of the attack sound
attack_pitch = 1

// Message shown on gameover (optional)
gameover_message = "Allez, c'est tout c'qu't'as ?!"
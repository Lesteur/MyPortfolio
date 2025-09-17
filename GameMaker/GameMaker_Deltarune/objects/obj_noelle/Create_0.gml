event_inherited()

if global.world == 0 {
	spr_down = spr_noelle_down
	spr_left = spr_noelle_left
	spr_right = spr_noelle_right
	spr_up = spr_noelle_up
} else {
	spr_down = spr_noelledw_down
	spr_left = spr_noelledw_left
	spr_right = spr_noelledw_right
	spr_up = spr_noelledw_up
}

sprite_index = spr_down

// Display name
name = "Noëlle"

// Display level (saved to the save file)
level = 1
// Default title / class (saved to the save file)
title = "Mage de Neige#Est pourtant très#chaleureuse pour sa classe."

// Determines which character the soul comes from (higher number = higher priority)
soul_priority = 1
// The color of this character's soul (optional, defaults to red)
soul_color = make_color_rgb(0, 178, 0)

// Whether the party member can act / use spells
has_act = false
has_spells = true

// Whether the party member can use their X-Action
has_xact = true
// X-Action name (displayed in this character's spell menu)
xact_name = "N-Action"

// Spells
self.addSpell("heal_prayer")

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
weapon_icon = spr_ui_icon_ring

// Equipment (saved to the save file)
self.setWeapon("bladed_bow")
self.setArmor(1, "amber_card")
self.setArmor(2, "amber_card")

// Default light world equipment item IDs (saves current equipment)
lw_weapon_default = "Anneau en toc"
lw_armor_default = "Montre argentée"

// Character color (for action box outline and hp bar)
color = make_color_rgb(255, 255, 0)
// Damage color (for the number when attacking enemies) (defaults to the main color)
dmg_color = make_color_rgb(255, 255, 0)
// Attack bar color (for the target bar used in attack mode) (defaults to the main color)
attack_bar_color = make_color_rgb(255, 255, 0)
// Attack box color (for the attack area in attack mode) (defaults to darkened main color)
attack_box_color = make_color_rgb(255, 255, 0)
// X-Action color (for the color of X-Action menu items) (defaults to the main color)
xact_color = make_color_rgb(255, 255, 0)

// Head icon in the equip / power menu
menu_icon = spr_ui_icon_noelle
// Path to head icons used in battle
head_icon = spr_ui_head_noelle
// Name sprite
name_sprite = spr_ui_name_noelle

// Effect shown above enemy after attacking it
attack_sprite = noone
// Sound played when this character attacks
attack_sound = noone
// Pitch of the attack sound
attack_pitch = 1

// Message shown on gameover (optional)
gameover_message = "Kris, je t'en prie, réveille-toi... !"
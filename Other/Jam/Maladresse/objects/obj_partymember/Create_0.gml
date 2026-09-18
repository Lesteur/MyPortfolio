/// @description Init Base Partymember

event_inherited()

// Base

name = "Boy"

// Stats

hp_max = 100
hp = 100

sp_max = 20
sp = 20

attack = 10
special_attack = 8

defense = 10
special_defense = 8

delay_guard_max = 10
delay_guard = 0

delay_recup_max = 10
delay_recup = 0

is_guarding = false

chosen = false

ds_list_add(list_skills, new BasicAttack())
ds_list_add(list_skills, new MultiAttack())
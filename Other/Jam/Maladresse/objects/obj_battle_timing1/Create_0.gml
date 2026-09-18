/// @description Init

times = ds_queue_create()

var_begin = 0
var_end = 100

setup = false
spd = 0.015
t = 0

channel = animcurve_get_channel(ac_battle_timing1, 0)
value = 0

global.successful_attack = -1
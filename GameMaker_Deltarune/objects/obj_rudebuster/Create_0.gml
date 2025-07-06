/// @description Insert description here
// You can write your code in this editor

target = obj_target
damage = 1
star = 0
caster = 0
image_alpha = 0
image_xscale = 1
image_yscale = 1
image_speed = 1

for (var _i = 0; _i < 10; _i += 1)
{
    prevx[_i] = x
    prevy[_i] = y
}

a = 0
targetx = 0
targety = 0
t = 0
tmax = 4
siner = 0
explode = 0
maxaft = 0
bolt_timer = 0
chosen_bolt = 0
final_bolt = 0
rouge = 0
battlemode = 1

cx = -1
cy = -1
dir = -1
bonus_anim = 0
//if ((global.fighting == false))
//    battlemode = 0
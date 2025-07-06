/// @description Insert description here
// You can write your code in this editor

timer++
if (timer == 1)
    //snd_play(snd_icespell)
if (timer == 1)
    hex[0] = instance_create((x - 25*0.75), (y - 20*0.75), obj_icespell_hexagon)
if (timer == 4)
    hex[1] = instance_create((x + 25*0.75), (y - 20*0.75), obj_icespell_hexagon)
if (timer == 7)
    hex[2] = instance_create(x, (y + 20*0.75), obj_icespell_hexagon)

if (timer == 10) {
	
    for (var i = 0; i < 3; i++) {
		
        with (hex[i]) {
			
            for (var j = 0; j < 6; j++) {
                hexhex[j] = instance_create(x, y, obj_icespell_hexagon)
                hexhex[j].image_xscale = 0.5
                hexhex[j].image_yscale = 0.5
                hexhex[j].con = 1
                hexhex[j].direction = (60 * j)
                hexhex[j].speed = 8*0.75
                hexhex[j].friction = 0.20000000000000001*0.75
            }
        }
    }
}

if (timer == 11) {
    with (hex[0])
        instance_destroy()
    with (hex[1])
        instance_destroy()
    with (hex[2])
        instance_destroy()
}

/*
if ((timer == 15)) {
    if ((global.fighting == true)) {
        global.hittarget[star] = 0
        if ((damage >= global.monsterhp[star])) {
            if i_ex(global.monsterinstance[star]) {
                if ((global.monsterinstance[star].freezable == true))
                    global.flag[(51 + star)] = 6
            }
        }
        scr_damage_enemy(star, damage)
        if ((global.monster[star] == true)) {
            with (target)
                __of = scr_oflash()
        }
    }
}
*/

if ((timer >= 10) && (timer <= 30)) {
    draw_set_alpha((2.2000000000000002 - (timer / 10)))
    draw_set_color(c_white)
    draw_circle(x, y, (60 - (timer * 6))*0.75, 1)
    draw_circle(x, y, (61 - (timer * 6))*0.75, 1)
    draw_circle(x, y, (62 - (timer * 6))*0.75, 1)
    draw_set_alpha(1)
}

if (timer == 60)
    instance_destroy()
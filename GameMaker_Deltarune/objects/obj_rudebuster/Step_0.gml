/// @description Insert description here
// You can write your code in this editor

if (image_alpha < 1)
    image_alpha += 0.25
else
    image_alpha = 1

if (t == 0) {
	/*
    if ((battlemode == 1))
    {
        if instance_exists(obj_queenshield_enemy)
        {
            depth = (obj_queenshield_enemy.depth - 1)
            targetx = (obj_queenshield_enemy.x + 24)
            targety = (obj_queenshield_enemy.y + 140)
        }
        else
        {
            targetx = global.monsterx[target.myself]
            targety = global.monstery[target.myself]
        }
    }
    else if i_ex(target)
    {
        targetx = (target.x + (target.sprite_width / 2))
        targety = (target.y + (target.sprite_height / 2))
    }
	*/
	targetx = (target.x + (target.sprite_width / 2))
    targety = (target.y + (target.sprite_height / 2))
	
    cx = targetx
    cy = targety
    direction = (point_direction(x, y, cx, cy) - 20)
    speed = 12
    friction = -0.75
    image_angle = direction
    if (rouge == 1) {
        sprite_index = spr_rudebuster_beam_red
        image_xscale = 1.25
        image_yscale = 1.25
    }
}
if ((t >= 1) && (explode == 0)) {
    bolt_timer += 1
    if ((bolt_timer >= 4/scale) && (chosen_bolt == 0))
        chosen_bolt = bolt_timer
    dir = point_direction(x, y, cx, cy)
    direction += (angle_difference(dir, direction) / 4)//2)/scale
    image_angle = direction
    if (point_distance(x, y, cx, cy) <= 20) {//40/scale)) {
        final_bolt = chosen_bolt
        visible = false
        explode = 1
        t = 1
    }
}
if (explode == 1) {
    if (t == 1) {
        bonus_anim = 0
        if (chosen_bolt > 0) {
            if (chosen_bolt == final_bolt)
                damage += 30
            if (chosen_bolt == (final_bolt - 1))
                damage += 28
            if (chosen_bolt == (final_bolt - 2))
                damage += 22
            if (chosen_bolt == (final_bolt - 3))
                damage += 20
            if (chosen_bolt == (final_bolt - 4))
                damage += 13
            if (chosen_bolt == (final_bolt - 5))
                damage += 11
            if (chosen_bolt == (final_bolt - 6))
                damage += 10
            if (abs(chosen_bolt - final_bolt) <= 2) {
                bonus_anim = 1
                //snd_play(snd_scytheburst)
            }
        }
        if (rouge == 1)
            damage += 90
		/*
        if ((battlemode == 1))
        {
            global.hittarget[star] = 0
            if instance_exists(obj_queenshield_enemy)
            {
                obj_queen_enemy.shieldhp -= damage
                with (obj_queenshield_enemy)
                    con = 1
                with (obj_queenshield_enemy)
                    event_user(0)
            }
            else
                scr_damage_enemy(star, damage)
            if ((global.monstertype[0] != 20))
            {
                with (target)
                    __of = scr_oflash()
                if ((rouge == 1))
                {
                    with (target)
                        __of.flashcolor = c_red
                }
            }
        }
        else
        {*/
			/*
            with (target)
                __of = scr_oflash()
            if ((rouge == 1))
            {
                with (target)
                    __of.flashcolor = c_red
            }
			*/
        //}
        //snd_play(snd_rudebuster_hit)
        for (var _i = 0; _i < 4; _i += 1) {
            burst[_i] = scr_afterimage()
            burst[_i].image_speed = 0.5
            burst[_i].x = cx
            burst[_i].y = cy
            burst[_i].image_angle = (45 + (_i * 90))
            burst[_i].direction = burst[_i].image_angle
            burst[_i].speed = 12.5
            burst[_i].depth = (depth - 10)
        }
		
        for (var _i = 4; _i < 8; _i += 1) {
            burst[_i] = scr_afterimage()
            burst[_i].image_speed = 0.5
            burst[_i].x = cx
            burst[_i].y = cy
            burst[_i].image_angle = (45 + (_i * 90))
            burst[_i].direction = burst[_i].image_angle
            burst[_i].speed = 12.5
            burst[_i].depth = (depth - 10)
        }
    }
	
    if (t >= 2) {
        for (var _i = 0; _i < 4; _i += 1) {
            with (burst[_i]) {
                speed *= 0.75
                image_xscale *= 0.80000000000000004
            }
        }
		
        for (var _i = 4; _i < 8; _i += 1) {
            with (burst[_i]) {
                speed *= 0.80000000000000004
                image_xscale *= 0.80000000000000004
            }
        }
    }
	
    if (t >= 18)
        instance_destroy()
}

if (explode == 0) {
    aft[maxaft] = scr_afterimage()
    aft[maxaft].image_yscale = 0.9
    aft[maxaft].image_angle = image_angle
    aft[maxaft].image_index = 4
    aft[maxaft].image_speed = 0.5
    aft[maxaft].image_alpha = (image_alpha - 0.20000000000000001)
    maxaft += 1
}

for (var _i = 0; _i < maxaft; _i += 1) {
    with (aft[_i]) {
        image_yscale -= 0.0500000000000000005
        if (image_yscale <= 0.10000000000000001)
            instance_destroy()
    }
	
    if (explode == 1) {
        with (aft[_i]) {
            image_alpha -= 0.070000000000000007
            image_yscale *= 0.90000000000000002
            if (image_yscale <= 0.10000000000000001)
                instance_destroy()
        }
    }
}

a += 1
t += 1
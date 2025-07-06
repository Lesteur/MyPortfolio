/// @description Insert description here
// You can write your code in this editor

if (con == 1) {
    image_angle += (rotspeed * 2)
    direction += (rotspeed * 3)
    timer++
	
    if ((timer >= 10))
        image_alpha -= 0.10000000000000001
    if (image_alpha <= 0)
        instance_destroy()
}
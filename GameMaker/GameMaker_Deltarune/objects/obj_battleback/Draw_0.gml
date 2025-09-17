xx = 0 //__view_get((0 << 0), 0)
yy = 0//__view_get((1 << 0), 0)
siner += 0.5
siner2 += 1

draw_set_alpha(image_alpha)
draw_set_color(c_black)
draw_rectangle(-10, -10, (room_width + 10), (room_height + 10), false)
draw_set_alpha(1)

if (destroy == 0) {
    if (image_alpha <= 1)
        image_alpha += 0.10000000000000001
}

if (bgtype == 0) {
    draw_background_tiled_ext(spr_battleback1, round(-100 + siner), round(-100 + siner), 1, 1, image_blend, 0.5)
    draw_background_tiled_ext(spr_battleback1, round(-200 - siner2), round(-210 - siner2), 1, 1, image_blend, 1)
}

if (siner >= 100)
    siner -= 100

if (siner2 >= 100)
    siner2 -= 100

if (destroy == 1) {
    image_alpha -= 0.10000000000000001
    if (image_alpha <= 0)
        instance_destroy()
}
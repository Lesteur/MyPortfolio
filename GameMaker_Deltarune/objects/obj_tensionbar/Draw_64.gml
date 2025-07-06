draw_set_color(c_white)
flashsiner += 1
tamt = floor((apparent / global.maxtension) * 100)
maxed = 0

if (tamt < 100) {
    draw_text((x - 30)/2 - 2, (y + 70)/2, string_hash_to_newline(string(floor((apparent / global.maxtension) * 100))))
    draw_text((x - 25)/2 - 2, (y + 95)/2, string_hash_to_newline("%"))
}

if (tamt >= 100) {
    maxed = 1
    draw_set_color(c_yellow)
    draw_text((x - 28)/2, (y + 70)/2, string_hash_to_newline("M"))
    draw_text((x - 24)/2, (y + 90)/2, string_hash_to_newline("A"))
    draw_text((x - 20)/2, (y + 110)/2, string_hash_to_newline("X"))
}
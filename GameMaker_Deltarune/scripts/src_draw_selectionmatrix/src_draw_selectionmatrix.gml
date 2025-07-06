function draw_selectionmatrix(_slmxx, _slmyy) {
    s_siner += 2
    
    //draw_rectangle(_slmxx, _slmyy, _slmxx + 210, _slmyy + 3, false)
    for (var _i = 0; _i < 12; _i += 1) {
        var _myxx = s_siner + (_i * (10 * pi))
        draw_set_alpha(sin(_myxx / 60))
        draw_line_width(_slmxx, _slmyy - 3, _slmxx, _slmyy + 33, 2)
        draw_line_width(_slmxx + 211, _slmyy - 3, _slmxx + 211, _slmyy + 33, 2)
        if (cos(_myxx / 60) < 0) {
            draw_line_width((_slmxx - (sin(_myxx / 60) * 30)) + 30, _slmyy, (_slmxx - sin(_myxx / 60) * 30) + 30, _slmyy + 33, 2)
            draw_line_width(((_slmxx + 210) + (sin(_myxx / 60) * 30)) - 30, _slmyy, ((_slmxx + 210) + (sin(_myxx / 60) * 30)) - 30, _slmyy + 33, 2)
        }
    }
    draw_set_alpha(1)
}
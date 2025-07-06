function scr_custom_afterimage(_obj) {
    var _afterimage = instance_create(x, y, _obj)
    _afterimage.sprite_index = sprite_index
    _afterimage.image_index = image_index
    _afterimage.image_blend = image_blend
    _afterimage.image_speed = 0
    _afterimage.depth = (depth + 1)
    _afterimage.image_xscale = image_xscale
    _afterimage.image_yscale = image_yscale
    _afterimage.image_angle = image_angle
    return _afterimage
}
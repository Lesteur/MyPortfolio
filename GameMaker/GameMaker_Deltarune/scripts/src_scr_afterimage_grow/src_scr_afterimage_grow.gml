function scr_afterimage_grow() {
    var _afterimage = instance_create(x, y, obj_afterimage_grow)
    _afterimage.sprite_index = sprite_index
    _afterimage.image_index = image_index
    _afterimage.image_blend = image_blend
    _afterimage.image_speed = 0
    _afterimage.depth = depth
    _afterimage.image_xscale = image_xscale
    _afterimage.image_yscale = image_yscale
    _afterimage.image_angle = image_angle
    return _afterimage
}
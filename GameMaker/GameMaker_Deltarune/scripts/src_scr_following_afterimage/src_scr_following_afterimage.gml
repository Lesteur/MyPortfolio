function scr_following_afterimage() {
    var __source = ((argument_count == 2) ? argument[1] : self)
    var _afterimage = instance_create(__source.x, __source.y, argument[0])
    _afterimage.parent = __source
    _afterimage.sprite_index = __source.sprite_index
    _afterimage.image_index = __source.image_index
    _afterimage.image_blend = __source.image_blend
    _afterimage.image_speed = 0
    _afterimage.depth = __source.depth
    _afterimage.image_xscale = __source.image_xscale
    _afterimage.image_yscale = __source.image_yscale
    _afterimage.image_angle = __source.image_angle
    return _afterimage
}
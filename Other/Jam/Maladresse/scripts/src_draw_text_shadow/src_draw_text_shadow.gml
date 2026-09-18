/// @function							draw_text_shadow(x, y, text, color, alpha)
/// @description						Draw any string in the room with special effects.
/// @param	{Real}			x			The x coordinate of the drawn string.
/// @param	{Real}			y			The y coordinate of the drawn string.
/// @param	{String}		string		The string to draw.
/// @param	{Real}			color		The colour for the drawn text.
/// @param	{Real}			alpha		The alpha for the text.

function draw_text_shadow(_x, _y, _string, _color = c_white, _alpha = 1)
{
	draw_text_color(_x + 1, _y + 1, _string, c_black, c_black, c_black, c_black, _alpha)
	draw_text_color(_x, _y, _string, _color, _color, _color, _color, _alpha)
}
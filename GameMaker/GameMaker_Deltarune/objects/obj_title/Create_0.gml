language_init("english")

array = [get_str("menu.begin"), get_str("menu.selectfile"), get_str("menu.empty"), get_str("menu.instruction")]
array_text = []
array_text_misc = []

for (var _i = 0; _i < array_length(array); _i++) {
	var _a = string_get_misc(array[_i])
	var _str = _a[0]
	var _misc = _a[1]
	array_push(array_text, _str)
	array_push(array_text_misc, _misc)
}

menu = 0
choice_file = 0
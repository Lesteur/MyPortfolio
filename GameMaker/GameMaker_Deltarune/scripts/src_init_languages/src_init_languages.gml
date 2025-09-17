#macro LANG_PATH_BASE working_directory + "/locale/"
#macro LANG_PATH_LIST "list.txt"
#macro LANG_PATH_STRING	"string.txt"
#macro LANG_PATH_SPRITE "sprite.txt"
#macro LANG_PATH_FONT "font.txt"
#macro LANG_PATH_INFO "info.ini"

global.lang_list = ds_list_create();
global.lang_string = ds_map_create();
global.lang_sprite = ds_map_create();

function language_clear_all() {
	ds_map_clear(global.lang_string);
	ds_map_clear(global.lang_sprite);
}

function load_file_to_string(_file_name) {

	if (!file_exists(_file_name)) {
		return ""
	}

	var _str = ""
	var _file = file_text_open_read(_file_name)
	while (!file_text_eof(_file)) {
	
		var _s = file_text_readln(_file)
		if (string_copy(_s, 1, 2) != "//") {
			_str += _s
		}
		
	}

	file_text_close(_file)
	return _str
}

function language_exists(_lang) {

	if (is_real(_lang))
		return is_string(ds_list_find_value(global.lang_list, _lang))
	else if (is_string(_lang))
		return ds_list_find_index(global.lang_list, _lang) != -1

}

function language_str_exists(_key) {
	return is_string(ds_map_find_value(global.lang_string, _key))
}

function language_load_list() {
	
	language_clear_all()
	var _str = load_file_to_string(LANG_PATH_BASE + LANG_PATH_LIST)
	
	if (_str == "")
		return false

	var _list = global.lang_list;
	var _file = file_text_open_from_string(_str)
	
	while(!file_text_eof(_file)) {
		
		var _lang = file_text_read_string(_file)
		file_text_readln(_file)
		
		if (!language_exists(_lang)) {
			if (directory_exists(LANG_PATH_BASE + _lang)) {
				ds_list_add(_list, _lang);
			}
		}
		
	}

	file_text_close(_file);
	return !ds_list_empty(_list);

}

function language_load_string(_lang) {

	if !language_exists(_lang) {
		return false
	}

	if !file_exists(LANG_PATH_BASE + _lang + "/" + LANG_PATH_STRING) {
		return false
	}

	var _map = global.lang_string
	var _list = load_file_to_string(LANG_PATH_BASE + _lang + "/" + LANG_PATH_STRING);
	var _file = file_text_open_from_string(_list)
	
	while !file_text_eof(_file) {
		
		var _target = file_text_read_string(_file)
		file_text_readln(_file)
		var _path = LANG_PATH_BASE +_lang + "/" + _target
		
		if file_exists(_path) {
			
			var _str = load_file_to_string(_path)
			var _obj = json_parse(_str)
			
			if (typeof(_obj) != "struct")
				continue
			
			var _names = variable_struct_get_names(_obj)
			for(var _i = 0; _i < array_length(_names); _i += 1) {
				var _key = _names[_i]
				var _innerline = variable_struct_get(_obj, _key)
				
				if (typeof(_innerline) != "string")
					continue
				
				ds_map_add(_map, _key, _innerline)
			}
			
		}
		
	}
	
	file_text_close(_file)
	return true
}

function get_str(_key, _def = "vide") {
	return (language_str_exists(_key) ? ds_map_find_value(global.lang_string, _key) : _def)
}

function language_init(_lang) {
	language_clear_all()
	language_load_list()
	language_load_string(_lang)
}
function check_file(_number) {
	var _filename = working_directory + "/SAVE/SAVE" + string(_number) + "/progress.sav"
	return file_exists(_filename)
}

function save_file(_number) {
	
	var _filename = working_directory + "/SAVE/SAVE" + string(_number) + "/progress.sav"
	if file_exists(_filename)
		file_delete(_filename)
	
	var _file = file_text_open_write(_filename)
	
	file_text_write_real(_file, real(room))
	file_text_writeln(_file)
	file_text_write_real(_file, obj_kris.x)
	file_text_writeln(_file)
	file_text_write_real(_file, obj_kris.y)
	
	file_text_close(_file)
	/*
	var _filename = working_directory + "/SAVE/progress.sav"
	var _filenumber = "SAVE" + string(_number)
	if file_exists(_filename)
		file_delete(_filename)
	ini_open(_filename)
	var _saved_room = real(room)
	ini_write_real(_filenumber, "room", _saved_room)
	ini_write_real(_filenumber, "x", obj_player.x)
	ini_write_real(_filenumber, "y", obj_player.y)
	ini_close()
	*/
}

function load_file(_number) {
	
	var _filename = working_directory + "/SAVE/SAVE" + string(_number) + "/progress.sav"
	if !file_exists(_filename)
		return -1
	
	var  _loaded_room, _x, _y
	
	var _file = file_text_open_read(_filename)
	_loaded_room = file_text_read_real(_file)
	file_text_readln(_file)
	_x = file_text_read_real(_file)
	file_text_readln(_file)
	_y = file_text_read_real(_file)
	file_text_readln(_file)
	file_text_close(_file)
	
	return [_loaded_room, _x, _y]
	
	/*
	var _filename = working_directory + "/SAVE/progress.sav"
	var _filenumber = "SAVE" + string(_number)
	var  _loaded_room, _x, _y
	if file_exists(_filename) {
		ini_open(_filename)
		_loaded_room = ini_read_real(_filenumber, "room", -1)
		_x = ini_read_real(_filenumber, "x", -1)
		_y = ini_read_real(_filenumber, "y", -1)
		ini_close()
		return [_loaded_room, _x, _y]
	} else {
		return -1
	}
	*/
}
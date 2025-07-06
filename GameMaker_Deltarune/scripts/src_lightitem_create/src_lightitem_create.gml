global.dict_light_items = ds_map_create()

function LightItem() constructor {
  static name = "Light Item"
  static type = ITEMTYPES.LIGHT
  
  static onUseWorld = function(_user) { return true }
  static onCheckWorld = function() { return true }
  static onThrowWorld = function() { return true }
  static toString = function() { return name }
  static getName = function() { return name }
  static convertToDark = function() { return DarkItem }
}

function PointlessItem() : LightItem() constructor {
	static name = "Pointless Item"
}
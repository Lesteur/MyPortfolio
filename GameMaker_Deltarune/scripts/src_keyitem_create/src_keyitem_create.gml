global.dict_key_items = ds_map_create()

function KeyItem() constructor {
  static name = "Key Item"
  static type = ITEMTYPES.KEY
  
  static desc = ""
  static target = TARGETTYPES.NONE
  static usable = USABLETYPES.NONE
  static reactions = {kris : "",
					  susie : "",
					  ralsei : "",
					  noelle : "",
					  berdly : ""}
  
  static onUseWorld = function(_user) { return true }
  static toString = function() { return name }
  static getName = function() { return name }
  static getDesc = function() { return desc }
  static getTarget = function() { return target }
  static getUsable = function() { return usable }
  static getReaction = function(_character) {
	  switch(_character) {
		  case obj_kris:
			return reactions.kris
		  case obj_susie:
			return reactions.susie
		  case obj_noelle:
			return reactions.noelle
		  case obj_berdly:
			return reactions.berdly
	  }
  }
}

function PhoneItem() : KeyItem() constructor {
	static name = "Phone"
	static desc = "Can be used to make calls."
	
	static target = TARGETTYPES.NONE
	static usable = USABLETYPES.WORLD
}
enum ITEMTYPES {CONSUMABLE, WEAPON, ARMOR, KEY, LIGHT}
enum TARGETTYPES {ALLY, PARTY, ENEMY, ENEMIES, NONE}
enum USABLETYPES {WORLD, BATTLE, ALL, NONE}

global.dict_dark_items = ds_map_create()

function DarkItem() constructor {
  static name = "Dark Item"
  static short_name = "D. Item"
  static type = ITEMTYPES.CONSUMABLE
  
  static battle_desc = "An weird item."
  static shop_desc = "An weird item."
  static desc = "This item is just weird."
  
  static price = 0
  static can_sell = true
  
  static target = TARGETTYPES.ALLY
  static usable = USABLETYPES.ALL
  static reactions = {kris : "...",
					  susie : "... What the hell is that?",
					  ralsei : "It's... sure interesting !",
					  noelle : "It's... weird...",
					  berdly : "Well... it's still an item, right?"}
  
  static onUseWorld = function(_user) { return true }
  static onUseBattle = function(_user) { return true }
  static onThrowWorld = function() { return true }
  static toString = function() { return name }
  static getName = function() { return name }
  static getShortName = function() { return short_name }
  static getBattleDesc = function() { return battle_desc }
  static getShopDesc = function() { return shop_desc }
  static getDesc = function() { return desc }
  static getPrice = function() { return price }
  static getCanSell = function() { return can_sell }
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
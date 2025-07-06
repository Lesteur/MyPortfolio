function ArmorItem() constructor {
  static name = "Useless Armor"
  static short_name = "Usel. Armor"
  static type = ITEMTYPES.ARMOR
  static icon = spr_ui_icon_armor1
  
  static shop_desc = "A broken armor"
  static desc = "A broken armor."
  
  static price = 0
  static can_sell = true
  
  static attack = 0
  static defense = 0
  static magic = 1
  
  static bonus_name = "Useless"
  static bonus_icon = spr_ui_icon_armor1
  static reactions = {kris : "...",
				      susie : "... you call this an armor???",
				      ralsei : "So sad!",
				      noelle : "It falls apart...",
				      berdly : "How pitiful..."}
  static can_equip = {
	  kris : true,
	  susie : true,
	  ralsei : true,
	  noelle : true,
	  berdly : true}
  
  static toString = function() { return name }
  static getName = function() { return name }
  static getShopDesc = function() { return shop_desc }
  static getDesc = function() { return desc }
  static getPrice = function() { return price }
  static getCanSell = function() { return can_sell }
  static getAttack = function() { return attack }
  static getDefense = function() { return defense }
  static getMagic = function() { return magic }
  static getBonusName = function() { return bonus_name }
  static getBonusIcon = function() { return bonus_icon }
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
  static convertToLight = function() { return LightItem }
}
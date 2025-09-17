function ItemCDBagel() : DarkItem() constructor {
	static name = "Bagel CD"
	
    static battle_desc = "Heals\n80 HP"
    static shop_desc = "Musical food\nwith a\ncrunch\nHeals 80HP"
    static desc = "A bagel with a reflective inside.\nMakes music with each bite. +80HP"
	
	static target = TARGETTYPES.ALLY
	static usable = USABLETYPES.ALL
}
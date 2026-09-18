/// @description Init

camera = instance_create_layer(x, y, layer, obj_camera)

global.normal_items = new Inventory()
global.normal_items.add_item(ITEM_HEAL_POTION, 1)
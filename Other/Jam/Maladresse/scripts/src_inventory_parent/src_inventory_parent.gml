function Inventory() constructor
{
	inventory_list = ds_list_create()
	
	static add_item = function(_item_index, _amount)
	{
		if ds_list_find_index(inventory_list, _item_index) == -1
		{
			ds_list_add(inventory_list, _item_index)
			global.collections_items[_item_index].amount = _amount
		} else {
			global.collections_items[_item_index].amount += _amount
		}
	}
	
	static remove_item = function(_item_index, _amount)
	{
		var _index = ds_list_find_index(inventory_list, _item_index)
		
		show_debug_message(_index)
		
		if _index != -1
		{
			global.collections_items[_item_index].amount -= _amount
			
			if global.collections_items[_item_index].amount <= 0
			{
				global.collections_items[_item_index].amount = 0
				ds_list_delete(inventory_list, _index)
			}
		}
	}
	
	static get_index_item = function(_index)
	{
		return inventory_list[| _index]
	}
	
	static size_items = function()
	{
		return ds_list_size(inventory_list)
	}
	
	static sort_items = function()
	{
		ds_list_sort(inventory_list, true)
	}
	
	static destroy_inventory = function()
	{
		ds_list_destroy(inventory_list)
	}
}
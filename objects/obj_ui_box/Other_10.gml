var item_inventory = "", item_box = "", 
	i = 0;
repeat (10)
{
	if (i < 8)
	{
		item_inventory += Item_GetName(Item_Get(i));
		item_inventory += "\n";
	}
	
	item_box += Item_GetName(Box_ItemGet(_box_slot, i));
	item_box += "\n";
	
	i++;
}



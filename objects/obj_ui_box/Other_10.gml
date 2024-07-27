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
_label_item_inventory = scribble($"{_prefix}{item_inventory}");
_label_item_box		  = scribble($"{_prefix}{item_box}");

_label_item_inventory.build(true);
_label_item_box		 .build(true);

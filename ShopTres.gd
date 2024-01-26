extends Resource

class_name ShopTres

@export var items : Array[ShopItem]

var currentItemIndex: int

var currentItem: ShopItem

func get_current_item():
	return currentItem

func update_current_item_index(index: int):
	currentItemIndex = index
	currentItem = items[index]

extends Resource

class_name WorkBench

@export var items : Array[WorkBenchItem]

var currentItemIndex: int

var currentItem: WorkBenchItem

func get_current_item():
	return currentItem

func update_current_item_index(index: int):
	currentItemIndex = index
	currentItem = items[index]

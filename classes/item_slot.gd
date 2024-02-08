extends Button

class_name ItemSlot

@onready var backgroundSprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer
@onready var inventory: Inventory = preload("res://assets/inventory/inventory.tres") 

var itemStackGUI: ItemStackGUI
var index: int


func insert(isg: ItemStackGUI):
	itemStackGUI = isg
	container.add_child(itemStackGUI)
	
	
	if !itemStackGUI.inventorySlot || inventory.slots[index] == itemStackGUI.inventorySlot: return
	
	inventory.updateSlot(index, itemStackGUI.inventorySlot)
	
func remove(isg: ItemStackGUI):
	
	container.remove_child(itemStackGUI) 
	itemStackGUI = null
	
	
func takeItem():
	var item = itemStackGUI
	inventory.removeSlot(itemStackGUI.inventorySlot)
	container.remove_child(itemStackGUI)
	itemStackGUI = null
	
	return item

func isEmpty():
	return !itemStackGUI

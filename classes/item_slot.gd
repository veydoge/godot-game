extends Button

class_name ItemSlot

@onready var backgroundSprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer



var itemStackGUI: ItemStackGUI

func insert(isg: ItemStackGUI):
	itemStackGUI = isg
	container.add_child(itemStackGUI)
	
func takeItem():
	var item = itemStackGUI
	container.remove_child(itemStackGUI)
	itemStackGUI = null
	
	return item

func isEmpty():
	return !itemStackGUI

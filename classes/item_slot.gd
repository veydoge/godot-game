extends Button


@onready var backgroundSprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer

var number
var itemStackGUI: ItemStackGUI

func insert(isg: ItemStackGUI):
	itemStackGUI = isg
	container.add_child(itemStackGUI)
	
func takeItem():
	var item = itemStackGUI
	container.remove_child(itemStackGUI)
	itemStackGUI = null
	
	return item

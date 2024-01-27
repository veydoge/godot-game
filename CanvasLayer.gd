extends CanvasLayer

@onready var inventory = $InventoryGUI

func _input(event):
	if (event.is_action_pressed("toggle_inventory")):
		if (get_node("../Area2D/shop") as Shop) && (get_node("../chest/workbench") as Workbench): # if shop and workbench exists
			if (get_node("../Area2D/shop") as Shop).isShopOpen == false && (get_node("../chest/workbench") as Workbench).isWorkbenchOpen == false:
				if inventory.isOpen:
					inventory.close()
				else:
					inventory.open()
		else:
			if inventory.isOpen:
				inventory.close()
			else:
				inventory.open()

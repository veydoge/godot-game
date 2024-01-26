extends TabBar


@onready var inventory = preload("res://assets/inventory/inventory.tres")
@onready var shop = preload("res://assets/shop/shopTres.tres")

func _ready():
	inventory.update_current_slot(inventory.slots[0])
	shop.update_current_item_index(0)
	showItem()

func showItem():
	$Control/Icon.texture = inventory.get_current_slot().item.texture
	$Control/Name.text = inventory.get_current_slot().item.name
	#$Control/Des.text = inventory.get_current_slot().item.description
	$Control/Des.text += "\n Цена: " + str(shop.get_current_item().cost)
	
func _on_next_pressed():
	if (inventory.currentItemIndex == inventory.items.size() - 1):
		inventory.update_current_item_index(0)
	else:
		inventory.update_current_item_index(inventory.currentItemIndex + 1)
	showItem()

func _on_prev_pressed():
	if (inventory.currentItemIndex == 0):
		inventory.update_current_item_index(inventory.items.size() - 1)
	else:
		inventory.update_current_item_index(inventory.currentItemIndex - 1)
	showItem()


func _on_closebtn_pressed():
	get_node("Anim").play("TransOut")
	get_tree().paused = false
	shop.update_current_item_index(0)
	showItem()


func _on_sell_pressed():
	inventory.delete(inventory.get_current_item().inventoryItem)

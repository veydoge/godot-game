extends Control

@onready var inventory = preload("res://assets/inventory/inventory.tres")
@onready var shop = preload("res://assets/shop/shopTres.tres")

func _ready():
	shop.update_current_item_index(0)
	showItem()

func showItem():
	$Icon.texture = shop.get_current_item().texture
	$Name.text = shop.get_current_item().name
	$Des.text = shop.get_current_item().description
	$Des.text += "\n Цена: " + str(shop.get_current_item().cost)
	
func _on_next_pressed():
	if (shop.currentItemIndex == shop.items.size() - 1):
		shop.update_current_item_index(0)
	else:
		shop.update_current_item_index(shop.currentItemIndex + 1)
	showItem()

func _on_prev_pressed():
	if (shop.currentItemIndex == 0):
		shop.update_current_item_index(shop.items.size() - 1)
	else:
		shop.update_current_item_index(shop.currentItemIndex - 1)
	showItem()

func _on_buy_pressed():
	$Error.text = ""
	if SaveCoins.coin >= shop.get_current_item().cost:
		SaveCoins.coin -= shop.get_current_item().cost
		inventory.insert(shop.get_current_item().inventoryItem)
		SaveCoins.save_coin()
	else:
		$Error.text = "Недостаточно монет"


func _on_closebtn_pressed():
	get_node("../../Anim").play("TransOut")
	get_parent().get_parent().get_parent().get_parent().get_node("BottomInventory").visible = true
	get_tree().paused = false
	(get_node("../..") as Shop).isShopOpen = false
	shop.update_current_item_index(0)
	showItem()

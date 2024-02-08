extends Control

@onready var inventory = preload("res://assets/inventory/inventory.tres")
@onready var shop = preload("res://assets/shop/shopTres.tres")

var itemsForSell = {}
var currentItemIndex : int
var currentItem : ShopItem
var currentItemAmount : int

func _ready():
	inventory.updated.connect(sortItemsForSell)
	sortItemsForSell()

func sortItemsForSell():
	itemsForSell = {}
	for shopItem in shop.items:
		for inventorySlot in inventory.slots:
			if shopItem.inventoryItem == inventorySlot.item:
				if !itemsForSell.has(shopItem):
					itemsForSell[shopItem] = inventorySlot.amount
				else:
					itemsForSell[shopItem] += inventorySlot.amount
	if itemsForSell.size() != 0:
		$Error.visible = false
		$Name.visible = true
		$Next.visible = true
		$Prev.visible = true
		$Des.visible = true
		$Sell.visible = true
		$Icon.visible = true
		currentItemIndex = 0
		currentItem = itemsForSell.keys()[currentItemIndex]
		currentItemAmount = itemsForSell[currentItem]
		showItem()
	else:
		$Error.visible = true
		$Name.visible = false
		$Next.visible = false
		$Prev.visible = false
		$Des.visible = false
		$Sell.visible = false
		$Icon.visible = false
		
func showItem():
	$Icon.texture = currentItem.inventoryItem.texture
	$Name.text = currentItem.inventoryItem.name
	$Des.text = "\n Цена: " + str(currentItem.cost)
	$Amount.text = "У вас %s штук" % currentItemAmount

func _on_next_pressed():
	if (currentItemIndex == itemsForSell.size() - 1):
		currentItemIndex = 0
		currentItem = itemsForSell.keys()[currentItemIndex]
	else:
		currentItemIndex += 1
		currentItem = itemsForSell.keys()[currentItemIndex]
	showItem()

func _on_prev_pressed():
	if (currentItemIndex == 0):
		currentItemIndex = itemsForSell.size() - 1
		currentItem = itemsForSell.keys()[currentItemIndex]
	else:
		currentItemIndex -= 1
		currentItem = itemsForSell.keys()[currentItemIndex]
	showItem()

func _on_closebtn_pressed():
	get_node("../../Anim").play("TransOut")
	get_tree().paused = false
	currentItemIndex = 0
	currentItem = itemsForSell.keys()[currentItemIndex]
	showItem()

func _on_sell_pressed():
	if (currentItemAmount == 1):
		inventory.remove_item(currentItem.inventoryItem)
		itemsForSell.erase(currentItem)
	else:
		var slotsWithThisItem = inventory.slots.filter(func(slot): return slot.item.name == currentItem.name)
		slotsWithThisItem[slotsWithThisItem.size() - 1].amount -= 1
		currentItemAmount -= 1
		
	if (itemsForSell.keys().size() == 0):
		$Error.visible = true
		$Name.visible = false
		$Next.visible = false
		$Prev.visible = false
		$Des.visible = false
		$Sell.visible = false
		$Icon.visible = false
	else:
		$Amount.text = "У вас %s штук" % currentItemAmount

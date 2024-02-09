extends CanvasLayer

class_name Workbench

var isWorkbenchOpen = false

@onready var inventory = preload("res://assets/inventory/inventory.tres")
@onready var wb = preload("res://assets/workbrench/WorkBenchTres.tres")

func _ready():
	wb.update_current_item_index(0)
	showItem()
	
func _on_closebtn_pressed():
	get_node("AnimationPlayer").play("TrainOut")
	get_parent().get_parent().get_node("BottomInventory").visible = true
	get_tree().paused = false
	isWorkbenchOpen = false
	wb.update_current_item_index(0)
	showItem()

func showItem():
	get_node("Control/Sprite2D").texture = wb.get_current_item().texture
	get_node("Control/Title").text = wb.get_current_item().name
	get_node("Control/Des").text = wb.get_current_item().description
	get_node("Control/Resource").text = str(wb.get_current_item().resource).replace("{", "").replace("}", "").replace("\"", "")
	
func _on_next_pressed():
	if (wb.currentItemIndex == wb.items.size() - 1):
		wb.update_current_item_index(0)
	else:
		wb.update_current_item_index(wb.currentItemIndex + 1)
	showItem()

func _on_prev_pressed():
	if (wb.currentItemIndex == 0):
		wb.update_current_item_index(wb.items.size() - 1)
	else:
		wb.update_current_item_index(wb.currentItemIndex - 1)
	showItem()

func _on_buy_pressed():
	var dic = wb.get_current_item().resource
	var neededWood = dic["Ветка"]
	var neededStone = dic["Камень"]
	var woodAmount = 0
	var stoneAmount = 0
	var woodSlot
	var stoneSlot
	var hasAllResources = false
	for slot in inventory.slots:
		if slot.item != null:
			if slot.item.name == "Ветка":
				woodAmount += slot.amount
				woodSlot = slot
			elif slot.item.name == "Камень":
				stoneAmount += slot.amount
				stoneSlot = slot
				
	if neededStone > stoneAmount || neededWood > woodAmount:
			get_node("Control/Title").text = "Недостаточно ресурсов"
	else:
		hasAllResources = true
		if (neededWood == woodAmount):
			inventory.removeSlot(woodSlot)
		else:
			inventory.slots[inventory.slots.find(woodSlot)].amount -= woodAmount
			
		if (neededStone == stoneAmount):
			inventory.removeSlot(stoneSlot)
		else:
			inventory.slots[inventory.slots.find(stoneSlot)].amount -= stoneAmount
			
	if hasAllResources:
		inventory.insert(wb.get_current_item().inventoryItem)

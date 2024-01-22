extends Resource

class_name Inventory

signal updated
signal current_slot_updated

var selected_image = preload("res://assets/inventory/icons/Inventory_Selected_Slot.png")
var default_image = preload("res://assets/inventory/icons/Inventory_Slot_1.png")

@export var slots : Array[InventorySlot]

var current_slot: InventorySlot

func insert(item: InventoryItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
			emptySlots[0].texture = default_image
	updated.emit()

func get_current_slot():
	return current_slot

func update_current_slot(slot: InventorySlot):
	if current_slot != null:
		current_slot.texture = default_image
	current_slot = slot
	current_slot.texture = selected_image
	current_slot_updated.emit()

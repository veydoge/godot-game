extends Control

signal opened
signal closed

@onready var inventory = preload("res://assets/inventory/inventory.tres") 
@onready var ItemStackGUIClass = preload("res://item_stackGUI.tscn")
@onready var slots: Array = $GridContainer.get_children()
var isOpen = false
var itemInHand: ItemStackGUI

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slots[i])
		slots[i].pressed.connect(callable)
		
		if !inventorySlot.item: continue
		
		var itemStackGUI: ItemStackGUI = slots[i].itemStackGUI
		if !itemStackGUI:
			itemStackGUI = ItemStackGUIClass.instantiate()
			slots[i].insert(itemStackGUI)
		itemStackGUI.inventorySlot = inventorySlot
		itemStackGUI.update()
		
		
			
func _ready():
	update()
	inventory.updated.connect(update)	
	
func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
	
func onSlotClicked(slot):
	
	if slot.isEmpty() && itemInHand:
		insertItemInSlot(slot)
	
		return
		
	if !itemInHand:
		takeItemFromSlot(slot)
	
func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	move_child(itemInHand, 0)
	updateItemInHand()
	
	
func insertItemInSlot(slot):
	var item = itemInHand
	remove_child(itemInHand)
	
	itemInHand = null
	
	slot.insert(item)
	
func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2
	
func _input(_event):
	updateItemInHand()

	

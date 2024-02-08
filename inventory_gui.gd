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
		
		slots[i].index = i

		if !inventorySlot.item:
			slots[i].remove(slots[i].itemStackGUI)
			continue
		
		var itemStackGUI: ItemStackGUI = slots[i].itemStackGUI
		if !itemStackGUI:
			itemStackGUI = ItemStackGUIClass.instantiate()
			slots[i].insert(itemStackGUI)
		itemStackGUI.inventorySlot = inventorySlot
		itemStackGUI.update()
		
func connectSlots():
	for i in range(min(inventory.slots.size(), slots.size())):
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slots[i])
		slots[i].pressed.connect(callable)
			
func _ready():
	connectSlots()
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
	
	if slot.isEmpty():
		if !itemInHand: return
		insertItemInSlot(slot)
		return
	
	if !itemInHand:
		takeItemFromSlot(slot)
		return
		
	if slot.itemStackGUI.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
		stackItems(slot)
		return
	swapItems(slot)

func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	move_child(itemInHand, 0)
	updateItemInHand()
	
func swapItems(slot):
	var tempItem = slot.takeItem()
	
	insertItemInSlot(slot)
	itemInHand = tempItem
	add_child(itemInHand)
	move_child(itemInHand, 0)
	updateItemInHand()
	
func stackItems(slot):
	var slotItem: ItemStackGUI = slot.itemStackGUI
	var maxAmount = slotItem.inventorySlot.item.maxAmountPrStack
	var totalAmount = slotItem.inventorySlot.amount + itemInHand.inventorySlot.amount
	
	if slotItem.inventorySlot.amount == maxAmount:
		swapItems(slot)
		return
	if totalAmount <= maxAmount:
		slotItem.inventorySlot.amount = totalAmount
		remove_child(itemInHand)
		itemInHand = null
	else:
		slotItem.inventorySlot.amount = maxAmount
		itemInHand.inventorySlot.amount = totalAmount - maxAmount
		
	slotItem.update()
	if itemInHand: itemInHand.update()	
	
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

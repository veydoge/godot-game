extends Control

signal opened
signal closed

@onready var inventory = preload("res://assets/inventory/inventory.tres") 
@onready var ItemStackGUIClass = preload("res://item_stackGUI.tscn")
@onready var slots: Array = $GridContainer.get_children()
var isOpen = false

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackGUI: ItemStackGUI = slots[i].itemStackGUI
		if !itemStackGUI:
			itemStackGUI = ItemStackGUIClass.instantiate()
			slots[i].insert(itemStackGUI)
		itemStackGUI.inventorySlot = inventorySlot
		itemStackGUI.update()
		
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slots[i])
		itemStackGUI.pressed.connect(callable)
			
		
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
	print("123")

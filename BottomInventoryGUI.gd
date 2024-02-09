extends Control

@onready var inventory = preload("res://assets/inventory/inventory.tres") 
@onready var ItemStackGUIClass = preload("res://item_stackGUI.tscn")
@onready var slots: Array = $GridContainer.get_children()

func update():
	for i in range(5):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: 
			slots[i].remove(slots[i].itemStackGUI)
			continue
		
		var itemStackGUI: ItemStackGUI = slots[i].itemStackGUI
		if !itemStackGUI:
			itemStackGUI = ItemStackGUIClass.instantiate()
			slots[i].insert(itemStackGUI)
		itemStackGUI.inventorySlot = inventorySlot
		itemStackGUI.update_bottom_inventory_slot()

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.updated.connect(update)  
	inventory.current_slot_updated.connect(update)
	update()

extends Control

signal opened
signal closed

@onready var inventory = preload("res://assets/inventory/inventory.tres") 
@onready var slots: Array = $GridContainer.get_children()
var isOpen = false

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
		
func _ready():
	connectSlots()
	inventory.updated.connect(update)	
	update()

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
	
func connectSlots():
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callalbe.bind(slot)
		slot.slotButton.pressed.connect(onSlotClicked)
		
func onSlotClicked(slot):
	print("123")

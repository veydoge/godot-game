extends Button

class_name ItemStackGUI

@onready var backgroundSprite: Sprite2D = $"../../background"
@onready var itemsprite: TextureRect = $item2d
@onready var amountlabel: Label = $Label

var inventorySlot : InventorySlot

func update():
	
	if !inventorySlot || !inventorySlot.item: return
	itemsprite.visible = true
	itemsprite.texture = inventorySlot.item.texture
	
	if inventorySlot.amount > 1:
		amountlabel.visible = true
		amountlabel.text = str(inventorySlot.amount)
	else:
		amountlabel.visible = false
	

func update_bottom_inventory_slot():
	if !inventorySlot || !inventorySlot.item: return
	itemsprite.visible = true
	itemsprite.texture = inventorySlot.item.texture
	
	backgroundSprite.texture = inventorySlot.texture
	
	if inventorySlot.amount > 1:
		amountlabel.visible = true
		amountlabel.text = str(inventorySlot.amount)
	else:
		amountlabel.visible = false

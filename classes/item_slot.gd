extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemsprite: TextureRect = $CenterContainer/Panel/item2d
@onready var amountlabel: Label = $CenterContainer/Panel/Label

func update(slot: InventorySlot):
	if !slot.item:
		itemsprite.visible = false
		amountlabel.visible = false
	else:
		amountlabel.text = str(slot.amount)
		amountlabel.visible = true
		
		itemsprite.visible = true
		itemsprite.texture = slot.item.texture

func update_bottom_inventory_slot(slot: InventorySlot):
	if !slot.item:
		itemsprite.visible = false
		amountlabel.visible = false
	else:
		amountlabel.text = str(slot.amount)
		amountlabel.visible = true
		
		backgroundSprite.texture = slot.texture
		
		itemsprite.visible = true
		itemsprite.texture = slot.item.texture
  
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

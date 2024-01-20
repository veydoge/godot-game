extends "res://classes/destroyable.gd"

func _on_body_entered(body):
	if body.name == "Player":
		isPlayerNear = true

func _on_body_exited(body):
	if body.name == "Player":
		isPlayerNear = false

func _input(event):
	if event.is_action_pressed("beat"):
		if isPlayerNear:
			if inventory.get_current_slot() != null:
				if inventory.get_current_slot().item != null:
					if inventory.get_current_slot().item.name == "pickaxe":
						super.beat()

extends "res://classes/collectable.gd"

func _on_body_entered(body):
	if body.name == "Player":
		isPlayerNear = true

func _on_body_exited(body):
	if body.name == "Player":
		isPlayerNear = false

func _input(event):
	if event.is_action_pressed("take"):
		if isPlayerNear:
			super.collect()

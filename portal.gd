extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if get_tree().current_scene.name == "world":
			get_tree().change_scene_to_file("res://generated_tiles.tscn")
		else:
			get_tree().change_scene_to_file("res://load_scenes/Node2D_sofa.tscn")

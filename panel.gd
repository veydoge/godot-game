extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = true

func _on_button_pressed():
	get_tree().change_scene_to_file("res://load_scenes/Node2D_sofa.tscn")
	self.queue_free()

extends Panel

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if World.player_health == 0:
		visible = true
		


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Node2D.tscn")
	self.queue_free()
	

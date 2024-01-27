extends Area2D

func _ready():
	visible = false

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play("sword")

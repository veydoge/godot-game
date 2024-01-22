extends AnimatedSprite2D

@onready var animations = get_node("/root/world/AnimatedSprite2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("boiler")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

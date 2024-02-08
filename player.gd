extends CharacterBody2D

const speed = 200

@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var tileMap : TileMap = $"../TileMap"


func _ready() -> void:
	#var spawnPos = tileMap.RoomArray[0].center
	#self.position = spawnPos
	pass
	

func _physics_process(delta):
	if (velocity.x == 0):
		animatedSprite.play("idle")
		
	var Direction = Input.get_vector("leftmove", "rightmove", "upmove", "downmove")
	if (Direction != Vector2.ZERO):
		velocity.x = Direction.x * speed	
		velocity.y = Direction.y * speed
		if (velocity.x < 0):
			animatedSprite.play("going_left")
			animatedSprite.flip_h = false
		if (velocity.x > 0):
			animatedSprite.play("going_left")
			animatedSprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	move_and_collide(velocity * delta)

extends Node2D

@onready var player = $player
@onready var tileMap = $TileMap

func _ready() -> void:
	player.position = tileMap.RoomArray[0].center
	

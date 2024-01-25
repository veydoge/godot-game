extends Node

var path = "res://saveCoins.dat"
var coin = 100

func _ready():
	load_coin()
	if coin == 0:
		coin = 1000
	
func save_coin():
	var file = FileAccess.open(path, FileAccess.WRITE_READ)
	file.store_32(coin)

func load_coin():
	var	file = FileAccess.open(path, FileAccess.READ)
	if FileAccess.file_exists(path):
		coin = file.get_32()

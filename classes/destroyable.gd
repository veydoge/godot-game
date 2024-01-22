extends Area2D

@export var itemRes: InventoryItem

@onready var inventory = preload("res://assets/inventory/inventory.tres") 

var health = 3
var isPlayerNear = false

func beat():
	health = health - 1
	if health == 0:
		inventory.insert(itemRes)
		queue_free()

extends Area2D

@export var itemRes: ShopItem

@onready var inventory = preload("res://assets/inventory/inventory.tres") 

func buy():
	var newItem = InventoryItem.new()
	newItem.name = itemRes.name
	newItem.texture = itemRes.texture
	inventory.insert(newItem)

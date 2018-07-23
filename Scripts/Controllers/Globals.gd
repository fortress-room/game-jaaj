extends Node

onready var player = get_node("/root/Node2D/Instances/Player")
onready var player_inventory = get_node("/root/Node2D/UI/Inventory")

func set_player_weight(weight):
	player.carrying_weight = weight

func add_item(item):
	player_inventory.add_item(item, 1)
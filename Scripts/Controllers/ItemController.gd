extends Area2D

var info_file_path = "res://Resources/items.json"

export var item_name = 'Madeira'

var can_be_added = false
var weight
var player

"""
IMPORTANT !!!
see if worth it to detect the weight and handle error here instead of 
inventory controller. probably it's better to did it here!
EXAMPLE -> HOW TO ADD AN ITEM:
=> Globals.add_item('Pedregulho')
"""

func _ready():
	var info_file = File.new()
	info_file.open(info_file_path, info_file.READ)
	var json = parse_json(info_file.get_as_text())
	
	weight = json["item_weight"][item_name]	
	var weight

func _body_entered(body):
	if body.is_in_group("player"):
		player = body
		Globals.add_item(item_name)
		queue_free()
		can_be_added = true

func _body_exited(body):
	if body.is_in_group("player"):
		can_be_added = false

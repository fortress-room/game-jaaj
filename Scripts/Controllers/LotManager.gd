extends Node2D

var houses_file_path = "res://Resources/houses.json"

var level = "01"
var house_type

"""
Notes to do this script:
	1: This code are going to manage buildings since they need to be created 'til they're finished.
	X: I need to save into a JSON object every house_type and every resource needed to create to quickly get here.
	3.1: I need to have a son ui node showing and able to select the materials and send to him to complete the house
	3.2: And after the 3.1, have to destroy this son (if the house is completed!!!)
	
"""

func _ready():
	randomize()
	
	# Create and open the File
	var file = File.new()
	file.open(houses_file_path, file.READ)
	
	# Get file as text and parse it into a JSON dictionary
	var json = file.get_as_text()
	json = parse_json(json)
	
	# Generate a random_index based in current level and assign it to current house
	var index = randi() % (json["level_" + level].size())
	house_type = json["level_" + level][index]

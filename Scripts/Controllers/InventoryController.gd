extends Control

# Slot lines to proper control
onready var line1_slots = $Background/VSeparator/L1
onready var line2_slots = $Background/VSeparator/L2
onready var line3_slots = $Background/VSeparator/L3

# Item slot nodes array
var item_slots = []
var selected_slot_node
var selected_slot_index

# Current selected line
var current_line

# Weight handling:
var maximum_weight = 2500
var current_weight = 0


# Array of dictionaries to store items
var items = [{}, {}, {}, {}, {}, {}, {}, {}, {}]

func _ready():
	
	# RESET AND GET INVENTORY SLOTS
	selected_slot_index = 0
	current_line = 0
	
	for child in line1_slots.get_children():
		item_slots.append(child)
	
	for child in line2_slots.get_children():
		item_slots.append(child)
	
	for child in line3_slots.get_children():
		item_slots.append(child)
	
	
	selected_slot_node = item_slots[selected_slot_index]
	
	# Sets initial position of Selector
	$ColorRect.set_global_position(selected_slot_node.get_global_position()) # TODO: CHANGES TO ACTUAL SPRITE
	
	# Test callings
	add_item('Madeira', 2)
	add_item('Madeira', 1)
	#remove_item('Pedregulho', 2)

func _physics_process(delta):
	
	# INPUT HANDLINGS
	
	if Input.is_action_just_pressed("ui_right"):
		if selected_slot_index == 2 || selected_slot_index == 5 || selected_slot_index == 8:
			return
		selected_slot_index += 1
		_change_selected(selected_slot_index)
		
	elif Input.is_action_just_pressed("ui_left"):
		if selected_slot_index == 0 || selected_slot_index == 3 || selected_slot_index == 6:
			return
		selected_slot_index -= 1
		_change_selected(selected_slot_index)
	
	elif Input.is_action_just_pressed("ui_down"):
		if selected_slot_index < 6:
			selected_slot_index += 3
			_change_selected(selected_slot_index)
			
	elif Input.is_action_just_pressed("ui_up"):
		if selected_slot_index > 2:
			selected_slot_index -= 3
			_change_selected(selected_slot_index)

# Updates selected slot
func _change_selected(selected_slot):
	print(items)
	selected_slot_node = item_slots[selected_slot]
	$ColorRect.set_global_position(selected_slot_node.get_global_position())

# Add item function
func add_item(item_id, amount):
	
	var file = File.new()
	file.open("res://Resources/items.json", file.READ)
	var json = file.get_as_text()
	json = parse_json(json)
	
	
	for i in items.size():
		if items[i].empty():
			items[i] = {str(item_id): amount}
			current_weight += json["item_weight"][item_id] * amount
			print(current_weight)
			return
		else:
			for key in items[i].keys():
				if key == item_id:
					for value in items[i].values():
						print('going here')
						items[i] = {item_id: value + amount}
						return

	
	# TODO: Proper handling weights
	# TODO: Proper handling errors

# Remove item function
func remove_item(item_id, amount):
	for item in items.size():
		if items[item].has(item_id):
			for value in items[item].values():
				items[item] = {item_id : value - amount}
				if (value - amount) == 0:
					# Clears slot if no more items of this type
					items[item] = {}
					return
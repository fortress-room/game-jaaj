extends Control

onready var line1_slots = $Background/VSeparator/L1
onready var line2_slots = $Background/VSeparator/L2
onready var line3_slots = $Background/VSeparator/L3

var item_slots = []
var selected_slot_node
var selected_slot_index
var current_line

var items = [{}, {}, {}, {}, {}, {}, {}, {}, {}]

func _ready():	
	selected_slot_index = 0
	current_line = 0
	
	for child in line1_slots.get_children():
		item_slots.append(child)
	
	for child in line2_slots.get_children():
		item_slots.append(child)
	
	for child in line3_slots.get_children():
		item_slots.append(child)
	
	
	selected_slot_node = item_slots[selected_slot_index]
	$ColorRect.set_global_position(selected_slot_node.get_global_position())
	
	add_item('banana', 2)
	add_item('maracuja', 1)
	remove_item('banana', 2)

func _physics_process(delta):
	
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

func _change_selected(selected_slot):
	print(items)
	selected_slot_node = item_slots[selected_slot]
	$ColorRect.set_global_position(selected_slot_node.get_global_position())

func add_item(item_id, amount):
	for i in items.size():
		if items[i].empty():
			items[i] = {str(item_id): amount}
			return
		elif items.has(items[i]):
			for value in items[i].values():
				items[i] = {item_id: value + amount}
				return
			
	"""for item in items:
		if item.empty():
			items[item] = {item_id : amount}
		elif items.has(item_id):
			items[item_id] += amount"""

func remove_item(item_id, amount):
	for i in items.size():
		if items[i].empty():
			for value in items[i].values():
				items[i] = {item_id: value - amount}
				if value == 0:
					items[i] = {}
					return

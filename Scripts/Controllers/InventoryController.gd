extends Control

onready var line1_slots = $Background/VSeparator/L1
onready var line2_slots = $Background/VSeparator/L2
onready var line3_slots = $Background/VSeparator/L3

var item_slots = []
var selected_slot_node
var selected_slot_index
var current_line

var items = {}

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
	print(item_slots.size())
	print(items.size())
	
	
	add_item('banana', 2)
	add_item('maracuja', 1)

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
	#print(selected_slot)
	$ColorRect.set_global_position(selected_slot_node.get_global_position())

func add_item(item_id, amount):
	if items.size() < item_slots.size():
		for slot in items:
			if slot.has(item_id):
				items[item_id] += amount
			else:
				items[item_id] = amount

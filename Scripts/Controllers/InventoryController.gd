extends Control

onready var line1_slots = $Background/VSeparator/L1
onready var line2_slots = $Background/VSeparator/L2
onready var line3_slots = $Background/VSeparator/L1

var item_slots = []
var selected_slot

func _ready():
	for child in line1_slots.get_children():
		item_slots.append(child)
	
	for child in line2_slots.get_children():
		item_slots.append(child)
	
	for child in line3_slots.get_children():
		item_slots.append(child)
	
	selected_slot = item_slots[1]
	$ColorRect.set_global_position(selected_slot.get_global_position())
	print(item_slots)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_right"):
		pass

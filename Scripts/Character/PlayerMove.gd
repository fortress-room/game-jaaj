extends KinematicBody2D

var motion = Vector2()
var ground = Vector2(0, -1)

const GRAVITY = 30
const JUMP_HEIGHT = -500

var speed = 200

enum {
	IDLE,
	WALKING,
	GATHERING,
}
var state = IDLE

var animation = 'default'
var old_animation = 'default'

func _physics_process(delta):
	_move(delta)


func _move(delta):
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -speed
	elif Input.is_action_pressed("ui_right"):
		motion.x = speed
	else:
		motion.x = 0
	
	if Input.is_action_pressed("ui_up"):
		motion.y = -speed
	elif Input.is_action_pressed("ui_down"):
		motion.y = speed
	else:
		motion.y = 0
	
	motion = move_and_slide(motion, ground)
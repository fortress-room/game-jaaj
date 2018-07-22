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

var current_animation = 'default'
var old_animation = 'default'

func _physics_process(delta):
	_move(delta)


func _move(delta):
	
	# Movement controlling handlers
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
	
	# Animation control handlers
	if Input.is_action_pressed("ui_up"):
		_play_animation()
		if Input.is_action_pressed("ui_left"):
			_play_animation()
		elif Input.is_action_pressed("ui_right"):
			print('bilu')
	
	if Input.is_action_pressed("ui_down"):
		_play_animation()
		if Input.is_action_pressed("ui_left"):
			_play_animation()
		elif Input.is_action_pressed("ui_right"):
			print('bolu')
	
	
func _play_animation():
	if current_animation != old_animation:
		# TODO: play new animation
		old_animation = current_animation
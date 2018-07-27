extends KinematicBody2D

# MOVEMENT VARIABLES
var motion = Vector2()
var ground = Vector2(0, -1)

const GRAVITY = 30
const JUMP_HEIGHT = -500

var speed = 200

########################################
# ANIMATION VARIABLES
enum {
	IDLE,
	WALKING,
	GATHERING,
}
var state = IDLE

var current_animation = 'default'
var old_animation = 'default'

########################################

# MISC
var carrying_weight = 0


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
	if Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_down") and !Input.is_action_pressed("ui_up"):
		_play_animation('w_l')
		speed = 200
	elif Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_down") and !Input.is_action_pressed("ui_up"):
		_play_animation('w_r')
		speed = 200
		
	if Input.is_action_pressed("ui_up"):
		if Input.is_action_pressed("ui_left"):
			_play_animation('w_ul')
			speed = 150
		elif Input.is_action_pressed("ui_right"):
			_play_animation('w_ur')
			speed = 150
		else:
			_play_animation('w_u')
			speed = 200
	
	if Input.is_action_pressed("ui_down"):
		if Input.is_action_pressed("ui_left"):
			_play_animation('w_dl')
			speed = 150
		elif Input.is_action_pressed("ui_right"):
			_play_animation('w_dr')
			speed = 150
		else:
			_play_animation('w_d')
			speed = 200
	
	
	
func _play_animation(animation):
	print(animation)
	current_animation = animation
	if current_animation != old_animation:
		$AnimatedSprite.play(animation)
		old_animation = current_animation
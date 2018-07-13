extends KinematicBody2D

var motion = Vector2()
var ground = Vector2(0, -1)

const GRAVITY = 30
const JUMP_HEIGHT = -500

var speed = 100

enum {
	IDLE,
	WALKING,
	JUMPING
}
var state = IDLE

var animation = 'default'
var old_animation = 'default'

func _ready():
	pass

func _physics_process(delta):
	_move(delta)


func _move(delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -speed
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h = true
		motion.x = speed
	else:
		motion.x = 0
	
	if motion.x != 0 and is_on_floor():
		state = WALKING
	
	if motion.x == 0 and is_on_floor():
		state = IDLE
	
	if !is_on_floor():
		state = JUMPING
	
	if Input.is_action_just_pressed('ui_up') and is_on_floor():
		motion.y = JUMP_HEIGHT
	
	motion = move_and_slide(motion, ground)
	
	if animation != old_animation:
		$AnimatedSprite.play(animation)
		old_animation = animation
	
	if state == IDLE:
		animation = 'default'
	elif state == WALKING:
		animation = 'walking'
	elif state == JUMPING:
		animation = 'jumping'
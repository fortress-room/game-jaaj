extends Area2D

"""
IMPORTANT !!!
see if worth it to detect the weight and handle error here instead of 
inventory controller. probably it's better to did it here!
"""
func _body_entered(body):
	if body.is_on_group("player"):
		pass # TODO: handle player can pick

func _body_exited(body):
	if body.is_on_group("player"):
		pass # TODO: handle player can't pick

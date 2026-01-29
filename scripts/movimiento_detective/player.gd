extends CharacterBody2D
	
const speed =30

func proceso_fisicas(delta):
	pass
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_just_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_just_pressed("ui_up"):
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_just_pressed("ui_down"):
		velocity.x = -speed
		velocity.y = 0

	pass
	

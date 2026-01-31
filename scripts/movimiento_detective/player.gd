extends CharacterBody2D

const speed = 60 
var current_dir = "down" # Default direction

func _physics_process(_delta): # Underscore tells Godot we aren't using delta here
	player_movement() # Removed delta
	move_and_slide()  # Keep this one
	
func player_movement(): # Removed delta
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		velocity = Vector2(speed, 0)
		play_anim(1)
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		velocity = Vector2(-speed, 0)
		play_anim(1)
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		velocity = Vector2(0, -speed)
		play_anim(1)
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		velocity = Vector2(0, speed)
		play_anim(1)
	else:
		velocity = Vector2.ZERO
		play_anim(0)
	# move_and_slide() was removed from here

func play_anim(movement):
	var anim = $AnimatedSprite2D
	
	if movement == 0:
		anim.stop() # Or play an "idle" animation
		return

	if current_dir == "right":
		anim.play("Move_right")
	elif current_dir == "left":
		anim.play("Move_left")
	elif current_dir == "down":
		anim.play("Move_down")
	elif current_dir == "up":
		anim.play("Move_up")

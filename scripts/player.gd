extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
	
const speed = 100 # Increased for visible movement
var current_dir = "none"

func _physics_process(delta):
	player_movement(delta)
	move_and_slide() # This is required to actually move!
	
func _ready():
	$AnimatedSprite2D.play("")
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed # Changed to Y axis
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed # Changed to Y axis
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("derecha")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("izquierda")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("abajo")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("arriba")

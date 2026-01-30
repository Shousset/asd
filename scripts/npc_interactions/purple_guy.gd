extends Area2D

# 1. These must be at the top so the Inspector can see them
@export var npc_animations: SpriteFrames
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

# 2. These links the script to your actual nodes
@onready var prompt = $ColorRect 
@onready var sprite_node = $AnimatedSprite2D

var is_player_in_range = false

func _ready():
	# This is the "animation branch" fix that prevents merging
	if npc_animations:
		# .duplicate() makes this specific NPC's frames unique 
		# so they don't all change at the same time.
		sprite_node.sprite_frames = npc_animations.duplicate()
		sprite_node.play() 
	
	# Connect signals for player detection
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Hide the interaction prompt (the box) immediately
	prompt.visible = false
	
func _on_body_entered(body):
	# Check for "Detective" (make sure your player node is named exactly this)
	if body.name == "Detective":
		is_player_in_range = true
		# Show the box when the player walks in
		prompt.visible = true 

func _on_body_exited(body):
	if body.name == "Detective":
		is_player_in_range = false
		# Hide the box when the player walks away
		prompt.visible = false 

func _input(event):
	# Trigger dialogue when player is close and presses the accept key
	if is_player_in_range and event.is_action_pressed("ui_accept"):
		# Hide it while talking so it doesn't cover the dialogue
		prompt.visible = false 
		
		if dialogue_resource:
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
extends Area2D

# This adds a slot in the Inspector to drop in different animations
@export var npc_animations: SpriteFrames
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

# @onready fetches the nodes as soon as the game starts
@onready var prompt = $ColorRect 
@onready var sprite_node = $AnimatedSprite2D

var is_player_in_range = false

func _ready():
	# Check if we actually assigned animations in the Inspector
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
	# Make sure your Player node is named exactly "Detective"
	if body.name == "Detective":
		is_player_in_range = true
		prompt.visible = true 

func _on_body_exited(body):
	if body.name == "Detective":
		is_player_in_range = false
		prompt.visible = false 

func _input(event):
	# Trigger dialogue when player is close and presses the accept key (Enter/Space)
	if is_player_in_range and event.is_action_pressed("ui_accept"):
		# Hide the prompt so it doesn't overlap the text
		prompt.visible = false 
		
		# Ensure the DialogueManager exists (requires the Dialogue Manager plugin)
		if dialogue_resource:
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

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
	if npc_animations:
		# DUPLICATE the frames so this NPC doesn't share with others
		sprite_node.sprite_frames = npc_animations.duplicate()
		sprite_node.play() 
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	prompt.visible = false
	
func _on_body_entered(body):
	# Check for "Detective" (make sure your player node is named exactly this)
	if body.name == "Detective":
		is_player_in_range = true
		# 2. Show the box when the player walks in
		prompt.visible = true 

func _on_body_exited(body):
	if body.name == "Detective":
		is_player_in_range = false
		# 3. Hide the box when the player walks away
		prompt.visible = false 

func _input(event):
	if is_player_in_range and event.is_action_pressed("ui_accept"):
		# 4. Hide it while talking so it doesn't cover the dialogue
		prompt.visible = false 
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

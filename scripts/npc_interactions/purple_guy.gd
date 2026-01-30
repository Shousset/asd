extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

# @onready fetches the node as soon as the game starts
@onready var prompt = $ColorRect 

var is_player_in_range = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# 1. This hides the box the very second the game runs
	prompt.visible = false
	
func _on_body_entered(body):
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

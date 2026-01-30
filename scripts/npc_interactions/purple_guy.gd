extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

# This line connects the script to your Label
@onready var interaction_label = $Label 

var is_player_in_range = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	# Make sure it starts hidden
	interaction_label.visible = false 

func _on_body_entered(body):
	if body.name == "Detective":
		is_player_in_range = true
		interaction_label.visible = true # SHOW the text

func _on_body_exited(body):
	if body.name == "Detective":
		is_player_in_range = false
		interaction_label.visible = false # HIDE the text

func _input(event):
	if is_player_in_range and event.is_action_pressed("ui_accept"):
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

extends Node2D

# This lets you pick a unique SpriteFrames file for every instance
@export var npc_animations: SpriteFrames

@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	if npc_animations:
		# .duplicate() ensures Instance A doesn't override Instance B
		anim_sprite.sprite_frames = npc_animations.duplicate()
		anim_sprite.play("default")

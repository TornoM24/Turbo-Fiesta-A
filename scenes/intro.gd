extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var progress = 0
onready var text = get_node ("RichTextLabel")
# Called when the node enters the scene tree for the first time.
func _ready():
	text.visible_characters = 0
	pass # Replace with function body.

func _process (delta):
	progress += delta
	if progress >= 0.02:
		text.visible_characters += 1
		progress = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

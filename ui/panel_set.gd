extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setText (title, desc):
	get_node ("Panel/ability_name").bbcode_text = title
	get_node ("Panel/ability_desc").bbcode_text = desc

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

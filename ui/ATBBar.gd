extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fullBar = preload("res://gfx/unit/atbbar2.png")
var fillBar = preload("res://gfx/unit/atb_f_bar_2.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if value>=100:
		texture_progress = fillBar
	else:
		texture_progress = fullBar

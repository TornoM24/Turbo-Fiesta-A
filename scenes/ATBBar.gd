extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fullBar = load("res://gfx/unit/atbbar.png")
var fillBar = load("res://gfx/unit/atb_f_bar.png")

var prog = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if value>=100:
		texture_progress = fullBar
	else:
		texture_progress = fillBar
	prog += delta
	if prog >= 0.01:
		value += 1
		prog = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

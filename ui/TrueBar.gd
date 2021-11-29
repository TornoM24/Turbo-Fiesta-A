extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var targetValue
var origin
onready var par = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	origin = self.rect_position
	pass # Replace with function body.

func _process (delta):
	value = par.targetValue
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

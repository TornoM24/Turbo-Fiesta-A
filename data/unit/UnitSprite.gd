extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var origin

# Called when the node enters the scene tree for the first time.
func _ready():
	origin = global_position
	pass # Replace with function body.

func get_current():
	return self.position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

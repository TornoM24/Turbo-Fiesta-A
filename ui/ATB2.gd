extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if value == max_value:
		modulate = Color (2,2,2,1)
	else:
		modulate = Color (1,1,1,1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

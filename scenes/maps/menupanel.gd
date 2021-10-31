extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var menu
# Called when the node enters the scene tree for the first time.
func _ready():	
	pass
func _process(delta):
	if modulate.a <= 0:
		hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cards = []
# Called when the node enters the scene tree for the first time.
func _ready():
	cards.clear()
	for x in range (1,5):
		cards[x] = get_node ("CP" + str(x))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

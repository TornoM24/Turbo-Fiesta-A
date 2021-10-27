extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var origin = rect_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func a_show ():
	show()
	var tween = get_node ("Tween")
	tween.interpolate_property(self, "rect_position",
		origin, Vector2(rect_position.x + 640, rect_position.y), 0.2,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()

func a_hide():
	var tween = get_node ("Tween")
	tween.interpolate_property(self, "rect_position",
		null, Vector2(rect_position.x - 640, rect_position.y), 0.4,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

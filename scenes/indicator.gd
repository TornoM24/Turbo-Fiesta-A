extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var tween = get_node ("Tween")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func warble():
	tween.interpolate_property(self, "rect_scale",
		null, Vector2 (1.1,1.1), 0.5,
	Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_all_completed():
	if rect_scale == Vector2 (0.9,0.9):
		tween.interpolate_property(self, "rect_scale",
			null, Vector2 (1.1,1.1), 0.5,
		Tween.TRANS_QUART, Tween.EASE_IN_OUT)
		tween.start()
	else:
		tween.interpolate_property(self, "rect_scale",
			null, Vector2 (0.9,0.9), 0.5,
		Tween.TRANS_QUART, Tween.EASE_IN_OUT)
		tween.start()
	pass # Replace with function body.

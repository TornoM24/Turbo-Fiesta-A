extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func open():
	var tween = get_parent().get_node ("Tween")
	tween.interpolate_property(self, "position",
		Vector2(-639.625,592), Vector2(640,592), 1,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var oneShot
var oneShotGrow
onready var tween = get_parent().get_node("Tween")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func kill():
		tween.interpolate_property(self, "rect_scale",
			null, Vector2(0,0), 0.2,
		Tween.TRANS_QUART, Tween.EASE_OUT)
		tween.start()

func _process(delta):
	if value == max_value:
		if !oneShot:
			oneShot = true
			tween.interpolate_property(self, "rect_scale",
				null, Vector2(0.6,0.2), 0.5,
			Tween.TRANS_QUART, Tween.EASE_OUT)
			tween.start()
		modulate = Color (2,2,2,1)
		oneShotGrow = false
	else:
		oneShot = false
		if !oneShotGrow:
			oneShotGrow = true
			tween.interpolate_property(self, "rect_scale",
				null, Vector2(0.5,0.12), 0.5,
			Tween.TRANS_QUART, Tween.EASE_OUT)
			tween.start()
		modulate = Color (1,1,1,1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

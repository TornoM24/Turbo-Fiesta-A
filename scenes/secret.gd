extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Test1
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")
	button.connect("pressed", self, "_button_pressed")
	button.connect("mouse_entered", self, "_mouse_entered")
	button.connect("mouse_exited", self, "_mouse_exited")
	oPos = self.rect_position

func _button_pressed():
	get_tree().quit()

var oPos
func _mouse_entered():
	var tween = get_parent().get_node("Tween")
	tween.interpolate_property(self, "rect_size",
			Vector2(256, 48), Vector2(320, 48), 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rect_position",
			oPos, Vector2 (oPos.x - 64, oPos.y), 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass

func _mouse_exited():
	var tween = get_parent().get_node("Tween")
	tween.interpolate_property(self, "rect_size",
			Vector2(320, 48), Vector2(256, 48), 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rect_position",
			Vector2 (oPos.x - 64, oPos.y), oPos, 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass

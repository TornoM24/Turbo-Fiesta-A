extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Test1
# Called when the node enters the scene tree for the first time.
var oPos
var oSize
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")
	button.connect("mouse_entered", self, "_mouse_entered")
	button.connect("mouse_exited", self, "_mouse_exited")
	oPos = self.rect_position
	oSize = self.rect_size

func _button_pressed():
	print("go")
	get_node("/root/Global").goto_scene("res://scenes/mainmenu.tscn")
	get_tree().paused = false
func _mouse_entered():
	var tween = get_parent().get_node("Tween")
	tween.interpolate_property(self, "rect_size",
			null, oSize+ Vector2(30, 0), 0.1,
			Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rect_position",
			null, Vector2 (oPos.x - 180, oPos.y), 0.1,
			Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	tween.start()
	pass

func _mouse_exited():
	var tween = get_parent().get_node("Tween")
	tween.interpolate_property(self, "rect_size",
			null, oSize, 0.1,
			Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rect_position",
			null, oPos, 0.1,
			Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	tween.start()
	pass

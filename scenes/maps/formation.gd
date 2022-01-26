extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var oPos
var oSize

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")
	button.connect("mouse_entered", self, "_mouse_entered")
	button.connect("mouse_exited", self, "_mouse_exited")
	oPos = self.rect_position
	oSize = self.rect_size
	
func _button_pressed():
	get_parent().get_node("partyview").switch_modes(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
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

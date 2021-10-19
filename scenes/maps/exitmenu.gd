extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Test1
# Called when the node enters the scene tree for the first time.
var oPos
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")
	button.connect("mouse_entered", self, "_mouse_entered")
	button.connect("mouse_exited", self, "_mouse_exited")
	oPos = self.rect_position

func close_menu():
	print ("closed menu")
	get_parent().get_parent().get_node("oc").hide()
	get_parent().get_node("partyview").hide()
	get_tree().paused = false
	get_parent().hide()

func _button_pressed():
	close_menu()

func _process(delta):
	pass
			
func _input(event):
	if event.is_action_released("esc"):
		if get_parent().visible:
			close_menu()
		else:
			get_parent().get_parent().get_node("menubutton").open_menu()
func _mouse_entered():
	var tween = get_parent().get_node("Tween")
	tween.interpolate_property(self, "rect_size",
			Vector2(168, 48), Vector2(192, 48), 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rect_position",
			oPos, Vector2 (oPos.x - 22, oPos.y), 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass

func _mouse_exited():
	var tween = get_parent().get_node("Tween")
	tween.interpolate_property(self, "rect_size",
			 Vector2(192, 48), Vector2(168, 48), 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rect_position",
			Vector2 (oPos.x - 22, oPos.y), oPos, 0.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass

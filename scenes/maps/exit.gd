extends Button

func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	var path = get_parent().get_parent().get_node("gridcontainer")
	path.visible = !path.visible
	get_parent().hide()


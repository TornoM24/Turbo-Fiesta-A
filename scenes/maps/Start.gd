extends TextureButton


func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")




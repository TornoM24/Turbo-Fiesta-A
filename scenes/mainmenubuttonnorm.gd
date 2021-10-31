extends Button

func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	print("go")
	get_node("/root/Global").goto_scene("res://scenes/mainmenu.tscn")
	get_tree().paused = false

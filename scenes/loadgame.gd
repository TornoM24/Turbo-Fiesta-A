extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Test1
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	print("loadgo")
	Master.load_game()
	get_node("/root/Global").goto_scene("res://scenes/maps/hub.tscn")

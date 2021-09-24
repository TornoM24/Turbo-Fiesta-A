extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var button = self

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", self, "_button_pressed")
	pass # Replace with function body.

func _button_pressed():
	print("Attempting to open game")
	$Start.hide()
	emit_signal("start_game")
	get_node("/root/Global").goto_scene("res://scenes/maps/hub.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

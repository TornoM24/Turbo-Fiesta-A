extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	print("Attempting to open combat interface!")
	get_node("/root/Global").goto_scene("res://scenes/combat.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

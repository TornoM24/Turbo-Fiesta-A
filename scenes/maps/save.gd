extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	Master.save_game()
	get_parent().get_node("exitmenu").close_menu()
	#get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

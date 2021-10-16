extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Test1
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

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

extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menu

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")
	
func _button_pressed():
	print("go")
	get_parent().get_node("partyview").show()
	get_parent().get_node("partyview").switch_modes(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

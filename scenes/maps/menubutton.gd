extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Test1
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	var path_menu = get_parent().get_node ("menupanel")
	var path_inventory = get_parent().get_node ("inventorypanel")
	var path_grid = get_parent().get_node ("gridcontainer")
	path_menu.visible = !path_menu.visible
	if path_inventory.visible:
		path_inventory.hide()
	path_inventory.hide()
	path_grid.hide()
	

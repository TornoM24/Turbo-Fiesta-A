extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var press
# Test1
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")
func open_menu():
	print ("opened menu")
	var path_menu = get_parent().get_node ("menupanel")
	var path_inventory = get_parent().get_node ("menupanel/inventorypanel")
	var path_grid = get_parent().get_node ("menupanel/gridcontainer")
	path_menu.visible = !path_menu.visible
	path_inventory.hide()
	path_grid.hide()
	path_menu.pause_mode = PAUSE_MODE_PROCESS
	get_parent().get_node("oc").show()
	get_parent().get_node("menupanel/partyview").cards_show()
	get_parent().get_node("menupanel/partyview").switch_modes (false)
	self.hide()
	get_tree().paused = true

func _button_pressed():
	open_menu()
	
func _process(delta):
	pass



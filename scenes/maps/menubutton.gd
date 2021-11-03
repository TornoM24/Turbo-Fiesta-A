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
	var oc = get_parent().get_node ("oc")
	var tween = get_parent().get_node("menupanel/Tween")
	tween.stop_all()
	tween.interpolate_property(path_menu, "modulate",
		Color (1,1,1,0), Color (1,1,1,1), 0.5,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_property(oc, "modulate",
		Color (1,1,1,0), Color (1,1,1,1), 0.5,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	path_menu.show()
	path_inventory.hide()
	path_grid.hide()
	path_menu.pause_mode = PAUSE_MODE_PROCESS
	get_parent().get_node ("menupanel/PStatDisplay/GoldDisplay").update()
	get_parent().get_node("oc").show()
	get_parent().get_node("menupanel/partyview").cards_show()
	get_parent().get_node("menupanel/partyview").switch_modes (false)
	self.hide()
	get_tree().paused = true

func _button_pressed():
	if !get_parent().get_node ("menupanel").visible:
		open_menu()
	
func _process(delta):
	pass



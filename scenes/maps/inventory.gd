extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	print("go")
	var path_inv = get_parent().get_parent().get_node ("menupanel/inventorypanel")
	var path_grid = get_parent().get_parent().get_node ("menupanel/gridcontainer")
	
	get_parent().get_node("partyview").hide()
	#path_inv.visible = !path_inv.visible
	#path_grid.visible = !path_grid.visible
	#get_parent().hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

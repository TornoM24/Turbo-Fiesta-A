extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var press
var isOpen = false
# Test1
# Called when the node enters the scene tree for the first time.
onready var path_menu = get_parent().get_node ("menupanel")
onready var path_inventory = get_parent().get_node ("menupanel/inventorypanel")
onready var path_grid = get_parent().get_node ("menupanel/gridcontainer")
onready var oc = get_parent().get_node ("oc")
onready var tween = get_parent().get_node("menupanel/Tween")
onready var bar1 = get_parent().get_node ("menupanel/cinematics/bar1")
onready var bar2 = get_parent().get_node ("menupanel/cinematics/bar2")
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")

func bars_toggle():
	isOpen=!isOpen
	if isOpen:
		tween.interpolate_property(bar1, "rect_position",
			null, Vector2 (bar1.rect_position.x, bar1.rect_position.y + 136), 0.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
		tween.interpolate_property(bar2, "rect_position",
			null, Vector2 (bar2.rect_position.x, bar2.rect_position.y - 136), 0.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	else:
		tween.interpolate_property(bar1, "rect_position",
			null, Vector2 (bar1.rect_position.x, bar1.rect_position.y - 136), 0.5,
		Tween.TRANS_QUART, Tween.EASE_IN)
		tween.interpolate_property(bar2, "rect_position",
			null, Vector2 (bar2.rect_position.x, bar2.rect_position.y + 136), 0.5,
		Tween.TRANS_QUART, Tween.EASE_IN)
	tween.start()
func open_menu():
	if !DialogManager.playerStun:
		print ("opened menu")
		tween.stop_all()
		bars_toggle()
		tween.interpolate_property(path_menu, "modulate",
			Color (1,1,1,0), Color (1,1,1,1), 0.5,
		Tween.TRANS_QUART, Tween.EASE_OUT)
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



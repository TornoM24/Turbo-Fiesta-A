extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Test1
# Called when the node enters the scene tree for the first time.
var oPos
var oSize
func _ready():
	var button = self
	button.connect("pressed", self, "_button_pressed")
	button.connect("mouse_entered", self, "_mouse_entered")
	button.connect("mouse_exited", self, "_mouse_exited")
	oPos = self.rect_position
	oSize = self.rect_size

func close_menu():
	print ("closed menu")
	#get_parent().get_parent().get_node("oc").hide()
	get_parent().get_parent().get_node("menubutton").show()
	fadeout()
	#get_parent().get_node("partyview").hide()
	get_tree().paused = false
	#get_parent().hide()
onready var tween = get_parent().get_node ("Tween")
onready var menu = get_parent()
onready var oc = get_parent().get_parent().get_node("oc")
onready var menubutton = get_parent().get_parent().get_node("menubutton")
func fadeout ():
	menubutton.bars_toggle()
	tween.interpolate_property(menu, "modulate",
		Color (1,1,1,1), Color (1,1,1,0), 0.5,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_property(oc, "modulate",
		Color (1,1,1,1), Color (1,1,1,0), 0.5,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
func _button_pressed():
	#if get_parent().visible && get_parent().get_node ("Tween").get_runtime <= 0:
	close_menu()
	pass
func _process(delta):
	pass
			
func _input(event):
	if event.is_action_released("esc"):
		if get_parent().visible:
			if get_parent().get_node ("Tween").get_runtime() <= 0:
				close_menu()
		else:
			get_parent().get_parent().get_node("menubutton").open_menu()
func _mouse_entered():
	if Master.fancy:
		var tween = get_parent().get_node("Tween")
		tween.interpolate_property(self, "rect_size",
				null, oSize+ Vector2(30, 0), 0.1,
				Tween.TRANS_QUART, Tween.EASE_IN_OUT)
		tween.interpolate_property(self, "rect_position",
				null, Vector2 (oPos.x - 180, oPos.y), 0.1,
				Tween.TRANS_QUART, Tween.EASE_IN_OUT)
		tween.start()

func _mouse_exited():
	if Master.fancy:
		var tween = get_parent().get_node("Tween")
		tween.interpolate_property(self, "rect_size",
				null, oSize, 0.1,
				Tween.TRANS_QUART, Tween.EASE_IN_OUT)
		tween.interpolate_property(self, "rect_position",
				null, oPos, 0.1,
				Tween.TRANS_QUART, Tween.EASE_IN_OUT)
		tween.start()
		pass

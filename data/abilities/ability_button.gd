extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var uName = "???"
var aName = "attack_my_balls"
var uDesc = "drink the pee pee"
var uID = -1

var selected = false
var inputType
# Called when the node enters the scene tree for the first time.
func _ready():
	#print (get_tree().get_root().get_node("Controller/Control").name)
	get_node("Button").connect ("pressed",get_tree().get_root().get_node("Controller/Control"),"_on_ability_pressed",[self, inputType])
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load("res://gfx/icons/empty.png")
	texture.create_from_image(image)
	get_node("Button").icon = texture
	pass # Replace with function body.

func disable_button ():
	get_node ("Button").disabled = true

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	selected = true
	get_tree().get_root().get_node("Controller/Control").ability_pressed(self,inputType)
	pass # Replace with function body.

var inBox = false
var isPressed = false

func _on_Button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				inputType = 1
			BUTTON_RIGHT:
				inputType = 2
		#print ("Selected the button for ability "+uName+" and succ. made it ", selected, " with input type ", inputType)
	pass # Replace with function body.


func _on_Button_mouse_exited():
	pass # Replace with function body.


func _on_Button_button_up():
	pass # Replace with function body.

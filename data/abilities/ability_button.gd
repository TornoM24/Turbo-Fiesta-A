extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var uName = "???"
var aName = "attack_my_balls"
var uDesc = "drink the pee pee"
var uID = -1

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button").connect ("pressed",get_parent().get_parent().get_parent().get_node ("Controller"),"_is_ability_pressed",[self])
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load("res://ui/pointer.png")
	texture.create_from_image(image)
	get_node("Button").icon = texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	selected = true
	print ("Selected the button for ability "+uName+" and succ. made it ", selected)
	pass # Replace with function body.

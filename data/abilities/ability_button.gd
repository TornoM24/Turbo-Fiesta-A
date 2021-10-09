extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var uName = "???"
var uDesc = "drink the pee pee"
var uID = -1

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	selected = true
	print ("Selected the button for ability "+uName+" and succ. made it ", selected)
	pass # Replace with function body.

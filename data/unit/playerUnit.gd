extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mhp = 100
var hp = 100

var mmp = 100
var mp = 100

var unitName = "Imposter Mongus"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateResources():
	var hpb = get_node("HPBar")
	var mpb = get_node("MPBar")
	hpb.value = hp
	mpb.value = mp

func _process(delta):
	updateResources()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Select_pressed():
	print ("Selected this unit.")
	pass # Replace with function body.

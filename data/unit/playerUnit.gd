extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mhp = 100
var hp = 90

var mmp = 100
var mp = 100

var atb_prog = 0
var atb_val = 0

var stats = {}
var effects = [] 

var unitName = "Aou Mogis"
var selected = false

var queue = []
var reference

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateResources():
	var hpb = get_node("HPBar")
	var mpb = get_node("MPBar")
	hpb.value = (float(stats.hp)/stats.mhp)*100
	#mpb.value =  (float(stats.mp)/

func _process(delta):
	updateResources()
	
	atb_prog += delta
	if atb_prog >= 0.01:
		atb_val += float (stats.spd)/10
		atb_prog = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Select_pressed():
	print ("Selected the unit "+unitName)
	selected = true
	pass # Replace with function body.


func _on_Select_mouse_entered():
	var x = get_node ("UnitSprite")
	var y = get_node ("AnimatedSprite")
	x.modulate.r = 1.2
	x.modulate.g = 1.2
	x.modulate.b = 1.2
	y.modulate.r = 1.2
	y.modulate.g = 1.2
	y.modulate.b = 1.2
	pass # Replace with function body.


func _on_Select_mouse_exited():
	var x = get_node ("UnitSprite")
	var y = get_node ("AnimatedSprite")
	x.modulate.r = 1
	x.modulate.g = 1
	x.modulate.b = 1
	y.modulate.r = 1
	y.modulate.g = 1
	y.modulate.b = 1
	pass # Replace with function body.

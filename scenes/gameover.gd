extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.r = 0
	modulate.g = 0
	modulate.b = 0
	pass # Replace with function body.

func _process(delta):
	if modulate.r < 1:
		modulate.r += delta/2
	if modulate.g < 1:
		modulate.g += delta/2
	if modulate.b < 1:
		modulate.b += delta/2
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

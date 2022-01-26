extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#hide()
	pass # Replace with function body.

func _process(delta):
	if modulate.a <= 0:
		hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var toggle = get_node ("menupanel/ModeToggle")

func _on_ModeToggle_toggled(button_pressed):
	pass # Replace with function body.

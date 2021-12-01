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

onready var toggle = get_node ("menupanel/SimpleButton")
func _on_SimpleButton_toggled(button_pressed):
	if toggle.pressed:
		Master.combatMode = "simple"
	else:
		Master.combatMode = "fancy"
	pass # Replace with function body.

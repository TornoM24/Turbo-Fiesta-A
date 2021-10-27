extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect ("pressed",get_parent().get_parent(),"_button_pressed",[self])
	connect ("mouse_entered",self,"_mouse_entered")
	connect ("mouse_exited",self,"_mouse_exited")
	pass # Replace with function body.

func _mouse_entered ():
	get_parent().modulate = Color (1.2,1.2,1.2,1)
	
func _mouse_exited ():
	get_parent().modulate = Color (1.0,1.0,1.0,1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

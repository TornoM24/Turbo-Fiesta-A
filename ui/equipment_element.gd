extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect ("pressed", get_parent().get_parent().get_parent().get_parent().get_parent().get_parent(), "_on_item_pressed", [self])
	pass # Replace with function body.

func _process(delta):
	if !visible:
		queue_free()
	#print (str (global_position))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# 6 getparents
var isGrabbed = false
func _on_Button_button_down():
	#print ("is dragging???")
	#var newP = get_node ("StatsPanel/Tabs/Equipment")
	#Master.reparent (self, newP)
	#get_parent().remove_child (self)
	#position = get_viewport().get_mouse_position()  - Vector2 (36,36)
	#print (str (global_position) + " and " + str (get_viewport().get_mouse_position() ))
	pass # Replace with function body.

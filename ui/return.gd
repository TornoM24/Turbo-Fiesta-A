extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _on_return_pressed():
	get_parent().hide()
	get_parent().get_parent().get_node ("Panel/buttonhost/acter/act").hide_buttons()
	pass # Replace with function body.


func _on_return_mouse_entered():
	get_parent().modulate = Color (1.4,1.4,1.4,1)
	pass # Replace with function body.


func _on_return_mouse_exited():
	get_parent().modulate = Color (1,1,1,1)
	pass # Replace with function body.


func _on_return_focus_entered():
	get_parent().modulate = Color (1.4,1.4,1.4,1)
	pass # Replace with function body.


func _on_return_focus_exited():
	get_parent().modulate = Color (1,1,1,1)
	pass # Replace with function body.

extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DetailButton_focus_entered():
	pass # Replace with function body.


func _on_DetailButton_mouse_entered():
	get_parent().modulate = Color (1.2,1.2,1.2,1)
	pass # Replace with function body.


func _on_DetailButton_mouse_exited():
	get_parent().modulate = Color (1,1,1,1)
	pass # Replace with function body.

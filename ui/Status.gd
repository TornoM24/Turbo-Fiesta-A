extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Status_pressed():
	var statusWin = load ("res://ui/character_status.tscn").instance()
	statusWin.generate_status(get_parent().get_parent().assignment)
	get_tree().get_root().add_child (statusWin)
	statusWin.sceneBase = "combat"
	get_tree().paused = true
	statusWin.pause_mode = PAUSE_MODE_PROCESS
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

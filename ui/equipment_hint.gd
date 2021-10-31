extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var yOffset = 0
var sceneBase
var freePath
# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_node ("Tween")
	tween.interpolate_property(self, "modulate",
		Color (1,1,1,0), Color (1,1,1,1), 0.2,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pause_mode = Node.PAUSE_MODE_PROCESS


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generateTip (item):
	pass

func _on_Button_pressed():
	get_node (freePath).pause_mode = PAUSE_MODE_PROCESS
	queue_free()
	pass # Replace with function body.

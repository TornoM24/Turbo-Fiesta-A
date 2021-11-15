extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print ("spawing message")
	get_node ("Timer").start()
	pass # Replace with function body.

func init (message):
	get_node ("Panel/RichTextLabel").bbcode_text = message

func _process(delta):
	if modulate.a <= 0:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var tween = get_node ("Tween")
	tween.interpolate_property (self, "modulate",
		Color (1,1,1,1), Color (1,1,1,0), 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	pass # Replace with function body.


func _on_Tween_tween_all_completed():
	queue_free()
	pass # Replace with function body.

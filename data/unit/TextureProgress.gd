extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var passOnce = false
var tweened = false
onready var tween = get_parent().get_node ("Tween")
# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	pass # Replace with function body.

func _process(delta):
	if get_parent().get_node ("Timer").time_left > 0:
#		if !tweened:
#			value = 0
#			tweened = true
		passOnce = true
		rect_scale = Vector2 (0.1,0.2)
		modulate.a = 1
#			#value = 100 * (1- float (get_parent().get_node ("Timer").time_left/get_parent().get_node ("Timer").wait_time))
#			tween.interpolate_property(self, "value",
#				0.0,100.0,get_parent().get_node ("Timer").wait_time,
#			Tween.TRANS_SINE, Tween.EASE_IN_OUT)
#			tween.start()
	else:
		if passOnce:
			expandPass()
			passOnce = false
			tweened = false
		#hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func expandPass():
	tween.interpolate_property(self, "rect_scale",
		Vector2 (0.1,0.2),Vector2 (0.2,0.4),0.5,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()
	tween.interpolate_property(self, "modulate",
		Color (1,1,1,1),Color (1,1,1,0),0.5,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()


extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var oneShot
var oneShotGrow
onready var tween = get_parent().get_node("Tween")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func kill():
	hide()
func _process(delta):
	if value == max_value:
		if !oneShot:
			oneShot = true
		modulate = Color (2,2,2,1)
		oneShotGrow = false
	else:
		oneShot = false
		if !oneShotGrow:
			oneShotGrow = true
		modulate = Color (1,1,1,1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

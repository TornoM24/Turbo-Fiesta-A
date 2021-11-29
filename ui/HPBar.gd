extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var targetValue
var origin
onready var src = get_parent().get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	origin = rect_position
	pass # Replace with function body.

func _process (delta):
	if src.active:
		var x = src.assignment
		targetValue = int((float(x.stats.hp)/x.stats.mhp)*100)
		if value < targetValue:
			value += 50 * delta
		elif value > targetValue:
			value -= 50 * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

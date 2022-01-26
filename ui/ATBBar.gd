extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var targetValue
onready var x = get_parent().get_parent().assignment
# Called when the node enters the scene tree for the first time.
func _ready():
	value = int((float(x.stats.mp)/x.stats.mmp)*100)
	targetValue = value
	pass # Replace with function body.

func _process (delta):
	targetValue = x.stats.mp
	if value < targetValue:
		value += 50 * delta
	elif value > targetValue:
		value -= 50 * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var bar = get_parent().get_node ("TextureProgress")
onready var tween = get_parent().get_node ("Tween")
var runOnce = true
func _process (delta):
	paused = Master.atb_paused
	bar.value = (wait_time - time_left)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

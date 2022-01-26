extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currentObj
var trueColliding = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if is_colliding():
		if get_collider().get_parent().name != "Player":
			trueColliding = true
			currentObj = get_collider().get_parent()
		else:
			trueColliding = false
	else:
		currentObj = null
		trueColliding = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

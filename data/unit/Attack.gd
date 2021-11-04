extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Attack_animation_finished():
	self.playing = false
	var lf = -1
	while lf != frame:
		print (frame)
		frame += 1
		lf +=1
	lf = frame
	pass # Replace with function body.

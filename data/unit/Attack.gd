extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var frameComplete = false
onready var par = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Attack_animation_finished():
	if par.meleeState:
		self.playing = false
#	var lf = -1
#	while lf != frame:
#		print (frame)
#		frame += 1
#		lf +=1
#	lf = frame
	pass # Replace with function body.


func _on_Attack_frame_changed():
	if par.meleeState:
		if frame in par.nFrames:
			print ("shaking frame " + str (frame-1))
			par.target.shaker.start("normal", par.target.unitSprite, 0.2, 50, 4)
			#par.target.unitSprite.offset += Vector2 (-10,0)
	pass # Replace with function body.

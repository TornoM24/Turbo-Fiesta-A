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
	get_parent().inRecovery = true
	get_parent().effCall()
	get_parent().yVelo = -1.7
	pass # Replace with function body.

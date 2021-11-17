extends Node2D
# DOES NOT WORK FOR MULTIPLE ENEMIES YET
var type = "enemy"
var speed = 100
var chasing = false
var original
var velocity = Vector2()

func _ready():
	Global.enemy = self
	original = Global.enemy.global_position
	pass # Replace with function body.
	
func _process(delta):
	if Global.player != null:
		if (chasing == true):
			velocity = global_position.direction_to(Global.player.global_position)
			global_position += velocity * speed * delta
		else:
			velocity = global_position.direction_to(original)
			global_position += velocity * speed * delta
	pass


func _on_Player_inBounds():
	chasing = true
	pass # Replace with function body.

func _on_Player_outBounds():
	chasing = false
	pass # Replace with function body.

extends Node2D
# DOES NOT WORK FOR MULTIPLE ENEMIES YET
var type = "enemy"
var speed = 100
var chasing = false
var original
var velocity = Vector2()
var bound = false

func _ready():
	connect("inBounds", get_tree().get_root().get_node("/root/Main/Player"), "_on_Player_inBounds", [bound])
	Global.enemy = self
	original = Global.enemy.global_position
	pass
	
func _process(delta):
	if Global.player != null:
		if (chasing == true):
			velocity = global_position.direction_to(Global.player.global_position)
			global_position += velocity * speed * delta
		else:
			velocity = global_position.direction_to(original)
			global_position += velocity * speed * delta
	pass

func _on_Player_inBounds(bound):
	chasing = bound
	pass # Replace with function body.

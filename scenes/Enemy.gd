extends Node2D

var speed = 100
var velocity = Vector2()
var chasing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func _process(delta):
	if (chasing == true):
		velocity = global_position.direction_to(Master.partyPosition)
		global_position += velocity * speed * delta
	pass


func _on_Player_inBounds():
	chasing = true
	pass # Replace with function body.

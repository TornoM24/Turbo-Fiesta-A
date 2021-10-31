extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var decay = false
var dTimer = 0
var offset
var velocity = Vector2(0, -1)
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func offset():
	rng.randomize()
	offset = Vector2(rng.randf_range(-10.0, 10.0),rng.randf_range(-10.0, 10.0))
	position += offset
func _process(delta):
	dTimer += delta
	if dTimer > 1:
		modulate.a -= delta * 1
	velocity.y += delta * 10
	if velocity.y < 2:
		position += velocity
	if modulate.a == 0:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

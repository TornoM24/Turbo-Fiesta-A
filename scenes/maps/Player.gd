extends KinematicBody2D

func _ready():
	print("Ready!")
	pass # Replace with function body.
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var speed = 200
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getInput():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 5
	if Input.is_action_pressed("left"):
		velocity.x -= 5
	if Input.is_action_pressed("up"):
		velocity.y -= 5
	if Input.is_action_pressed("down"):
		velocity.y += 5
	velocity = velocity.normalized() * speed



